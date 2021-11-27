-- manager.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Manages BiggerReactor/ExtremeReactor's energy efficiency.

debugging = false

-- Imports
local utils = require("../../lib/utils")


-- Variables
local script_name = "manager"
local version = "1.0.0"
local author = "Anthony Loukinas"
local description = "Manages BiggerReactor/ExtremeReactor's energy efficiency."

-- Config
local config = {}
config.energy_toggle_percent = 80

-- Script Variables
local reactor = {}


-- Functions
function init()
    monitors = { peripheral.find("monitor") }

    -- Allow 5 attempts at discovering the RefinedStorage network
    local loopI = 0
    while loopI ~= 5 do

        -- BiggerReactors v0.5.1 (MC-1.16.5)
        if peripheral.find("BiggerReactors_Reactor") ~= nil then
            reactors = { peripheral.find("BiggerReactors_Reactor") }
            break
        end

        sleep(1)
        loopI = loopI + 1
    end

    if monitors[1] == nil then
        log("No monitors detected.", "error", script_name)
    end

    if reactors[1] == nil then
        log("No reactors detected.", "error", script_name)
        error("No reactors detected, exiting script")
    end

    reactor = reactors[1]

    log(script_name .. " v" .. version .. " by " .. author .. " loaded.", "info", script_name)
end

function main()
    while true do
        
        local is_active = reactor.active()
        local energy_stored = reactor.battery().stored()
        local energy_capacity = reactor.battery().capacity()
        local energy_percentage = math.floor((energy_stored / energy_capacity) * 100)

        local fuel_stored = reactor.fuelTank().fuel()
        local fuel_capacity = reactor.fuelTank().capacity()
        local fuel_percentage = math.floor((fuel_stored / fuel_capacity) * 100)

        -- Reactor Monitor
        -- local monitor_text = "Reactor: " .. (is_active and "Active" or "Inactive") .. "\n"
        -- monitor_text = monitor_text .. "Energy Stored: " .. energy_stored .. " RF\n"
        -- monitor_text = monitor_text .. "Energy Capacity: " .. energy_capacity .. " RF\n"
        -- monitor_text = monitor_text .. "Energy Percentage: " .. energy_percentage .. "%\n"

        if fuel_stored == 0 then
            log("No fuel detected. Waiting 60s for fuel", "warning", script_name)
            sleep(60)
        else
            -- If energy percentage is below the config value, activate the reactor
            if energy_percentage < config.energy_toggle_percent then
                if not is_active then
                    log("Reactor is inactive, activating.", "info", script_name)
                    reactor.setActive(true)
                end
            -- Else if energy percentage is above the config value, deactivate the reactor
            else
                if is_active then
                    log("Reactor is active, deactivating.", "info", script_name)
                    reactor.setActive(false)
                end
            end

            log("Sleeping for 5s", "debug", script_name)
            sleep(5)
        end
    end
end


-- Main
init()
main()