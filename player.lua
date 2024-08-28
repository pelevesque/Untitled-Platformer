local setup = require('setup')
local utils = require('utils')
local Player = {}

function Player.new(map)
    local self = {}

    -- Variables -----------------------------------------------------

    local map = map
    local pos = {}
    pos.lx = setup.player.x
    pos.ty = setup.player.y
    local w = setup.player.w
    local h = setup.player.h
    local speed = setup.player.speed
    local gravity = setup.gravity
    local color = setup.colors.player

    -- Utilities -----------------------------------------------------

    -- Unused!
    --[[
    function self:fillSeries(firstNum, lastNum)
        local nums = {}
        for num = firstNum, lastNum, 1 do
            table.insert(nums, num)
        end
        return nums
    end
    --]]

        -- Block tile? (Cannot walk through.)
    function self:isBlockTile(row, col)
        if row < 1 or row > setup.tiles.numRows then return false end
        if col < 1 or col > setup.tiles.numCols then return false end
        return map[row][col] == '@' or false
    end

    function self:isTopBlocked()
        for col = pos.lCol, pos.rCol, 1 do
            if self:isBlockTile(pos.tRow, col) then
                return true
            end
        end
        return false
    end

    function self:isBottomBlocked()
        for col = pos.lCol, pos.rCol, 1 do
            if self:isBlockTile(pos.bRow, col) then
                return true
            end
        end
        return false
    end

    function self:isLeftBlocked()
        for row = pos.tRow, pos.bRow, 1 do
            if self:isBlockTile(row, pos.lCol) then
                return true
            end
        end
        return false
    end

    function self:isRightBlocked()
        for row = pos.tRow, pos.bRow, 1 do
            if self:isBlockTile(row, pos.rCol) then
                return true
            end
        end
        return false
    end

    -- Update --------------------------------------------------------

    function self:update(dt)
        local distance = speed * dt

        if love.keyboard.isDown('w') then pos.ty = pos.ty - distance end
        if love.keyboard.isDown('s') then pos.ty = pos.ty + distance end
        self:updatePosVariables()
            -- Pull back if blocked.
        if self:isTopBlocked() then pos.ty = pos.tRow * setup.tiles.size
        elseif self:isBottomBlocked() then pos.ty = ((pos.bRow - 1) * setup.tiles.size) - 1 - h
        end

        if love.keyboard.isDown('a') then pos.lx = pos.lx - distance end
        if love.keyboard.isDown('d') then pos.lx = pos.lx + distance end
        self:updatePosVariables()
            -- Pull back if blocked.
        if self:isLeftBlocked() then pos.lx = pos.lCol * setup.tiles.size
        elseif self:isRightBlocked() then pos.lx = ((pos.rCol - 1) * setup.tiles.size) - 1 - w
        end

        self:updatePosVariables() -- Not strictly needed, for drawing infos.
    end

    function self:updatePosVariables()
        pos.rx = pos.lx + w
        pos.by = pos.ty + h
        pos.tRow = math.floor(pos.ty / setup.tiles.size) + 1
        pos.bRow = math.floor(pos.by / setup.tiles.size) + 1
        pos.lCol = math.floor(pos.lx / setup.tiles.size) + 1
        pos.rCol = math.floor(pos.rx / setup.tiles.size) + 1
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
        love.graphics.print('blocked top: ' .. utils:dump(self:isTopBlocked()), 10, 170)
        love.graphics.print('bocked bottom: ' .. utils:dump(self:isBottomBlocked()), 10, 190)
        love.graphics.print('bocked left: ' .. utils:dump(self:isLeftBlocked()), 10, 210)
        love.graphics.print('bocked right: ' .. utils:dump(self:isRightBlocked()), 10, 230)
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
