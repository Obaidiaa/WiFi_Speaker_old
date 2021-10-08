module("luci.controller.airspeaker",package.seeall);

function index()
    if not nixio.fs.access("/etc/config/shairport-sync") then 
        return 
    end

    local page = entry({"admin","AirSpeaker"},cbi("airspeaker/airspeaker"),_("AirSpeaker"))
    page.dependent = true
end
