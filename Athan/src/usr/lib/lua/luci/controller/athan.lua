module("luci.controller.athan",package.seeall);

function index()
    if not nixio.fs.access("/etc/config/athan") then 
        return 
    end

    local page = entry({"admin","Athan"},cbi("athan/athan"),_("Athan"))
    page.dependent = true

    entry({"admin", "Athan", "uploadAthan"}, call("upload_athan"))

    entry({"admin", "Athan", "playAthan"}, call("play_athan"))
    entry({"admin", "Athan", "stopAthan"}, call("stop_athan"))
end

function stop_athan()
    luci.http.prepare_content("text/plain")
    -- luci.http.write("Haha, rebooting now...")
    luci.sys.call("kill `pidof madplay`")
end


function play_athan()
    luci.http.prepare_content("text/plain")
    luci.http.write("Haha, rebooting now...")
    -- luci.sys.reboot()
    -- local file_found = io.open("/usr/sbin/athan/sound/athan.mp3", "r")
    -- fileopened = (#fd:read("a*") > 0)
    -- luci.http.write(file_found)
    luci.sys.call("madplay /usr/sbin/athan/sound/athan.mp3")
    
end

function upload_athan()
    local error = nil	
    --add your defaults (file_name is optional btw)
    file_loc = "/usr/sbin/athan/sound/"
    input_field = "athan"
    file_name = "athan.mp3"
    --actually call the file handler
    --get the values from the forms on the page
    local values = luci.http.formvalue()

 
    --get the value of the input field
    local ul = values[input_field]
    -- luci.http.prepare_content("text/plain")

    --make sure something is being uploaded
    if ul ~= '' and ul ~= nil then
       --Start your uploader
       setFileHandler(file_loc, input_field, file_name)
    else
        luci.http.write("error")
       --Run whatever check you need against the file to make sure it is
--  accurate. Return nil if all is ok. (this function not included in this
--  mini-tutorial)
    --    error = checkFile(file_loc)
    -- error = "tests"

    end
    -- luci.http.redirect("/cgi-bin/luci/admin/Athan", {error=error})
 end
 
 --setFileHandler (stolen from sysUpgrade)
 --location: (string) The full path to where the file should be saved.
 --input_name: (string) The name specified by the input html field.
--  <input type="submit" name="input_name_here" value="whatever you want"/>
 --file_name: (string, optional) The optional name you would like the
--  file to be saved as. If left blank the file keeps its uploaded name.
 function setFileHandler(location, input_name, file_name)
       local sys = require "luci.sys"
       local fs = require "nixio.fs"
       local fp
       luci.http.setfilehandler(
          function(meta, chunk, eof)
          if not fp then
             --make sure the field name is the one we want
             if meta and meta.name == input_name then
                --use the file name if specified
                if file_name ~= nil then
                   fp = io.open(location .. file_name, "w")
                else
                   fp = io.open(location .. meta.file, "w")
                end
             end
          end
          --actually do the uploading.
          if chunk then
             fp:write(chunk)
          else
            luci.http.write("error")
          end
          if eof then
             fp:close()
             luci.http.write("File uploaded")
            end
        end)
 end
 

