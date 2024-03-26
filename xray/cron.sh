crontab -l | grep -v '/syncdb.php'  | crontab  -
crontab -l | grep -v '/pyapi.py'  | crontab  -
cron_job1="* * * * * sudo python3 /var/www/html/p/log/pyapi.py >/dev/null 2>&1"
cron_job2="* * * * * sudo php /var/www/html/syncdb.php >/dev/null 2>&1"
(crontab -l ; echo "$cron_job1" ; echo "$cron_job2"; ) | crontab -