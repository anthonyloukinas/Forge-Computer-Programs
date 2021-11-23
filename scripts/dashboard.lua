-- dashboard.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Displays information about several mods, as they relate
--           to our modpack/base setup.


-- Variables
local version = "1.0.0"

local monitors = {}
local storages = {}

local log_levels = {
    [0] = "INFO",
    [1] = "WARNING",
    [2] = "ERROR",
    [3] = "FATAL"
}

-- Functions
function log(message, level)
    if level == nil then
        level = "INFO"
    elseif level == "INFO" then
        print("[Dashboard] " .. message)
    elseif level == "WARN" then
        print("[Dashboard] [WARN] " .. message)
    elseif level == "ERROR" then
        print("[Dashboard] [ERROR] " .. message)
    elseif level == "FATAL" then
        print("[Dashboard] [FATAL] " .. message)
    end
end

function init()
    monitors = { peripheral.find("monitor") }

    -- Allow 5 attempts at discovering the RefinedStorage network
    local loopI = 0
    while loopI ~= 5 do

        if peripheral.find("refinedstorage") ~= nil then
            storages = { peripheral.find("refinedstorage") }
            break
        end

        sleep(1)
        loopI = loopI + 1
    end

    if monitors[1] == nil then
        log("Monitor is not detected", "FATAL")
    end

    if storages[1] == nil then
        log("RefinedStorage is not detected", "ERROR")
    end

    print("[log] dashboard.lua " .. version .. " script initialized")
end


-- Main
init()