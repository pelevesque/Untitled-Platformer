local Draft = require('draft/draft')
local draft = Draft()

local Player = {}

function Player.new(cx , cy, tileSize, numRows, numCols, xMargin, yMargin, map)

    ----------------------------------------------------------------------
    -- Variables

    local self = {}

    local cx = cx
    local cy = cy
    local w = 50
    local h = 64

    local lx = cx - (w / 2)
    local rx = cx + (w / 2)
    local ty = cy - (h / 2)
    local by = cy + (h / 2)

    local tileSize = tileSize
    local numRows = numRows
    local numCols = numCols
    local xOffset = xOffset
    local yOffset = yOffset

    local speed = 1200
    local isFalling = false
    local fallSpeed = 1000
    local r = 0
    local g = 1
    local b = 2
    local alpha = 0.5

    local tilePosition = {}
    tilePosition.row = {}
    tilePosition.col = {}

    local joysticks = love.joystick.getJoysticks()
    local joystick = joysticks[1]

    ----------------------------------------------------------------------
    -- Update

    function self:update(dt)

        --[[

        local distanceToMove = speed * dt
            -- Move player.
        if love.keyboard.isDown('w') then y = y - distanceToMove end
        -- if love.keyboard.isDown('s') then y = y + distanceToMove end
        if love.keyboard.isDown('a') then x = x - distanceToMove end
        if love.keyboard.isDown('d') then x = x + distanceToMove end

        if joystick then
            if     joystick:isGamepadDown("dpleft")  then x = x - distanceToMove
            elseif joystick:isGamepadDown("dpright") then x = x + distanceToMove
            end
            if     joystick:isGamepadDown("dpup")    then y = y - distanceToMove
            -- elseif joystick:isGamepadDown("dpdown") then y = y + distanceToMove
            end
        end

        -- Here, do an update player positioning with all infos.
        self:updateTilePosition()

        -- Not really works if the player is really wide.. need to think this over...
        -- This is dirty, maybe we can have a break.
        isFalling = not self:isOnPlatform()

        if isFalling then
            local distanceToTileBelow = self:getDistanceFromTileBelow()
            local distanceToFall = fallSpeed * dt

            if distanceToTileBelow >= distanceToFall then
                y = y + distanceToFall
            else
                local numRowsToFall = math.floor(self:getNumTilesForDistance(distanceToFall))
                local fell = false
                for i = tilePosition.row.bottom, tilePosition.row.bottom + numRowsToFall, 1 do
                    local isOnPlatform = self:isOnPlatform(i)
                    if isOnPlatform then
                        y = ((i - 1) * tileSize) + (h / 2) + yMargin
                        fell = true
                        break
                    end
                end
                if not fell then
                    y = y + distanceToFall
                end
            end
        end

        -- Don't let player go out of bounds...Draft
        if tilePosition.row.bottom > numRows then y = (numRows * tileSize) + yMargin end
        if tilePosition.row.bottom < 1 then y = h + yMargin end
        --if tilePosition.col.left < 1 then x = xMargin + (w / 2) end
        --if tilePosition.col.left > numCols then x = xMargin + (numRows * tileSize) - (w / 2) end

        --]]
    end


    --[[

    function self:isOnPlatform(bottomRow)
        -- Update tilePosition before this to be 100% sure?
        bottomRow = bottomRow or tilePosition.row.bottom
        local isOnPlatform = false
        if bottomRow > 0 and bottomRow <= numCols then
            for i = tilePosition.col.left, tilePosition.col.right, 1 do
                if (i > 0 and i <= numRows and map[bottomRow][i] == '1') then
                    isOnPlatform = true
                    break
                end
            end
        end
        return isOnPlatform
    end

    --]]

    -- function self:getPlayerBottomY() return y + (h / 2) - yMargin end
    -- function self:getPlayerTopY()    return y - (h / 2) - yMargin end
    -- function self:getPlayerLeftX()   return x - (w / 2) - xMargin end
    -- function self:getPlayerRightX()  return x + (w / 2) - xMargin end

    -- function self:getDistanceFromTileBelow() return tileSize - (self:getPlayerBottomY() % tileSize) end
    -- function self:getNumTilesForDistance(distance) return distance / tileSize end

    --[[
    function self:updateTilePosition()
        tilePosition.row.top    = math.floor(self:getPlayerTopY()    / tileSize) + 1
        tilePosition.row.bottom = math.floor(self:getPlayerBottomY() / tileSize) + 1
        tilePosition.col.left   = math.floor(self:getPlayerLeftX()   / tileSize) + 1
        tilePosition.col.right  = math.floor(self:getPlayerRightX()  / tileSize) + 1
    end
    --]]

    ----------------------------------------------------------------------
    -- Draw

    function self:draw()
        --self:drawPlayer()
        self:drawInfos()
    end

    --function self:drawPlayer()
     --   love.graphics.setColor(r, g, b, alpha)
      --  draft:rectangle(math.floor(x), math.floor(y), w, h, 'fill')
    --end

    function self:drawInfos()
        love.graphics.setColor(1, 1, 1)
        love.graphics.print('cx: '   .. cx, 10, 10)
        love.graphics.print('cy: '   .. cy, 10, 30)
        love.graphics.print('lx: '   .. lx, 10, 50)
        love.graphics.print('rx: '   .. rx, 10, 70)
        love.graphics.print('ty: '   .. ty, 10, 90)
        love.graphics.print('by: '   .. by, 10, 110)

        --[[
        love.graphics.setColor(1, 1, 1)
        love.graphics.print('player col left: '   .. tilePosition.col.left, 10, 10)
        love.graphics.print('player col right: '  .. tilePosition.col.right, 10, 30)
        love.graphics.print('player row top: '    .. tilePosition.row.top, 10, 50)
        love.graphics.print('player row bottom: ' .. tilePosition.row.bottom, 10, 70)
        -- love.graphics.print('block type: ' .. map[tilePosition.row.bottom][tilePosition.col.left], 200, 10)
        love.graphics.print('bottom Y : '  .. self:getPlayerBottomY(), 200, 30)
        love.graphics.print('top Y : '     .. self:getPlayerTopY(), 200, 50)
        love.graphics.print('Distance to tile below : ' .. self:getDistanceFromTileBelow(), 200, 70)
        local fallingStatus = isFalling and 'true' or 'false'
        love.graphics.print('isFalling: ' .. fallingStatus, 600, 10)
        --]]
    end

    return self
end

return Player
