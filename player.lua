local setup = require('setup')
local Player = {}

function Player.new()
    local self = {}

    -- Variables -----------------------------------------------------

    local pos = {}
    pos.lx = setup.player.x
    pos.ty = setup.player.y

    local w = setup.player.w
    local h = setup.player.h
    local speed = setup.player.speed
    local gravity = setup.gravity
    local color = setup.colors.player

    function self:updatePosVariables()
        pos.rx = pos.lx + w
        pos.by = pos.ty + h
        pos.tRow = math.floor(pos.ty / setup.tiles.size) + 1
        pos.bRow = math.floor(pos.by / setup.tiles.size) + 1
        pos.lCol = math.floor(pos.lx / setup.tiles.size) + 1
        pos.rCol = math.floor(pos.rx / setup.tiles.size) + 1
    end

    self:updatePosVariables()

    -- Update --------------------------------------------------------

    function self:update(dt)
        local distance = speed * dt
        if love.keyboard.isDown('w') then pos.ty = pos.ty - distance end
        if love.keyboard.isDown('s') then pos.ty = pos.ty + distance end
        if love.keyboard.isDown('a') then pos.lx = pos.lx - distance end
        if love.keyboard.isDown('d') then pos.lx = pos.lx + distance end
        self:updatePosVariables()
    end

    -- Draw ----------------------------------------------------------

    function self:draw()
        self:drawInfos()
        self:drawPlayer()
    end

    function self:drawInfos()
        love.graphics.setColor(setup.colors.debug)
        love.graphics.print('x pure: ' .. pos.lx, 10, 10)
        love.graphics.print('y pure: ' .. pos.ty, 10, 30)
        love.graphics.print('x: ' .. math.floor(pos.lx), 10, 50)
        love.graphics.print('y: ' .. math.floor(pos.ty), 10, 70)
        love.graphics.print('lCol: ' .. pos.lCol, 10, 90)
        love.graphics.print('rCol: ' .. pos.rCol, 10, 110)
        love.graphics.print('tRow: ' .. pos.tRow, 10, 130)
        love.graphics.print('bRow: ' .. pos.bRow, 10, 150)
    end

    function self:drawPlayer()
        love.graphics.setColor(color)
        local x = math.floor(pos.lx) + setup.playfield.offset.x
        local y = math.floor(pos.ty) + setup.playfield.offset.y
        love.graphics.rectangle('fill', x, y, w, h)
    end

    return self
end

return Player
