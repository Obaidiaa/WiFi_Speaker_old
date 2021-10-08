m = Map("shairport-sync","AirSpeaker")

s = m:section(TypedSection, "shairport-sync", "")
s.addremove = false
s.anonymous = true

enabled=s:option(Flag, "enabled", "Enabled","enable auto start for the services")
enabled.rmempty = false

respawn=s:option(Flag, "respawn", "Respawn","restart after failure")
respawn.default = false

apname = s:option(Value, "name", "Device Name","the name that appear in your phone")
apname.rmempty = true



return m
