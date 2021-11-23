-- stair_shaft.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Mines a shaft down to bedrock, and places torches


-- Variables
local version = "1.0.0"
local author = "Anthony Loukinas"
local description = "Mines a shaft down to bedrock, and places torches"

local collected = {}

-- Functions
function init()

    -- Ensure the computer running the program is a turtle
    if not turtle then
        print("[error] This script requires a Turtle Computer")
        return
    end

    print("[log] stair_shaft.lua " .. version .. " script initialized")
end

function main()

    for i = 0, 10 do
        -- First Row
        turtle.forward()
        turtle.digDown()
        turtle.down()
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()

        -- Second Row
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()

        -- Third Row
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()

        -- Fourth Row
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()

        -- Return to start
        turtle.turnLeft()
        turtle.forward()
        turtle.forward()
        turtle.forward()
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

-- Main
init()
main()