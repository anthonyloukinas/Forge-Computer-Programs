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
config.ptype = "BigReactors-Reactor" -- ExtremeReactors MC1.20.1 (ATM9)

-- Script Variables
local reactor = {}
local monitor = {}

-- Functions
function init()
    monitors = { peripheral.find("monitor") }

    if debugging then
        utils.set_debugging(debugging) -- Sets debugging to true/false for logging
        log("Debugging enabled.", "info", script_name)
    end

    -- Allow 5 attempts at discovering the BiggerReactr or ExtremeReactor interface
    local loopI = 0
    while loopI ~= 5 do

        -- BiggerReactors v0.5.1 (MC-1.16.5)
        if peripheral.find(config.ptype) ~= nil then
            reactors = { peripheral.find(config.ptype) }
            break
        end

        sleep(1)
        loopI = loopI + 1
    end

    if monitors[1] == nil then
        log("No monitors detected. Disabling feature.", "warn", script_name)
    else
        monitor = monitors[1]
        log("Monitor detected. Enabling feature.", "info", script_name)
    end

    if reactors[1] == nil then
        log("No reactors detected. Disabling Script.", "error", script_name)
        error("No reactors detected, exiting script")
    end

    reactor = reactors[1]

    log(script_name .. " v" .. version .. " by " .. author .. " loaded.", "info", script_name)
end

function main()
    while true do
        if pcall(loop) then
            log("Loop completed successfully", "debug", script_name)
        else
            log("Loop failed", "error", script_name)
        end
    end
end

function loop()
    reactor.is_active = reactor.getActive()

    reactor.energy_stored = reactor.getEnergyStored()
    reactor.energy_capacity = reactor.getEnergyCapacity()
    reactor.energy_percentage = math.floor((reactor.energy_stored / reactor.energy_capacity) * 100)

    reactor.fuel_stored = reactor.getFuelAmount()
    reactor.fuel_capacity = reactor.getFuelAmountMax()
    reactor.fuel_percentage = math.floor((reactor.fuel_stored / reactor.fuel_capacity) * 100)

    if reactor.fuel_stored == 0 then
        log("No fuel detected. Waiting 60s for fuel", "warning", script_name)
        sleep(60)
    else
        -- If energy percentage is below the config value, activate the reactor
        if reactor.energy_percentage < config.energy_toggle_percent then
            log("Reactor battery below threshold of " .. config.energy_toggle_percent .. "%", "debug", script_name)
            if not reactor.is_active then
                log("Reactor is inactive, activating.", "info", script_name)
                reactor.setActive(true)
            end
        -- Else if energy percentage is above the config value, deactivate the reactor
        else
            log("Reactor battery above threshold of " .. config.energy_toggle_percent .. "%", "debug", script_name)
            if reactor.is_active then
                log("Reactor is active, deactivating.", "info", script_name)
                reactor.setActive(false)
            end
        end

        -- Update monitor with updated information
        if monitors[1] ~= nil then
            update_monitor()
        end

        log("Sleeping for 5s", "debug", script_name)
        sleep(5)
    end
end

function update_monitor()
    monitor.clear()
    monitor.setTextScale(0.5)
    monitor.setCursorPos(1, 1)
    monitor.write("Reactor: " .. (reactor.is_active and "Active" or "Inactive"))
    monitor.setCursorPos(1, 2)
    monitor.write("Energy Stored: " .. reactor.energy_stored .. " RF")
    monitor.setCursorPos(1, 3)
    monitor.write("Energy Capacity: " .. reactor.energy_capacity .. " RF")
    monitor.setCursorPos(1, 4)
    monitor.write("Energy Percentage: " .. reactor.energy_percentage .. "%")
    monitor.setCursorPos(1, 5)
    monitor.write("Fuel Stored: " .. reactor.fuel_stored .. " mB")
    monitor.setCursorPos(1, 6)
    monitor.write("Fuel Capacity: " .. reactor.fuel_capacity .. " mB")
    monitor.setCursorPos(1, 7)
    monitor.write("Fuel Percentage: " .. reactor.fuel_percentage .. "%")
end


-- Main
init()
main()