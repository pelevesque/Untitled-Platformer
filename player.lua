local Draft = require('draft/draft')
local draft = Draft()

local Player = {}

function Player.new(name, x , y, tileSize, numRows, numCols, xMargin, yMargin, map)

    ----------------------------------------------------------------------
    -- Variables

    local self = {}

    local name = name
    local x = x
    local y = y
    local tileSize = tileSize
    local numRows = numRows
    local numCols = numCols
    local xOffset = xOffset
    local yOffset = yOffset
    local w = 50
    local h = 64
    local speed = 300
    local isFalling = false
    local fallSpeed = 15
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
            -- Move player.
        if love.keyboard.isDown('w') then y = y - speed * dt end
        if love.keyboard.isDown('s') then y = y + speed * dt end
        if love.keyboard.isDown('a') then x = x - speed * dt end
        if love.keyboard.isDown('d') then x = x + speed * dt end

        if joystick then
            if     joystick:isGamepadDown("dpleft")  then x = x - speed * dt
            elseif joystick:isGamepadDown("dpright") then x = x + speed * dt
            end
            if     joystick:isGamepadDown("dpup")    then y = y - speed * dt
            elseif joystick:isGamepadDown("dpdown")  then y = y + speed * dt
            end
        end

        self:updateTilePosition()

        -- Not really works if the player is really wide.. need to think this over...
        -- This is dirty, maybe we can have a break.
        isFalling = true

        if tilePosition.row.bottom > 0 and tilePosition.row.bottom <= numCols then
            for i = tilePosition.col.left, tilePosition.col.right, 1 do
                if (i > 0 and i <= numRows and map[tilePosition.row.bottom][i] == '1') then
                    isFalling = false
                    break
                end
            end
        end
        if isFalling then y = y + fallSpeed end
        -- ajust player to the top of the bottom row -- how to find...
    end

    function self:updateTilePosition()
        tilePosition.row.top    = math.floor((y - (h / 2) - yMargin) / tileSize) + 1
        tilePosition.row.bottom = math.floor((y + (h / 2) - yMargin) / tileSize) + 1
        tilePosition.col.left   = math.floor((x - (w / 2) - xMargin) / tileSize) + 1
        tilePosition.col.right  = math.floor((x + (w / 2) - xMargin) / tileSize) + 1
    end

    ----------------------------------------------------------------------
    -- Draw

    function self:draw()
        self:drawPlayer()
        self:drawInfos()
    end

    function self:drawPlayer()
        love.graphics.setColor(r, g, b, a)
        draft:rectangle(x, y, w, h, 'fill')
    end

    function self:drawInfos()
        love.graphics.setColor(1, 1, 1)
        love.graphics.print('player col left: '   .. tilePosition.col.left, 10, 10)
        love.graphics.print('player col right: '  .. tilePosition.col.right, 10, 30)
        love.graphics.print('player row top: '    .. tilePosition.row.top, 10, 50)
        love.graphics.print('player row bottom: ' .. tilePosition.row.bottom, 10, 70)
        love.graphics.print('block type: ' .. map[tilePosition.row.bottom][tilePosition.col.left], 200, 10)
    end

    return self
end

return Player
