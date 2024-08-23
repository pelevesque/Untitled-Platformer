local World = require('World')
local Player = require('Player')

function love.load()
    world = World.new()
    playerA = Player.new(
        'Bobby',
        world.getPlayerAStartX(),
        world.getPlayerAStartY(),
        world.getTileSize(),
        world.getTileW(),
        world.getTileH(),
        world.getMarginLeft(),
        world.getMarginTop(),
        world.getMap()
    )
end

function love.update(dt)
    world:update(dt)
    playerA:update(dt)
end

function love.draw()
    world:draw()
    playerA:draw()
end
