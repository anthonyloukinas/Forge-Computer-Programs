-- utils.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: A collection of utility functions.

function log(message, level, script)
    if level == nil then
        level = "INFO"
    elseif level == "INFO" then
        print("[" .. script .. "] " .. message)
    elseif level == "WARN" then
        print("[" .. script .. "] [WARN] " .. message)
    elseif level == "ERROR" then
        print("[" .. script .. "] [ERROR] " .. message)
    elseif level == "FATAL" then
        print("[" .. script .. "] [FATAL] " .. message)
    end
end