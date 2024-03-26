import requests
import json
import os
import subprocess

config_path = "/etc/xray/config.json"

traffic_path = "/var/www/html/p/log/das"

def readIp():
    with open("/var/www/html/p/log/ip") as file:
        return file.read()

def readToken():
    with open("/var/www/html/p/log/token") as file:
        return file.read()

def readDas():
    with open("/var/www/html/p/log/das") as file:
        return file.read()
    
def readDyToken():
    with open("/var/www/html/p/log/dcp") as file:
        return file.read()

def sendRequest():
    address = f"https://{readIp()}/sd/apiV2/api.php"
    data = {'token': readToken(),
            'getuserAPI': 'dashampython'}
    res = requests.post(address, data=data)
    print("response:",res.status_code)    
    return json.loads(res.text)

def sendTraffic(traff):
    address = f"https://{readIp()}/sd/apiV2/api.php"
    traff_json = json.dumps(traff)
    data = {'token': readToken(),
            'dynamic': readDyToken(),
            'method': 'syncdatausagev2ry',
            'trafficUsages': traff_json}
    res = requests.post(address, data=data)
    print("response:", res.text)
    
    if res.status_code == 200:
        response_data = json.loads(res.text)
        if 'token' in response_data:
            token = response_data['token']
            # Save the token to a file
            with open('/var/www/html/p/log/dynamic', 'w') as token_file:
                token_file.write(token)
            return token
        else:
            print("Token not found in the response")
    else:
        print("Failed to get a valid response")
        return None
    
def getToken():
    address = f"https://{readIp()}/sd/apiV2/api.php"
    data = {'token': readToken(),
            'inialize': 'dcp'}
    res = requests.post(address, data=data)
    print("response:", res.text)
    
    if res.status_code == 200:
        response_data = json.loads(res.text)
        if 'token' in response_data:
            token = response_data['token']
            # Save the token to a file
            with open('/var/www/html/p/log/dcp', 'w') as token_file:
                token_file.write(token)
            return token
        else:
            print("Token not found in the response")
    else:
        print("Failed to get a valid response, try again ")
        return None

def readXray():
    with open(config_path) as file:
        return json.load(file)
 
def writeXray(xray_config):
    json_object = json.dumps(xray_config, indent=4)    
    with open(config_path, "w") as file:
        file.write(json_object)

def writeTraff(traffic_path11):
    json_object = json.dumps(traffic_path11, indent=4)    
    with open(traffic_path, "w") as file:
        file.write(json_object)

print("Starting...")
print("Sending request...")
        
file_path = "/var/www/html/p/log/dcp"



if not os.path.exists(file_path) or os.path.getsize(file_path) == 0:
    with open(file_path, 'w') as file:
        your_variable = getToken()
        file.write(your_variable)
    print(f"File  did not exist or was empty and has been created.")
else:
    print(f"File already exists and is not empty.")




config = sendRequest()
#--------------------------------------------------------- extract request data
#for method in config["usersdata"]:
#    print("=================================")
#    print(method,":")
#    print(config["usersdata"][method])    
#for port in config["ports"]:
#    print("=================================")
#    print(port,":")
#    print(config["ports"][port])    
#---------------------------------------------------------
print("Reading xray confing...")
xrayConfig = readXray()
newXrayConfig = readXray()
print("Replacing....")
for i in range(len(xrayConfig["inbounds"])):
    if(xrayConfig["inbounds"][i]["protocol"] == "vless"):
        if(xrayConfig["inbounds"][i]["streamSettings"]["security"] == "tls"):
            newXrayConfig["inbounds"][i]["settings"]["clients"] = config["usersdata"]["VLESSTLS"]
            newXrayConfig["inbounds"][i]["port"] = config["ports"]["VLESSTLS"]
        if(xrayConfig["inbounds"][i]["streamSettings"]["security"] == "none"):
            newXrayConfig["inbounds"][i]["settings"]["clients"] = config["usersdata"]["VLESS"]
            newXrayConfig["inbounds"][i]["port"] = config["ports"]["VLESS"]
        if(xrayConfig["inbounds"][i]["streamSettings"]["security"] == "reality"):
            newXrayConfig["inbounds"][i]["settings"]["clients"] = config["usersdata"]["VLESSREALITY"]
            newXrayConfig["inbounds"][i]["port"] = config["ports"]["VLESSREALITY"]
            newXrayConfig["inbounds"][i]["streamSettings"]["realitySettings"]["privateKey"] = config["ports"]["PK"]
            newXrayConfig["inbounds"][i]["streamSettings"]["realitySettings"]["shortIds"] = config["ports"]["SHORTS"]
    elif(xrayConfig["inbounds"][i]["protocol"] == "trojan"):
        newXrayConfig["inbounds"][i]["settings"]["clients"] = config["usersdata"]["TROJAN"]
        newXrayConfig["inbounds"][i]["port"] = config["ports"]["TROJAN"]




command = "xray api statsquery --server=127.0.0.1:10085"

output = subprocess.check_output(command, shell=True, text=True)

data = json.loads(output)

user_stats = [stat for stat in data["stat"] if stat["name"].startswith("user>>>")]
user_data = readDas()
user_data1 ={}
user_data2 ={}  #as online va hajm
for user_stat in user_stats:
    name_parts = user_stat['name'].split(">>>")
    user_id = name_parts[1]  
    value = float(user_stat['value']) / 1048576  # Convert value to float and convert to MB

    if user_id not in user_data:
        user_data[user_id] = {'TX': 0, 'RX': 0}  

    if user_id not in user_data1:
        user_data1[user_id] = {'TX': 0, 'RX': 0}  
    if user_id not in user_data2:
        user_data2[user_id] = {'TX': 0, 'RX': 0}  


    if name_parts[3] == "uplink":
        if user_data[user_id]['TX'] > value:
            user_data1[user_id]['TX'] = value
            user_data2[user_id]['TX'] = value
        else :
            user_data1[user_id]['TX'] =  value
            user_data2[user_id]['TX'] = value-user_data[user_id]['TX']

      
    elif name_parts[3] == "downlink":
        if user_data[user_id]['RX'] > value:
            user_data1[user_id]['RX'] = value
            user_data2[user_id]['RX'] = value
        else :
            user_data1[user_id]['RX'] = value
            user_data2[user_id]['RX'] = value-user_data[user_id]['TX']


 

print("sending traffics...")

token = sendTraffic(user_data2)
writeTraff(user_data1)

with open('/var/www/html/p/log/dcp', 'w') as token_file:
    token_file.write(token)


    flag=0
if "inbounds" in xrayConfig and "inbounds" in newXrayConfig :
    # Compare the values associated with the "inbounds" key
    if xrayConfig["inbounds"] != newXrayConfig["inbounds"]:
        print("Writing file....")
        writeXray(newXrayConfig)
        os.system('systemctl restart xray')
        flag=1

if not os.path.exists(traffic_path) or os.path.getsize(traffic_path) == 0:
    with open(traffic_path, 'w') as file:
        your_variable = user_data
        file.write(your_variable)
        flag=0
        
    print(f"File  did not exist or was empty and has been created.")
else:
    print(f"File already exists and is not empty.")
    with open(traffic_path, 'w') as file:
        your_variable = user_data
        file.write(your_variable)
        flag=1

print("Done")
