-- configure.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Configuring client computer to use with server

debugging = false

-- Imports
local utils = require("lib/utils")

-- Variables
local script_name = "configure"
local version = "1.0.0"
local author = "Anthony Loukinas"
local description = "Configuring client computer to use with server"

-- Config
local config = {}

-- Functions
function init()
    if debugging then
        utils.set_debugging(debugging) -- Sets debugging to true/false for logging
        log("Debugging enabled.", "info", script_name)
    end

    log(script_name .. " v" .. version .. " by " .. author .. " loaded.", "info", script_name)
end

function main()
    write("Server Address: ")
    local server_address = read()

    write("Hostname: ")
    local hostname = read()

    http.post("http://" .. server_address .. "/api/v1/configure", "hostname="..hostname)
end


-- Main
init()
main()