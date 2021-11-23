-- stair_shaft.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Mines a shaft down to bedrock, and places torches


-- Variables
local version = "1.0.0"
local author = "Anthony Loukinas"
local description = "Mines a shaft down to bedrock, and places torches"


-- Functions
function init()

    -- Ensure the computer running the program is a turtle
    if not turtle then
        print("[error] This script requires a Turtle Computer")
        return
    end

    print("[log] stair_shaft.lua " .. version .. " script initialized")
end


-- Main
init()
