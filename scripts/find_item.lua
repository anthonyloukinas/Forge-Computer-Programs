-- find_item.lua
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Searches RefinedStorage for an Item matching user's input.

local function printUsage()
    print("You are using this wrong!")
end

local tArgs = {...}

if #tArgs < 1 then
    printUsage()
    return
end

local rs = peripheral.wrap("back")

is_connected = rs.isConnected()
if is_connected then
    print("Connected to Refined Storage!")
else
    print("Refined Storage is not connected!")
    return
end

-- Find items in RefinedStorage
items = rs.getItems()

for itemI = 1, #items do
    if string.find(items[itemI].name, tArgs[1]) then
        print("Found " .. items[itemI].name .. "!")
    end
end