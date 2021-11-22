-- mon_storage.lua
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>


-- Variables
local label = "Don Storage Monitor v1.0.69"

local mon = peripheal.wrap("right")
local rs = peripheral.wrap("back")

local rs_items = {
    [1] = {"Iron Ingot", "minecraft:iron_ingot"},
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

function clearScreen()
    mon.setBackgroundColor(colors.black)
    mon.clear()
    mon.setCursorPos(1,1)
    CenterT(label ,1, colors.black, colors.white,"head")
end

function testWrite(i)
    clearScreen()
    CenterT("Testing: " .. i, 2, colors.black, colors.green, "right")
end


-- Main Loop
i = 0
while true do
  i = i + 1
  testWrite(i)
  sleep(5)
end