local s = require('setup')
local World = require('world')
local Player = require('player')

function loadFont()
    font = love.graphics.newFont(s.font.file, s.font.size)
    love.graphics.setFont(font)
end

function drawControls()
    love.graphics.setColor(s.colors.debug)
    love.graphics.print('CONTROLS', 1280, 46)
    love.graphics.print('left:  s', 1280, 100)
    love.graphics.print('right: d', 1280, 125)
    love.graphics.print('jump:  w', 1280, 150)
    love.graphics.print('reset: r', 1280, 175)
end

function drawGoal()
    love.graphics.setColor(0, 1, 0)
    love.graphics.print('Get the red dots! ', 1240, 225)
end

----------------------------------------------------------------------

function love.load()
    jumpSound = love.audio.newSource('sounds/535890__jerimee__coin-jump.wav', 'static')
    music = love.audio.newSource('music/697844__geoff-bremner-audio__free-8-bit-video-game-style-music.wav', 'stream')
    music:setLooping(true)
    music:play()
    loadFont()
    world = World.new()
    player = Player.new(world.getMap())
end

function love.update(dt)
    world:update(dt)
    player:update(dt)
end

function love.draw()
    drawControls()
    drawGoal()
    player:draw()
    world:draw()
end
