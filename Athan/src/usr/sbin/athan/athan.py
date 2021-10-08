#!/usr/bin/env python

import datetime
import time
import sys
#sys.path.insert(0, '/home/pi/adhan/crontab')
import subprocess

from praytimes import PrayTimes
PT = PrayTimes() 

from crontab import CronTab
system_cron = CronTab(user='root')

now = datetime.datetime.now()
strPlayFajrAzaanMP3Command = 'madplay /usr/sbin/athan/sound/athan.mp3'
strPlayAzaanMP3Command = 'madplay /usr/sbin/athan/sound/athan.mp3'
strUpdateCommand = 'python3 /etc/test/test.py >> /etc/test/test.log 2>&1'
strClearLogsCommand = 'truncate -s 0 /etc/test/test.log 2>&1'
strJobComment = 'rpiAdhanClockJob'

AthanEnabled = float(subprocess.run(['uci', 'get','athan.@Athan[0].enabled'], stdout=subprocess.PIPE).stdout.decode('utf-8')) 
#Set which pray to athan

fajr = float(subprocess.run(['uci', 'get','athan.@Pray_select[0].fajr'], stdout=subprocess.PIPE).stdout.decode('utf-8')) 
dhuhr = float(subprocess.run(['uci', 'get','athan.@Pray_select[0].dhuhr'], stdout=subprocess.PIPE).stdout.decode('utf-8')) 
asr = float(subprocess.run(['uci', 'get','athan.@Pray_select[0].asr'], stdout=subprocess.PIPE).stdout.decode('utf-8')) 
maghrib = float(subprocess.run(['uci', 'get','athan.@Pray_select[0].maghrib'], stdout=subprocess.PIPE).stdout.decode('utf-8')) 
isha = float(subprocess.run(['uci', 'get','athan.@Pray_select[0].isha'], stdout=subprocess.PIPE).stdout.decode('utf-8')) 


#Set latitude and longitude here
#--------------------
lat = float(subprocess.run(['uci', 'get','athan.@Athan[0].Latitude'], stdout=subprocess.PIPE).stdout.decode('utf-8'))
# 21.4878
long = float(subprocess.run(['uci', 'get','athan.@Athan[0].Longitude'], stdout=subprocess.PIPE).stdout.decode('utf-8'))
# 39.1936

print(lat)
print(long)
#Set calculation method, utcOffset and dst here
#By default system timezone will be used
#--------------------
PT.setMethod(subprocess.run(['uci', 'get','athan.@Athan[0].method'], stdout=subprocess.PIPE).stdout.decode('utf-8'))
utcOffset = -(time.timezone/3600)
isDst = time.localtime().tm_isdst


#HELPER FUNCTIONS
#---------------------------------
#---------------------------------
#Function to add azaan time to cron
def addAzaanTime (strPrayerName, strPrayerTime, objCronTab, strCommand):
  job = objCronTab.new(command=strCommand,comment=strPrayerName)  
  timeArr = strPrayerTime.split(':')
  hour = timeArr[0]
  min = timeArr[1]
  job.minute.on(int(min))
  job.hour.on(int(hour))
  job.set_comment(strJobComment)
  print(job)
  return

def addUpdateCronJob (objCronTab, strCommand):
  job = objCronTab.new(command=strCommand)
  job.minute.on(15)
  job.hour.on(3)
  job.set_comment(strJobComment)
  print(job)
  return

def addClearLogsCronJob (objCronTab, strCommand):
  job = objCronTab.new(command=strCommand)
  job.day.on(1)
  job.minute.on(0)
  job.hour.on(0)
  job.set_comment(strJobComment)
  print(job)
  return
#---------------------------------
#---------------------------------
#HELPER FUNCTIONS END

# Remove existing jobs created by this script
system_cron.remove_all(comment=strJobComment)

# Calculate prayer times
times = PT.getTimes((now.year,now.month,now.day), (lat, long), utcOffset, isDst) 
print(times['fajr'])
print(times['dhuhr'])
print(times['asr'])
print(times['maghrib'])
print(times['isha'])

# Add times to crontab
if fajr > 0 and AthanEnabled > 0: 
  addAzaanTime('fajr',times['fajr'],system_cron,strPlayFajrAzaanMP3Command)

if dhuhr > 0 and AthanEnabled > 0:
  addAzaanTime('dhuhr',times['dhuhr'],system_cron,strPlayAzaanMP3Command)

if asr > 0 and AthanEnabled > 0:
  addAzaanTime('asr',times['asr'],system_cron,strPlayAzaanMP3Command)

if maghrib > 0 and AthanEnabled > 0:
  addAzaanTime('maghrib',times['maghrib'],system_cron,strPlayAzaanMP3Command)

if isha > 0 and AthanEnabled > 0:      
  addAzaanTime('isha',times['isha'],system_cron,strPlayAzaanMP3Command)

# Run this script again overnight
addUpdateCronJob(system_cron, strUpdateCommand)

# Clear the logs every month
addClearLogsCronJob(system_cron,strClearLogsCommand)

system_cron.write_to_user(user='root')
print ('Script execution finished at: ' + str(now))

