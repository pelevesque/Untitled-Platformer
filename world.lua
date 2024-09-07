local s = require('setup')
local World = {}

function World.new()
    local self = {}

    local flip = 0

    -- Map -----------------------------------------------------------
    function self:loadMap(level)
        local map = {}
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
        return map
    end

    local map1 = self:loadMap(1)
    local map2 = self:loadMap(2)

    -- function self:getMap() return map end

    -- Update --------------------------------------------------------

    function self:update(dt)
        if love.keyboard.isDown('w') then flip = 0 end
        if love.keyboard.isDown('s') then flip = 1 end
    end

    -- Draw ----------------------------------------------------------

    function self:draw()
        self:drawTiles2()
        self:drawTiles()
    end

    function self:drawTiles()
        local rowFirst
        local rowLast
        if flip == 0 then
            rowFirst = 1
            rowLast = s.tiles.numRows
        elseif flip == 1 then
            rowFirst = s.tiles.numRows
            rowLast = 1
        end

        for row = rowFirst, rowLast do
            for col = 1, s.tiles.numCols, 1 do
                local x = ((col - 1) * s.tiles.size)
                local y = ((row - 1) * s.tiles.size)
                local w = s.tiles.size
                local h = s.tiles.size
                    -- Tile
                local tileCode = map1[row][col]
                love.graphics.setColor(s.colors.tiles[tileCode])
                love.graphics.rectangle('fill', x, y, w, h)
                    -- Grid
                love.graphics.setColor(s.colors.grid)
                love.graphics.setLineWidth(1)
                love.graphics.rectangle('line', x, y, w, h)
            end
        end
    end


    function self:drawTiles2()
        for row = 1, s.tiles.numRows, 1 do
            for col = 1, s.tiles.numCols, 1 do
                local x = ((col - 1) * s.tiles.size)
                local y = ((row - 1) * s.tiles.size)
                local w = s.tiles.size
                local h = s.tiles.size
                    -- Tile
                local tileCode = map2[row][col]
                love.graphics.setColor(s.colors.tiles2[tileCode])
                love.graphics.rectangle('fill', x, y, w, h)
                    -- Grid
                love.graphics.setColor(s.colors.grid)
                love.graphics.setLineWidth(1)
                love.graphics.rectangle('line', x, y, w, h)
            end
        end
    end


    return self
end

return World
