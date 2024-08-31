local s = require('setup')
local World = {}

function World.new()
    local self = {}

    local cloud = {}
    cloud.x = 100

    -- Map -----------------------------------------------------------

    local map = {}
    function self:loadMap(level)
        map = {}
        local path =
         s.levels.folder .. '/' ..
         tostring(level) ..
         '.' .. s.levels.extension
        for line in love.filesystem.lines(path) do
            local lines = {}
            for char in string.gmatch(line, s.levels.charsRegex) do
                table.insert(lines, char)
            end
            table.insert(map, lines)
        end
    end
    self:loadMap(s.levels.start)

    function self:getMap() return map end

    -- Update --------------------------------------------------------

    function self:update(dt)
        cloud.x = cloud.x + (10 * dt)
    end

    -- Draw ----------------------------------------------------------

    function self:draw()
        self:drawTiles()
        self:drawClouds()
    end

    function self:drawTiles()
        for row = 1, s.tiles.numRows, 1 do
            for col = 1, s.tiles.numCols, 1 do
                local x = ((col - 1) * s.tiles.size) + s.playfield.offset.x
                local y = ((row - 1) * s.tiles.size) + s.playfield.offset.y
                local w = s.tiles.size
                local h = s.tiles.size
                    -- Tile
                local tileCode = map[row][col]
                love.graphics.setColor(s.colors.tiles[tileCode])
                love.graphics.rectangle('fill', x, y, w, h)
                    -- Grid
                love.graphics.setColor(s.colors.grid)
                love.graphics.setLineWidth(1)
                love.graphics.rectangle('line', x, y, w, h)
            end
        end
    end

    function self:drawClouds()
        love.graphics.setColor(1, 1, 1, 0.3)
        love.graphics.circle('fill', cloud.x, 400, 50)
        love.graphics.circle('fill', cloud.x + 20, 410, 10)
        love.graphics.circle('fill', cloud.x + 10, 450, 20)
        love.graphics.circle('fill', cloud.x - 10, 420, 34)
    end

    return self
end

return World
