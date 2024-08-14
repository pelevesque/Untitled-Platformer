local Draft = require('draft/draft')
local draft = Draft()

----------------------------------------------------------------------
local tile = {}
tile.size = 32

    -- Size of main window.
local window = {} -- How to get from conf.lua?
window.width = 1224
window.height = 1032

    -- Size of game view
local view = {} -- size of game view
view.width = 1024 -- multiple of tile size 32 (32)
view.height = 832 -- multiple of tile size 32 (26)

local offset = {}
offset.x = (window.width / 2) - (view.width / 2) + (tile.size / 2)
offset.y = (window.height / 2) - (view.height / 2) + (tile.size / 2)
----------------------------------------------------------------------

local map = {}
for line in love.filesystem.lines('levels/01.lvl') do
    local lineTable = {}
    for char in string.gmatch(line, '%d') do
         table.insert(lineTable, char)
    end
    table.insert(map, lineTable)
end

function love.draw()
        -- Draw frame around view.
    draft:rectangle(window.width / 2, window.height / 2, view.width, view.height, 'line')
        -- Draw tiles.
    for i = 0, (view.width / tile.size) - 1, 1 do
        for j = 0, (view.height / tile.size) - 1, 1 do
            local style
            if (map[j + 1][i + 1] == '1') then style = 'line' else style = 'fill' end
            draft:rectangle(
                (i * tile.size) + offset.x,
                (j * tile.size) + offset.y,
                tile.size,
                tile.size,
                style
            )
        end
    end
end
