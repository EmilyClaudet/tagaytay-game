-- Include Simple Tiled Implementation into project
local STI = require "libs.STI"
local imageFile
local frames = {}
local activeFrame
local currentFrame = 1
local playerX = 100
local playerY = 100

function love.load()
    -- Load map file
    map = STI.new("res/maps/pinay1.lua", {"box2d"})
    imageFile = love.graphics.newImage("res/images/avatar.png")
    frames[1] = love.graphics.newQuad(0, 0, 32, 32, imageFile:getDimensions())
    frames[2] = love.graphics.newQuad(32, 0, 32, 32, imageFile:getDimensions())
    frames[3] = love.graphics.newQuad(64, 0, 32, 32, imageFile:getDimensions())
    frames[4] = love.graphics.newQuad(96, 0, 32, 32, imageFile:getDimensions())

    activeFrame = frames[currentFrame]

    music = love.audio.newSource("res/audio/creepymusic.wav") 
end

--     -- Create a dynamic layer
--     local layer = map:addCustomLayer("Sprites", 8)

--     -- Get player spawn object
--     local player

--     for k, object in pairs(map.objects) do
--         if object.name == "Player" then
--             player = object
--             break
--         end
--     end

--     -- Create player object
--     local sprite = love.graphics.newImage("res/images/sprite.png")
--     layer.player = {
--         sprite = sprite,
--         x      = player.x,
--         y      = player.y,
--         ox     = sprite:getWidth() / 2,
--         oy     = sprite:getHeight() / 1.35
--     }

--     -- Draw player
--     layer.draw = function(self)
--         love.graphics.draw(
--             self.player.sprite,
--             math.floor(self.player.x),
--             math.floor(self.player.y),
--             0,
--             1,
--             1,
--             self.player.ox,
--             self.player.oy,
--             0,
--             0
--         )

--         -- Temporarily draw a point at our location so we know
--         -- that our sprite is offset properly
--         love.graphics.setPointSize(5)
--         love.graphics.point(math.floor(self.player.x), math.floor(self.player.y))
--     end

--     -- Remove unneeded object layer
--     map:removeLayer("Player")

-- end

function love.draw()
    -- Draw world
    map:draw()
    -- love.graphics.draw(imageFile, activeFrame)
    love.graphics.draw(imageFile, activeFrame, playerX, playerY, 0)

    -- play music
    music:play()
end

local elapsedTime = 0
local speed = 100

function love.update(dt)
    -- Update world
    map:update(dt)
    elapsedTime = elapsedTime + dt

    if (elapsedTime > 1) then
        if(currentFrame < 4 ) then 
            currentFrame = currentFrame + 1
        else
            currentFrame = 1
        end
        activeFrame = frames[currentFrame]
        elapsedTime = 0
    end

    if(love.keyboard.isDown('left')) then
        playerX = playerX - (speed * dt)
    end

    if(love.keyboard.isDown('right')) then
        playerX = playerX + (speed * dt)
    end

    if(love.keyboard.isDown('up')) then
        playerY = playerY - (speed * dt)
    end

    if(love.keyboard.isDown('down')) then
        playerY = playerY + (speed * dt)
    end

end


