-- init.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Initializes ComputerCraft instance with all required files


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


-- Functions
function download(url, file)
    local content = http.get(url).readAll()
    if not content then
      error("[system] Could not connect to GitHub")
    end
    f = fs.open(file, "w")
    f.write(content)
    f.close()
end


-- Main
print("[system] Initializing system")

for i = 1, #files do
    local file_found = fs.exists(files[i])

    if file_found then
        print("[system] Deleting old script " .. files[i])
        fs.delete(files[i])
    end

    print("[system] Installing new script " .. files[i])
    download(base_github_url .. files[i], files[i])
end

print("[system] System initialized")