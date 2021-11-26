-- stair_shaft.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Mines a shaft down to bedrock, and places torches


-- Imports
local utils = require("../../lib/utils")

-- Variables
local script_name = "stair_shaft"
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

    while true do
        -- First Row
        turtle.forward()

        -- Check to make sure we arent mining bedrock
        exists, info = turtle.inspectDown()
        if info.name == "minecraft:bedrock" then
            print("[log] bedrock found, stopping")
            break
        end

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