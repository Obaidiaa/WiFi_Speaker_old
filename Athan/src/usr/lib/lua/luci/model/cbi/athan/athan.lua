m = Map("athan","Athan")

s = m:section(TypedSection, "Athan", "Athan Setting")
s.addremove = false
s.anonymous = true

enabled=s:option(Flag, "enabled", "Enabled","enable Athan")
enabled.rmempty = false

method=s:option(ListValue, "method", "Method", "Select the calculation method")
method:value('Jafari', 'Shia Ithna Ashari (Ja`fari)')
method:value('MWL', ' Muslim World League ')
method:value('ISNA', ' Islamic Society of North America ')
method:value('Egypt', ' Egyptian General Authority of Survey ')
method:value('Makkah', ' Umm al-Qura University, Makkah ')
method:value('Karachi', ' University of Islamic Sciences, Karachi ')
method:value('Tehran', ' Institute of Geophysics, University of Tehran ')


-- enabled=s:option(Flag, "fajr", "Fajr","enable Fajr Athan")
-- enabled.rmempty = false

-- enabled=s:option(Flag, "dhuhr", "Dhuhr","enable Dhuhr Athan")
-- enabled.rmempty = false

-- enabled=s:option(Flag, "asr", "Asr","enable Asr Athan")
-- enabled.rmempty = false

-- enabled=s:option(Flag, "maghrib", "Maghrib","enable Maghrib Athan")
-- enabled.rmempty = false

-- enabled=s:option(Flag, "isha", "Isha","enable Isha Athan")
-- enabled.rmempty = false


lat = s:option(Value, "Latitude", "Latitude","Your current Latitude")
lat.rmempty = false
long = s:option(Value, "Longitude", "Longitude","Your current Longitude")
long.rmempty = false


luci.template.render("athan/athan", {

})
s = m:section(TypedSection, "Pray_select", "Pray Select","Choose which Pray Athan will play")
s.addremove = false
s.anonymous = true

enabled=s:option(Flag, "fajr", "Fajr")
enabled.rmempty = false

enabled=s:option(Flag, "dhuhr", "Dhuhr")
enabled.rmempty = false

enabled=s:option(Flag, "asr", "Asr")
enabled.rmempty = false

enabled=s:option(Flag, "maghrib", "Maghrib")
enabled.rmempty = false

enabled=s:option(Flag, "isha", "Isha")
enabled.rmempty = false


return m

