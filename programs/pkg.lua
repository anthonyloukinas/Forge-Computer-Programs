-- pkg.lua
-- 
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Package manager for my scripts.

debugging = false

-- Imports
local utils = require("../lib/utils")

-- Variables
local script_name = "pkg"
local version = "0.1"
local author = "Anthony Loukinas"
local description = "Package manager for my scripts."


-- Arguments
local tArgs = { ... }

if #tArgs ~= 2 then
  local programName = arg[0] or fs.getName(shell.getRunningProgram())
  print("Usage: " .. programName .. " list/install/uninstall/autostart")
  return
end

-- Functions
function init()

    if debugging then
        utils.set_debugging(debugging) -- Sets debugging to true/false for logging
        log("Debugging enabled.", "info", script_name)
    end

    log(script_name .. " v" .. version .. " by " .. author .. " loaded.", "info", script_name)
end

function main()

    if tArgs[1] == "list" then
        list()
    elseif tArgs[1] == "install" then
        install(tArgs[2])
    elseif tArgs[1] == "uninstall" then
        uninstall(tArgs[2])
    elseif tArgs[1] == "autostart" then
        autostart(tArgs[2])
    else
        log("Invalid argument.", "error", script_name)
    end

end

function list() end
function install(pkg) end
function uninstall(pkg) end
function autostart(pkg) end


-- Main
init()
main()