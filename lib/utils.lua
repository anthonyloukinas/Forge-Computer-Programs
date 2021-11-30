-- utils.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: A collection of utility functions.

local debugging = false
local script_name = nil

function set_debugging(debug)
    debugging = debug
end

function set_name(name)
    script_name = name
end

function log(message, level, script)
    
    if script ~= nil then
        script_name = script
    end
    
    if level == nil then
        level = "info"
        print("[" .. script_name .. "] [info] " .. message)
    elseif level == "info" then
        print("[" .. script_name .. "] [info] " .. message)
    elseif level == "warn" then
        print("[" .. script_name .. "] [warn] " .. message)
    elseif level == "error" then
        print("[" .. script_name .. "] [error] " .. message)
    elseif level == "fatal" then
        print("[" .. script_name .. "] [fatal] " .. message)
    elseif level == "debug" then
        if debugging ~= nil then
            if debugging then
                print("[" .. script_name .. "] [debug] " .. message)
            end
        end
    end
end

function download(url, file)
    local content = http.get(url).readAll()
    if not content then
      error("[system] Could not connect to GitHub")
    end
    f = fs.open(file, "w")
    f.write(content)
    f.close()
end

return { log = log, set_debugging = set_debugging, download = download }