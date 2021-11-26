-- utils.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: A collection of utility functions.

function log(message, level, script)
    if level == nil then
        level = "info"
        print("[" .. script .. "] [info] " .. message)
    elseif level == "info" then
        print("[" .. script .. "] [info] " .. message)
    elseif level == "warn" then
        print("[" .. script .. "] [warn] " .. message)
    elseif level == "error" then
        print("[" .. script .. "] [error] " .. message)
    elseif level == "fatal" then
        print("[" .. script .. "] [fatal] " .. message)
    elseif debug == "debug" then
        if debugging ~= nil then
            if debugging then
                print("[" .. script .. "] [debug] " .. message)
            end
        end
    end
end

return { log = log }