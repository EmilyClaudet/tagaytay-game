require "player"
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
    music = love.audio.newSource("res/audio/creepymusic.wav")

    imageFile = love.graphics.newImage("res/images/avatar.png")
    frames[1] = love.graphics.newQuad(0, 32, 32, 32, imageFile:getDimensions())
    frames[2] = love.graphics.newQuad(32, 32, 32, 32, imageFile:getDimensions())
    frames[3] = love.graphics.newQuad(64, 32, 32, 32, imageFile:getDimensions())
    frames[4] = love.graphics.newQuad(96, 32, 32, 32, imageFile:getDimensions())
    activeFrame = frames[currentFrame]
end

function love.draw()
    -- Draw world
    map:draw()
    -- Draw player
    love.graphics.draw(imageFile, activeFrame, playerX, playerY, 0)
    -- Play music
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


