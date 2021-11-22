-- update.lua
--
-- @author: Anthony Loukinas <anthony.loukinas@gmail.com>
-- @purpose: Updates the init.lua file with the latest changes.

-- Variables
local url = "ps://raw.githubusercontent.com/anthonyloukinas/Forge-Computer-Programs/main/init.lua"

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
print("Updating system.. please wait..")

download(url, "init.lua")

print("Successfully updated your system...")