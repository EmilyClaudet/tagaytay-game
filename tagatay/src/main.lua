require "player"
require "gamestate"
local STI = require "libs.STI"
local imageFile
local frames = {}
local activeFrame
local currentFrame = 1
local playerX = 200
local playerY = 200

-- constants
local DOWN = 2
local UP = 3
local LEFT = 4
local RIGHT = 5

function love.load()
    -- Load map file
    map = STI.new("res/maps/pinay2.lua", {"box2d"})
    music = love.audio.newSource("res/audio/creepymusic.wav")
    wavesound = love.audio.newSource("res/audio/beachwaves.wav", "static")
    wavesound:setVolume(0.7)
    pauseImage = love.graphics.newImage("res/images/jericaPause.png")

    imageFile = love.graphics.newImage("res/images/avatar.png")
    frames[DOWN] = {}
    frames[DOWN][1] = love.graphics.newQuad(0, 32, 32, 32, imageFile:getDimensions())
    frames[DOWN][2] = love.graphics.newQuad(32, 32, 32, 32, imageFile:getDimensions())
    frames[DOWN][3] = love.graphics.newQuad(64, 32, 32, 32, imageFile:getDimensions())
    frames[DOWN][4] = love.graphics.newQuad(96, 32, 32, 32, imageFile:getDimensions())

    frames[UP] = {}
    frames[UP][1] = love.graphics.newQuad(0, 64, 32, 32, imageFile:getDimensions())
    frames[UP][2] = love.graphics.newQuad(32, 64, 32, 32, imageFile:getDimensions())
    frames[UP][3] = love.graphics.newQuad(64, 64, 32, 32, imageFile:getDimensions())
    frames[UP][4] = love.graphics.newQuad(96, 64, 32, 32, imageFile:getDimensions())

    frames[LEFT] = {}
    frames[LEFT][1] = love.graphics.newQuad(0, 96, 32, 32, imageFile:getDimensions())
    frames[LEFT][2] = love.graphics.newQuad(32, 96, 32, 32, imageFile:getDimensions())
    frames[LEFT][3] = love.graphics.newQuad(64, 96, 32, 32, imageFile:getDimensions())
    frames[LEFT][4] = love.graphics.newQuad(96, 96, 32, 32, imageFile:getDimensions())

    frames[RIGHT] = {}
    frames[RIGHT][1] = love.graphics.newQuad(0, 128, 32, 32, imageFile:getDimensions())
    frames[RIGHT][2] = love.graphics.newQuad(32, 128, 32, 32, imageFile:getDimensions())
    frames[RIGHT][3] = love.graphics.newQuad(64, 128, 32, 32, imageFile:getDimensions())
    frames[RIGHT][4] = love.graphics.newQuad(96, 128, 32, 32, imageFile:getDimensions())

    direction = DOWN
    activeFrame = frames[DOWN][currentFrame]
    state = 'play'
end

local elapsedTime = 0
local speed = 150

function love.update(dt)
    if state ~= 'play' then
        return 
    end

    -- Update world
    map:update(dt)
    elapsedTime = elapsedTime + dt

    if (elapsedTime > 0.1) then
        if(currentFrame < 4 ) then
            currentFrame = currentFrame + 1
        else
            currentFrame = 1
        end
        elapsedTime = 0
    end

    if (love.keyboard.isDown('left')) then
        playerX = playerX - (speed * dt)
        direction = LEFT

    elseif (love.keyboard.isDown('right')) then
        playerX = playerX + (speed * dt)
        direction = RIGHT

    elseif (love.keyboard.isDown('up')) then
        playerY = playerY - (speed * dt)
        direction = UP

    elseif (love.keyboard.isDown('down')) then
        playerY = playerY + (speed * dt)
        direction = DOWN
    end

    activeFrame = frames[direction][currentFrame]

    if(love.keyboard.isDown('escape')) then
        love.event.quit()
    end
end

function love.draw()
    -- Draw world
    map:draw()
    map:setDrawRange(5, 5, 256, 256)
    -- Draw player
    love.graphics.draw(imageFile, activeFrame, playerX, playerY, 0)
    -- Play music and sound effects
    music:play()
    wavesound:play()
    -- pause state
    if state == 'pause' then
        draw_pause_screen()
        love.audio.pause(music)
        love.audio.pause(wavesound)
    end
end

function love.quit()
    print('Quitting Tagatay Game...')
end
