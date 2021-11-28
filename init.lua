-- init.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Initializes ComputerCraft instance with all required files

-- Imports
local utils = require("lib/utils")

-- Variables
local base_github_url = "https://raw.githubusercontent.com/anthonyloukinas/Forge-Computer-Programs/main/"

files = {
    [1] = "scripts/mon_storage.lua",
    [2] = "scripts/find_item.lua",
    [3] = "scripts/craft_essences.lua",
    [4] = "scripts/turtle/stair_shaft.lua",
    [5] = "lib/utils.lua",
    [6] = "scripts/reactor/manager.lua",
    [7] = "configure.lua",
    [8] = "programs/pkg.lua",
}


-- Main
log("Initializing system", "info", "system")

for i = 1, #files do
    local file_found = fs.exists(files[i])

    if file_found then
        log("Deleting old script ".. files[i], "info", "system")
        fs.delete(files[i])
    end

    log("Installing new script " .. files[i], "info", "system")
    download(base_github_url .. files[i], files[i])
end

log("System initialized", "info", "system")