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
local base_github_url = "https://raw.githubusercontent.com/anthonyloukinas/Forge-Computer-Programs/main/"

-- Script Data
local package_data = {}

-- Arguments
local tArgs = { ... }

if #tArgs == 0 then
  local programName = arg[0] or fs.getName(shell.getRunningProgram())
  print("Usage: " .. programName .. " list/install/uninstall/autostart")
  return
end

-- Functions
function init()

    -- Ensure JSON is available 
    os.loadAPI("json")

    if debugging then
        utils.set_debugging(debugging) -- Sets debugging to true/false for logging
        log("Debugging enabled.", "info", script_name)
    end

    -- Load package list
    log("Loading package list", "debug", script_name)
    local packages = http.get(base_github_url .. "/package-list.json").readAll() -- TODO check if error
    package_data = json.decode(packages)
    log("Package list loaded. Found " .. #package_data.packages .. " packages", "debug", script_name)
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
    elseif tArgs[1] == "update" then
        update()
    else
        log("Invalid argument.", "error", script_name)
    end

end

function list() 
    
    if package_data ~= nil and #package_data.packages > 0 then
        for i = 1, #package_data.packages do
            print(data.packages[i].name .. "@" .. data.packages[i].version .. " - " .. data.packages[i].description)
        end
    else
        log("No packages found.", "error", script_name)
    end

end

function install(pkg) 

    if pkg == nil then
        log("No package specified.", "error", script_name)
        return
    end

    local found = false
    for i = 1, #package_data.packages do
        if package_data.packages[i].name == pkg then
            found = true
            break
        end
    end

    if not found then
        log("Package not found.", "error", script_name)
        return
    end

    local url = base_github_url .. "/" .. pkg .. ".lua"
    local file = fs.open(pkg .. ".lua", "w")
    file.write(http.get(url).readAll())
    file.close()
    log("Package " .. pkg .. " installed.", "info", script_name)

end

function uninstall(pkg) end
function autostart(pkg) end
function update() end


-- Main
init()
main()