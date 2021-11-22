-- craft_essences.lua
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>


-- Variables
local mon = peripheral.wrap("right")
local rs = peripheral.wrap("back")

local essences = {
    [1] = {"minecraft:slime_ball", "mysticalagriculture:slime_essence", 3, 8},
    [2] = {"minecraft:ender_pearl", "mysticalagriculture:enderman_essence", 8, 4},
    [3] = {"minecraft:gold_ingot", "mysticalagriculture:gold_essence", 8, 4},
    [4] = {"minecraft:diamond", "mysticalagriculture:diamond_essence", 9, 1},
    [5] = {"minecraft:emerald", "mysticalagriculture:emerald_essence", 9, 1},
    [6] = {"thermal:invar_ingot", "mysticalagriculture:invar_essence", 8, 4},
    [7] = {"mekanism:ingot_osmium", "mysticalagriculture:osmium_essence", 8, 4},
    [8] = {"thermal:electrum_ingot", "mysticalagriculture:electrum_essence", 8, 4},
    [9] = {"mekanism:ingot_refined_obsidian", "mysticalagriculture:refined_obsidian_essence", 8, 2},
    [10] = {"mekanism:ingot_uranium", "mysticalagriculture:uranium_essence", 8, 2},
    [11] = {"refinedstorage:quartz_enriched_iron", "mysticalagriculture:quartz_enriched_iron_essence", 8, 8},
}


-- Functions
local function round(num)
    return num + (2^52 + 2^51) - (2^52 + 2^51) - 1 -- We are minusing 1, because we dont need to be accurate
end

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


-- Main Loop
-- Redirect output to monitor
term.redirect(mon)

i = 0
while true do
    i = i + 1
    print("[log] Running craft job " .. i)

    for i,v in pairs(essences) do
        has_pattern = rs.hasPattern({
            ["name"] = v[1]
        })

        if has_pattern then
            
            -- Figure out how many raw essences we have
            found_item = rs.getItem({
                ["name"] = v[2]
            })

            if found_item["count"] >= v[3] then
                max_amount = found_item["count"] / v[3]
                max_amount = round(max_amount * v[4])

                -- Craft final item
                print("[log] Crafting " .. max_amount .. " " .. v[1])
                task = rs.scheduleTask({
                    ["name"] = v[1],
                    ["count"] = max_amount
                })

                if task ~= nil then
                    print("[log] Crafting task scheduled")
                else
                    print("[log] Failed to schedule crafting task")
                end
            else
                print("[log] Not enough raw essences to craft " .. v[1])
            end
                    
        else
            print("[log] " .. v[1] .. " does not have a crafting pattern.")
        end
    end

    print("[log] Sleeping 60 seconds...")
    sleep(60)
end
