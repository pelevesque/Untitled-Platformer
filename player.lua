local s = require('setup')
local Player = {}

function Player.new(map)
    local self = {}

    -- Variables -----------------------------------------------------

    local map = map
    local pos = {}
    pos.lx = s.player.x
    pos.ty = s.player.y
    local w = s.player.w
    local h = s.player.h
    local speed = s.player.speed
    local gravity = s.gravity
    local color = s.colors.player
    local yVelocity = 0
    local jumpHeight = s.player.jumpHeight

        -- WARNING! Hard coded.
    local targets = {
       [1] = false,
       [2] = false,
    }

    -- Utilities -----------------------------------------------------

        -- Block tile = Cannot walk through.
    function self:isBlockTile(row, col)
        if row < 1 or row > s.tiles.numRows then return false end
        if col < 1 or col > s.tiles.numCols then return false end
        return map[row][col] == '@' or false
    end

        -- Directions: top, bottom, left, right
    function self:isBlocked(direction)
        if direction == 'top' or direction == 'bottom' then
            for col = pos.lCol, pos.rCol, 1 do
                local row
                if direction == 'top' then row = pos.tRow else row = pos.bRow end
                if self:isBlockTile(row, col) then
                    return true
                end
            end
        elseif direction == 'left' or direction == 'right' then
            for row = pos.tRow, pos.bRow, 1 do
                local col
                if direction == 'left' then col = pos.lCol else col = pos.rCol end
                if self:isBlockTile(row, col) then
                    return true
                end
            end
        end
        return false
    end

    -- Update --------------------------------------------------------

    function self:update(dt)

        if love.keyboard.isDown('w') and yVelocity == 0 then
            yVelocity = jumpHeight
        end

        if yVelocity ~= 0 then
            pos.ty = pos.ty - (yVelocity * dt)
        end

        yVelocity = yVelocity - (gravity * dt)

        local distance = speed * dt

        self:updatePosVariables()
            -- Pull back if blocked.
        if self:isBlocked('top') then
            pos.ty = pos.tRow * s.tiles.size
            yVelocity = 0
        elseif self:isBlocked('bottom') then
            pos.ty = ((pos.bRow - 1) * s.tiles.size) - 1 - h
            yVelocity = 0
        end

        if love.keyboard.isDown('a') then pos.lx = pos.lx - distance end
        if love.keyboard.isDown('d') then pos.lx = pos.lx + distance end
        self:updatePosVariables()
            -- Pull back if blocked.
        if self:isBlocked('left') then
            pos.lx = pos.lCol * s.tiles.size
        elseif self:isBlocked('right') then
            pos.lx = ((pos.rCol - 1) * s.tiles.size) - 1 - w
        end

            -- Wrap player from bottom to top.
        if pos.ty > s.playfield.h then
            pos.ty = -h
        end

            -- Not strictly needed, for drawing infos.
        self:updatePosVariables()

            -- WARNING! Hard coded.
        if pos.bRow == 10 and pos.rCol == 3  then targets[1] = true end
        if pos.bRow == 20 and pos.rCol == 22 then targets[2] = true end
        if love.keyboard.isDown('r') then
            targets[1] = false
            targets[2] = false
        end
    end

    function self:updatePosVariables()
        pos.rx = pos.lx + w
        pos.by = pos.ty + h
        pos.tRow = math.floor(pos.ty / s.tiles.size) + 1
        pos.bRow = math.floor(pos.by / s.tiles.size) + 1
        pos.lCol = math.floor(pos.lx / s.tiles.size) + 1
        pos.rCol = math.floor(pos.rx / s.tiles.size) + 1
    end

    -- Draw ----------------------------------------------------------

    function self:draw()
        if s.debug then self:drawInfos() end
        self:drawPlayer()
        self:drawDotGotIndicator()
    end

    function self:drawInfos()
        love.graphics.setColor(s.colors.debug)
        love.graphics.print('DEBUG', 20, 46)
        love.graphics.print('x: ' .. math.floor(pos.lx), 20, 100)
        love.graphics.print('y: ' .. math.floor(pos.ty), 20, 125)
        love.graphics.print('top row: ' .. pos.tRow, 20, 150)
        love.graphics.print('bot row: ' .. pos.bRow, 20, 175)
        love.graphics.print('lft col: ' .. pos.lCol, 20, 200)
        love.graphics.print('rgt col: ' .. pos.rCol, 20, 225)
        local isJumping
        if yVelocity > 0 then isJumping = 'ya' else isJumping = 'no' end
        love.graphics.print('Jumping?: ' .. isJumping, 20, 250)
    end

    function self:drawPlayer()
        love.graphics.setColor(color)
        local x = math.floor(pos.lx) + s.playfield.offset.x
        local y = math.floor(pos.ty) + s.playfield.offset.y
        love.graphics.rectangle('fill', x, y, w, h)
    end

        -- WARNING! Hard coded.
    function self:drawDotGotIndicator()
        love.graphics.setColor(1, 1, 1)
        if targets[1] then
            love.graphics.circle('fill', 280, 354, 8)
        end
        if targets[2] then
            love.graphics.circle('fill', 888, 674, 8)
        end
    end

    return self
end

return Player
