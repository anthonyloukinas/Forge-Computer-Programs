-- update.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Updates core system components with the latest changes.

debugging = false

-- Imports
local utils = require("lib/utils")


-- Variables
local script_name = "update"
local version = "1.0"
local author = "Anthony Loukinas"
local description = "Updates core system components with the latest changes"

local url = "https://raw.githubusercontent.com/anthonyloukinas/Forge-Computer-Programs/main/init.lua"
local mbs_url = "https://raw.githubusercontent.com/SquidDev-CC/mbs/master/mbs.lua"


-- Arguments
local tArgs = {...}
if #tArgs == 0 then
    print("Usage: " .. script_name .. " init/mbs")
    return
end


-- Functions
function init()
    -- Set script name
    utils.set_name(script_name)

    if debugging then
        utils.set_debugging(debugging) -- Sets debugging to true/false for logging
        log("Debugging enabled.", "info")
    end
end

function main()
    if tArgs[1] == "init" then
        log("Updating init.lua...", "info")

        log("Removing old init.lua.", "debug")
        fs.delete("init.lua")

        log("Downloading new init.lua.", "debug")
        download(url, "init.lua")

        shell.run("./init.lua")
    elseif tArgs[1] == "mbs" then
        log("Updating mbs.lua...", "info")

        log("Removing old init.lua.", "debug")
        fs.delete("mbs.lua")

        log("Downloading new init.lua.", "debug")
        download(mbs_url, "mbs.lua")

        shell.run("./mbs.lua install")
    else
        log("Invalid argument.", "error")
        return
    end

    log("System initialized.", "info")
end


-- Main
init()
main()