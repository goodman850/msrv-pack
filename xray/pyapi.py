import requests
import json
import os
import subprocess

config_path = "/etc/xray/config.json"
traffic_path = "/var/www/html/p/log/das"
dcp_path = "/var/www/html/p/log/dcp"

def readIp():
    with open("/var/www/html/p/log/ip", "r") as file:
        return file.read()

def readToken():
    with open("/var/www/html/p/log/token", "r") as file:
        return file.read()

def readDas():
    with open("/var/www/html/p/log/das", "r") as file:
        if os.path.getsize("/var/www/html/p/log/das") == 0:
            return {}
        else:
            return json.load(file)
    
def readDyToken():
    with open("/var/www/html/p/log/dcp", "r") as file:
        return file.read()

def readXray():
    with open(config_path, "r") as file:
        return json.load(file)
 
def writeXray(xray_config):
    json_object = json.dumps(xray_config, indent=9)    
    with open(config_path, "w") as file:
        file.write(json_object)

def writeTraff(data):
    #json_object = json.dump(data, indent=9)  
    with open(traffic_path, "w") as file:
        json.dump(data, file)

def getToken():
    address = f"https://{readIp()}/apiV2/api.php"
    data = {'token': readToken(),
            'inialize': 'dcp'}
    res = requests.post(address, data=data)
    print("getToken response:", res.text)
    
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

def sendRequest():
    address = f"https://{readIp()}/apiV2/api.php"
    data = {'token': readToken(),
            'getuserAPI': 'dashampython'}
    res = requests.post(address, data=data)
    print("sendRequest response:",res.status_code)    
    return json.loads(res.text)

def sendTraffic(traff):
    address = f"https://{readIp()}/apiV2/api.php"
    traff_json = json.dumps(traff)
    data = {'token': readToken(),
            'dynamic': readDyToken(),
            'method': 'syncdatausagev2ry',
            'trafficUsages': traff_json}
    res = requests.post(address, data=data)
    print("sendTraffic response:", res.text)
    
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
    
if not os.path.exists(dcp_path) or os.path.getsize(dcp_path) == 0:
    with open(dcp_path, 'w') as file:
        your_variable = getToken()
        file.write(your_variable)
    print(f"File  did not exist or was empty and has been created.")
else:
    print(f"File already exists and is not empty.")

if not os.path.exists(traffic_path) or os.path.getsize(traffic_path) == 0:
    with open(traffic_path, 'w') as file:
        json_object = json.dumps({"inbound": 0, "api": {},"users": {}})   
        file.write(json_object)
    print(f"File  did not exist or was empty and has been created.")
else:
    print(f"File already exists and is not empty.")

print("Starting...")
print("Sending request...")
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

if "inbounds" in xrayConfig and "inbounds" in newXrayConfig :
    # Compare the values associated with the "inbounds" key
    if xrayConfig["inbounds"] != newXrayConfig["inbounds"]:
        print("Writing file....")
        writeXray(newXrayConfig)
        os.system('systemctl restart xray')

print("xray api statsquery...")
command = "xray api statsquery --server=127.0.0.1:10085"
output = subprocess.check_output(command, shell=True, text=True)
data = json.loads(output)

stats_received = [stat for stat in data["stat"]]
user_lastdata = readDas()
user_usage = {}
buffer = {}
reseted = False
# if len(user_data) < 3:
#     user_data={}
# else:
#     print("user_data is not empty")
# print("==========================================================================\n\n")
# print("First Last Data Read: ", user_lastdata)
# print("\n\n==========================================================================")
for user_stat in stats_received:
    if(user_stat["name"] == "inbound>>>api>>>traffic>>>downlink"):
        if(int(user_stat["value"])<int(user_lastdata["inbound"]) or int(user_lastdata["inbound"])==0):
            reseted = True
        user_lastdata["inbound"] = int(user_stat["value"])

for user_stat in stats_received:
    if(user_stat["name"].find("user>>>") != -1):
        username = user_stat["name"].split(">>>")[1].split("@")[0]
        if(username in user_usage):
            continue
        else:
            user_usage[username] = {"TX": 0, "RX": 0}
            buffer[username] = {"TX": 0, "RX": 0}
        for user_atall in stats_received:
            if(user_atall["name"].find(username) != -1):
                if(user_atall["name"].split(">>>")[3] == "downlink"):
                    user_usage[username]["RX"] += int(user_atall["value"]) 
                    buffer[username]["RX"] += int(user_atall["value"]) 
                if(user_atall["name"].split(">>>")[3] == "uplink"):
                    user_usage[username]["TX"] += int(user_atall["value"])
                    buffer[username]["TX"] += int(user_atall["value"])
        if(username not in user_lastdata["users"]):
            user_lastdata["users"][username] = {"TX": 0, "RX": 0}
        if(not reseted):
            user_usage[username]["RX"] -= int(user_lastdata["users"][username]["RX"])
            user_usage[username]["TX"] -= int(user_lastdata["users"][username]["TX"])

        # print("***********************************************************\n\n")
        # print(user_usage)
        # print("\n\n***********************************************************")

user_lastdata["users"] = buffer

# for user in user_usage:
#     user_usage[user]["RX"] = float(user_usage[user]["RX"]) / 1048576
#     user_usage[user]["TX"] = float(user_usage[user]["TX"]) / 1048576

# print("//////////////////////////////////////////////////////////////////////////\n\n")
# print("Buffer: ",buffer)
# print("\n--------------")
# print("LastData: ",user_lastdata)
# print("\n--------------")
# print("UserUsage: ",user_usage)
# print("\n\n//////////////////////////////////////////////////////////////////////////")
# print("sending traffics...")

token = sendTraffic(user_usage)
writeTraff(user_lastdata)

with open('/var/www/html/p/log/dcp', 'w') as token_file:
    token_file.write(token)

print("Done")
