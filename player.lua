local setup = require('setup')
local Player = {}

function Player.new()
    local self = {}

    -- Variables -----------------------------------------------------

    local x = setup.player.x
    local y = setup.player.y
    local w = setup.player.w
    local h = setup.player.h
    local speed = setup.player.speed
    local color = setup.colors.player

    -- Update --------------------------------------------------------

    function self:update(dt)
        local distance = speed * dt
        if love.keyboard.isDown('w') then y = y - distance end
        if love.keyboard.isDown('s') then y = y + distance end
        if love.keyboard.isDown('a') then x = x - distance end
        if love.keyboard.isDown('d') then x = x + distance end
    end

    -- Draw ----------------------------------------------------------

    function self:draw()
        self:drawInfos()
        self:drawPlayer()
    end

    function self:drawInfos()
        love.graphics.setColor(setup.colors.debug)
        love.graphics.print('x pure: ' .. x, 10, 10)
        love.graphics.print('y pure: ' .. y, 10, 30)
        love.graphics.print('x: ' .. math.floor(x), 10, 50)
        love.graphics.print('y: ' .. math.floor(y), 10, 70)
    end

    function self:drawPlayer()
        love.graphics.setColor(color)
        local x = math.floor(x) + setup.playfield.offset.x
        local y = math.floor(y) + setup.playfield.offset.y
        love.graphics.rectangle('fill', x, y, w, h)
    end

    return self
end

return Player
