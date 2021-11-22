-- mon_storage.lua
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>


-- Variables
local label = "Don Storage Monitor v1.0.69"

local mon = peripheral.wrap("right")
local rs = peripheral.wrap("back")

local rs_items = {
    [1] = {"Iron Ingot", "minecraft:iron_ingot"},
    [2] = {"Gold Ingot", "minecraft:gold_ingot"},
    [3] = {"Iron Essence", "mysticalagriculture:iron_essence"},
}


-- Functions
-- Just a method to writes textes easier
function CenterT(text, line, txtback , txtcolor, pos)
    monX,monY = mon.getSize()
    mon.setBackgroundColor(txtback)
    mon.setTextColor(txtcolor)
    length = string.len(text)
    dif = math.floor(monX-length)
    x = math.floor(dif/2)
   
    if pos == "head" then
      mon.setCursorPos(x+1, line)
      mon.write(text)
    elseif pos == "left" then
      mon.setCursorPos(2,line)
      mon.write(text)
    elseif pos == "right" then
      mon.setCursorPos(monX-length, line)
      mon.write(text)
    end
end

function clear_screen()
    mon.setBackgroundColor(colors.black)
    mon.clear()
    mon.setCursorPos(1,1)
    CenterT(label ,1, colors.black, colors.white,"head")
end

function test_write(i)
    clear_screen()
    CenterT("", 2, colors.black, colors.green, "right")
    CenterT("Testing: " .. i, 3, colors.black, colors.green, "right")
end

function check_items()
    -- Clear screen
    clear_screen()
    
    local current_line = 3

    for i,v in pairs(rs_items) do
        -- Search for item in storage
        searched_item = rs.getItem({["name"] = v[2]})
        
        -- Print item
        CenterT("Item: " .. v[1] .. " - Count: " .. searched_item["count"], current_line, colors.black, colors.green, "left")

        -- Increment display line by 1
        current_line = current_line + 1
    end
end


-- Main Loop
i = 0
while true do
    i = i + 1
    check_items()
    sleep(5)
end