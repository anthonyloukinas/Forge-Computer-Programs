-- find_item.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Searches RefinedStorage for an Item matching user's input.


-- Variables
local function printUsage()
    print("Usage: find_item QUERY_HERE\nExample: find_item compressed_iron")
end

-- Argument handling
local tArgs = {...}

if #tArgs < 1 then
    printUsage()
    return
end

-- Find RefinedStorage interface
local rs = peripheral.find("refinedstorage")

-- Check to ensure RefinedStorage is connected to CC
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