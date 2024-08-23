local Draft = require('draft/draft')
local draft = Draft()

local World = {}

function World.new()

    ----------------------------------------------------------------------
    -- Variables

    local self = {}

    local window = {}
    window.width = 1224
    window.height = 1032

    local view = {} -- size of game view
    view.width = 1024 -- multiple of tile size 32 (32)
    view.height = 832 -- multiple of tile size 32 (26)

    local map = {}

    local tile = {}
    tile.size = 32
    tile.w = 32
    tile.h = 26

    local offset = {}
    offset.x = (window.width / 2) - (view.width / 2) + (tile.size / 2)
    offset.y = (window.height / 2) - (view.height / 2) + (tile.size / 2)

    local margin = {}
    margin.left = (window.width - view.width) / 2
    margin.top = (window.height - view.height) / 2

    local playerA = {}
    playerA.startX = 500
    playerA.startY = 400

    local level = 0

        -- 0 = space
        -- 1 = wall
        -- 2 = red door
        -- 3 = green door
        -- 4 = blue door
    function self:loadMap()
        map = {}
        for line in love.filesystem.lines('levels/' .. tostring(level) .. '.lvl') do
            local lineTable = {}
            for char in string.gmatch(line, '%d') do
                table.insert(lineTable, char)
            end
            table.insert(map, lineTable)
        end
    end

    self:loadMap()

    function self:getPlayerAStartX() return playerA.startX end
    function self:getPlayerAStartY() return playerA.startY end
    function self:getTileSize() return tile.size end
    function self:getTileW() return tile.w end
    function self:getTileH() return tile.h end
    function self:getMarginLeft() return margin.left end
    function self:getMarginTop() return margin.top end
    function self:getMap() return map end

    ----------------------------------------------------------------------
    -- Update

    function self:update(dt)
    end

    ----------------------------------------------------------------------
    -- Draw

    function self:draw()
        self:drawGameFrame()
        self:drawTiles()
    end

    function self:drawGameFrame()
        draft:rectangle(window.width / 2, window.height / 2, view.width, view.height, 'line')
    end

    function self:drawTiles()
        for i = 0, (view.width / tile.size) - 1, 1 do
            for j = 0, (view.height / tile.size) - 1, 1 do
                local block = map[j + 1][i + 1]

                -- outline
                love.graphics.setColor(1, 1, 1)
                draft:rectangle(
                    (i * tile.size) + offset.x,
                    (j * tile.size) + offset.y,
                    tile.size,
                    tile.size,
                    'line'
                )

                -- block
                if     (block == '0') then love.graphics.setColor(1, 1, 1)
                elseif (block == '1') then love.graphics.setColor(0, 0, 0)
                elseif (block == '2') then love.graphics.setColor(1, 0, 0)
                elseif (block == '3') then love.graphics.setColor(0, 1, 0)
                elseif (block == '4') then love.graphics.setColor(0, 0, 1)
                end
                draft:rectangle(
                    (i * tile.size) + offset.x,
                    (j * tile.size) + offset.y,
                    tile.size,
                    tile.size,
                    'fill'
                )
            end
        end
    end

    return self
end

return World
