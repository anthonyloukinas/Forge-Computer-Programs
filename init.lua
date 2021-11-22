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
}


-- Functions
function download(url, file)
    local content = http.get(url).readAll()
    if not content then
      error("Could not connect to website")
    end
    f = fs.open(file, "w")
    f.write(content)
    f.close()
end


-- Main
print("Initalizing...")

for i = 1, #files do
    print("Deleting " .. files[i])
    fs.delete(files[i])

    print("Downloading " .. files[i])
    download(base_github_url .. files[i], files[i])
end

print("Finished initializing...")