-- cubemina.lua
--
-- @purpose: Mine a 3d cube of blocks {h} high, {w} wide, and {l} long

if not turtle then
  printError("Requires a Turtle")
  return
end

local tArgs = { ... }
if #tArgs ~= 1 then
  local programName = arg[0] or fs.getName(shell.getRunningProgram())
  print("Usage: " .. programName .. " <height> <width> <length>")
  return
end

local h = tonumber(tArgs[1])
local w = tonumber(tArgs[2])
local l = tonumber(tArgs[3])

if h < 1 then
  print("Height must be positive")
  return
end

if w < 1 then
  print("Width must be positive")
  return
end

if l < 1 then
  print("Length must be positive")
  return
end

local collected = 0
local function collect()
  collected = collected + 1
  if math.fmod(collected, 25) == 0 then
      print("Mined " .. collected .. " items.")
  end
end

local function tryDig()
  while turtle.detect() do
      if turtle.dig() then
          collect()
          sleep(0.5)
      else
          return false
      end
  end
  return true
end

local function tryDigUp()
  while turtle.detectUp() do
      if turtle.digUp() then
          collect()
          sleep(0.5)
      else
          return false
      end
  end
  return true
end

local function tryDigDown()
  while turtle.detectDown() do
      if turtle.digDown() then
          collect()
          sleep(0.5)
      else
          return false
      end
  end
  return true
end

local function refuel()
  local fuelLevel = turtle.getFuelLevel()
  if fuelLevel == "unlimited" or fuelLevel > 0 then
      return
  end

  local function tryRefuel()
      for n = 1, 16 do
          if turtle.getItemCount(n) > 0 then
              turtle.select(n)
              if turtle.refuel(1) then
                  turtle.select(1)
                  return true
              end
          end
      end
      turtle.select(1)
      return false
  end

  print("Out of fuel...")
  while not tryRefuel() do
      print("Waiting for fuel...")
      os.pullEvent("turtle_inventory")
  end
  print("Resuming Tunnel.")
end

local function tryUp()
  refuel()
  while not turtle.up() do
      if turtle.detectUp() then
          if not tryDigUp() then
              return false
          end
      elseif turtle.attackUp() then
          collect()
      else
          sleep( 0.5 )
      end
  end
  return true
end

local function tryDown()
  refuel()
  while not turtle.down() do
      if turtle.detectDown() then
          if not tryDigDown() then
              return false
          end
      elseif turtle.attackDown() then
          collect()
      else
          sleep( 0.5 )
      end
  end
  return true
end

local function tryForward()
  refuel()
  while not turtle.forward() do
      if turtle.detect() then
          if not tryDig() then
              return false
          end
      elseif turtle.attack() then
          collect()
      else
          sleep( 0.5 )
      end
  end
  return true
end

local function tryBack()
  refuel()
  while not turtle.back() do
      if turtle.detect() then
          if not tryDig() then
              return false
          end
      elseif turtle.attack() then
          collect()
      else
          sleep( 0.5 )
      end
  end
  return true
end

local function turnLeft()
  turtle.turnLeft()
end

local function turnRight()
  turtle.turnRight()
end

local function turnAround()
  turtle.turnLeft()
  turtle.turnLeft()
end

print("Mining cube...")

for i = 1, h do
  for j = 1, w do
      for k = 1, l do
          tryDig()
          tryForward()
      end
      if j < w then
          if math.fmod(j, 2) == 1 then
              turnRight()
              tryDig()
              tryForward()
              turnRight()
          else
              turnLeft()
              tryDig()
              tryForward()
              turnLeft()
          end
      end
  end
  if i < h then
      if math.fmod(i, 2) == 0 then
          tryUp()
          turnRight()
          tryDig()
          tryForward()
          turnRight()
      else
          tryUp()
          turnLeft()
          tryDig()
          tryForward()
          turnLeft()
      end
  end
end

print("Mined " .. collected .. " items total.")