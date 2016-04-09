-- Include Simple Tiled Implementation into project
local STI = require "libs.STI"

function love.load()
    -- Load map file
    map = STI.new("res/maps/pinay1.lua", {"box2d"})

    -- Create a dynamic layer
    local layer = map:addCustomLayer("Sprites", 8)

    -- Get player spawn object
    local player

    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            player = object
            break
        end
    end

    -- Create player object
    local sprite = love.graphics.newImage("res/images/sprite.png")
    layer.player = {
        sprite = sprite,
        x      = player.x,
        y      = player.y,
        ox     = sprite:getWidth() / 2,
        oy     = sprite:getHeight() / 1.35
    }

    -- Draw player
    layer.draw = function(self)
        love.graphics.draw(
            self.player.sprite,
            math.floor(self.player.x),
            math.floor(self.player.y),
            0,
            1,
            1,
            self.player.ox,
            self.player.oy,
            0,
            0
        )

        -- Temporarily draw a point at our location so we know
        -- that our sprite is offset properly
        love.graphics.setPointSize(5)
        love.graphics.point(math.floor(self.player.x), math.floor(self.player.y))
    end

    -- Remove unneeded object layer
    map:removeLayer("Player")

end

function love.update(dt)
    -- Update world
    map:update(dt)
end

function love.draw()
    -- Draw world
    map:draw()
end
