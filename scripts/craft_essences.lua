-- craft_essences.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Turn MysticalAgriculture essences to end products


-- Variables
local version = "1.0.0"

local monitors = {}
local storages = {}

local mon = {}
local rs = {}

local essences = {
    [1] = {"minecraft:slime_ball", "mysticalagriculture:slime_essence", 3, 8},
    [2] = {"minecraft:ender_pearl", "mysticalagriculture:enderman_essence", 8, 4},
    -- [3] = {"minecraft:gold_ingot", "mysticalagriculture:gold_essence", 8, 4},
    [3] = {"minecraft:diamond", "mysticalagriculture:diamond_essence", 9, 1},
    [4] = {"minecraft:emerald", "mysticalagriculture:emerald_essence", 9, 1},
    [5] = {"thermal:invar_ingot", "mysticalagriculture:invar_essence", 8, 4},
    [6] = {"mekanism:ingot_osmium", "mysticalagriculture:osmium_essence", 8, 4},
    [7] = {"thermal:electrum_ingot", "mysticalagriculture:electrum_essence", 8, 4},
    [8] = {"mekanism:ingot_refined_obsidian", "mysticalagriculture:refined_obsidian_essence", 8, 2},
    [9] = {"mekanism:ingot_uranium", "mysticalagriculture:uranium_essence", 8, 2},
    [10] = {"refinedstorage:quartz_enriched_iron", "mysticalagriculture:quartz_enriched_iron_essence", 8, 8},
    [11] = {"refinedstorage:silicon", "mysticalagriculture:silicon_essence", 3, 8},
    [12] = {"pneumaticcraft:ingot_iron_compressed", "mysticalagriculture:compressed_iron_essence", 8, 6},
    [13] = {"minecraft:blaze_rod", "mysticalagriculture:blaze_essence", 8, 6},
    [14] = {"bigreactors:cyanite_ingot", "mysticalagriculture:cyanite_essence", 8, 3},
    [15] = {"minecraft:quartz", "mysticalagriculture:nether_quartz_essence", 8, 12},
    [16] = {"minecraft:netherite_ingot", "mysticalagriculture:netherite_essence", 8, 1},
    [17] = {"thermal:sulfur_dust", "mysticalagriculture:sulfur_essence", 3, 8},
}


-- Functions
function init()
    monitors = { peripheral.find("monitor") }

    -- Allow 5 attempts at discovering the RefinedStorage network
    local loopI = 0
    while loopI ~= 5 do

        if peripheral.find("refinedstorage") ~= nil then
            storages = { peripheral.find("refinedstorage") }
            break
        end

        sleep(1)
        loopI = loopI + 1
    end

    if monitors[1] == nil then
        error("[error] Monitor is not detected")
    end

    if storages[1] == nil then
        error("[error] RefinedStorage is not detected")
    end

    mon = monitors[1]
    rs = storages[1]

    print("[log] craft_essences.lua " .. version .. " script initialized")
end

local function round(num)
    return num + (2^52 + 2^51) - (2^52 + 2^51)
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
init()

-- term.redirect(mon)

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
            found_ess = rs.getItem({
                ["name"] = v[2]
            })

            if found_ess == nil then
                print("[log] Unable to find any " .. v[2] .. " essences")
            else
                if found_ess["count"] == nil then
                    print("[log] The count of essences was nil")
                else
                    if found_ess["count"] >= v[3] then
                        max_amount = found_ess["count"] / v[3]
                        max_amount = round(max_amount * v[4])
        
                        if max_amount - 5 <= 0 then
                           print("[log] Waiting until there are more essences to craft")
                        else
                            max_amount = max_amount - 5
        
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
                        end 
                    else
                        print("[log] Not enough raw essences to craft " .. v[1])
                    end
                end
            end
            
            print("[log] Sleeping 1 seconds in between job schedules")
            sleep(1)
        else
            print("[log] " .. v[1] .. " does not have a crafting pattern.")
        end
    end

    print("[log] Sleeping 60 seconds...")
    sleep(60)
end
