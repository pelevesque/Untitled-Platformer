-- local s = require('setup')
-- local World = require('world')
-- local Player = require('player')

local Starfield = require('starfield')

local starfieldOptions = {
    numStars = 3000,
    star = {
        vx = { min = 0, max = 0 },
        vy = { min = 0,  max = 0  },
        radius = { min = 1, max = 400 },
        color = {
            red =   { min = 0, max = 1 },
            green = { min = 0, max = 1 },
            blue =  { min = 0, max = 1 },
            alpha = { min = 0, max = 0.2 },
        },
        drawMode = 0.5, -- 0 = line, 1 = fill, 0.6 = 60% fill
    },
}

local starfieldOptions2 = {
    numStars = 300,
    star = {
        vx = { min = 10, max = 10 },
        vy = { min = 0, max = 0  },
        radius = { min = 1, max = 2 },
        color = {
            red =   { min = 0, max = 1 },
            green = { min = 0, max = 1 },
            blue =  { min = 0, max = 1 },
            alpha = { min = 1, max = 1 },
        },
        drawMode = 1, -- 0 = line, 1 = fill, 0.6 = 60% fill
    },
}

function love.load()
    starfield = Starfield.new(starfieldOptions2)
end

function love.update(dt)
    starfield:update(dt)
    --starfield = Starfield.new(starfieldOptions2)
end

function love.draw()
    starfield:draw()
end

--[[
function loadFont()
    font = love.graphics.newFont(s.font.file, 32)
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
--]]
----------------------------------------------------------------------

--function love.load()
    --[[
        -- stars
    stars = {}
    for i = 1, s.stars.num do
        stars[i] = {}
        stars[i].x = math.random() * s.window.w
        stars[i].y = math.random() * s.window.h
        stars[i].size = math.random() * s.stars.maxSize
        stars[i].xOffset = 0
    end
    jumpSound = love.audio.newSource('sounds/535890__jerimee__coin-jump.wav', 'static')
    music = love.audio.newSource('music/697844__geoff-bremner-audio__free-8-bit-video-game-style-music.wav', 'stream')
    music:setLooping(true)
    music:play()
    loadFont()
    --]]
    --world = World.new()
    --player = Player.new(world.getMap())
--end

--function love.update(dt)
    --[[
    for i = 1, s.stars.num do
        stars[i].xOffset = stars[i].xOffset + (stars[i].size * dt) * 3
        if stars[i].xOffset > s.window.w then
            stars[i].xOffset = 0
            stars[i].x = math.random() * s.window.w
            stars[i].y = math.random() * s.window.h
            stars[i].size = math.random() * s.stars.maxSize
        end
    end
    --]]
    --world:update(dt)
    --player:update(dt)
--end

--function love.draw()
    --[[
    for i = 1, s.stars.num do
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.circle('fill', stars[i].x + stars[i].xOffset, stars[i].y, stars[i].size)
    end
    if s.controls then drawControls() end
    if s.goal then drawGoal() end
    --]]
    --player:draw()
    --world:draw()
--end
