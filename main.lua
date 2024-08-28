local World = require('World')
local Player = require('Player')

function love.load()
    world = World.new()
    player = Player.new(world.getMap())
end

function love.update(dt)
    world:update(dt)
    player:update(dt)
end

function love.draw()
    world:draw()
    player:draw()
end
