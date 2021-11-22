-- craft_essences.lua
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>


-- Variables
local mon = peripheral.wrap("right")
local rs = peripheral.wrap("back")

local essences = {
    [1] = {"minecraft:slime_ball", "mysticalagriculture:slime_essence", 3},
}


-- Main Loop
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
                print("[log] Found enough raw essences to craft " .. v[2])
                
                max_amount = found_item["count"] / v[3]

                -- Craft final item
                print("[log] Crafting " .. v[1])
                rs.schedulePattern({
                    ["name"] = v[1],
                    ["count"] = max_amount
                })    
            else
                print("[log] Not enough raw essences to craft " .. v[2])
            end
                    
        else
            print("[log] " .. ess .. " does not have a crafting pattern.")
        end
    end

    sleep(60)
end
