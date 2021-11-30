-- wipe.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Wipe the current computer

debugging = false

-- Imports
local utils = require("lib/utils")

-- Variables
local script_name = "wipe"
local version = "0.1"
local author = "Anthony Loukinas"
local description = "Wipe the current computer."
local base_github_url = "https://raw.githubusercontent.com/anthonyloukinas/Forge-Computer-Programs/main/"

-- Arguments
local tArgs = { ... }

if #tArgs == 0 then
  local programName = arg[0] or fs.getName(shell.getRunningProgram())
  print("Usage: " .. programName .. " yes")
  return
end

-- Functions
function init()

    utils.set_name(script_name)

    if debugging then
        utils.set_debugging(debugging) -- Sets debugging to true/false for logging
        log("Debugging enabled.", "info")
    end
end

function main()
    if tArgs[1] == "yes" then
        log("Wiping computer...", "info")
        os.sleep(1)

        files = fs.list("/")

        for i = 1, #files do
            if files[i] ~= "wipe.lua" and files[i] ~= "rom" and files[i] ~= "logs" then
                fs.delete(files[i])
            end
        end

        log("Computer successfully wiped.", "info")
    else
        log("Wiping computer cancelled.", "info")
    end
end

-- Main
init()
main()