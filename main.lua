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

-- 0 = space
-- 1 = wall
-- 2 = red door
-- 3 = green door
-- 4 = blue door

local map = {}
for line in love.filesystem.lines('levels/01.lvl') do
    local lineTable = {}
    for char in string.gmatch(line, '%d') do
         table.insert(lineTable, char)
    end
    table.insert(map, lineTable)
end

function love.load()
    player = {}
    player.x = 500
    player.y = 400
    player.speed = 5
end

function love.update(dt)
    if love.keyboard.isDown('w') then player.y = player.y - player.speed end
    if love.keyboard.isDown('s') then player.y = player.y + player.speed end
    if love.keyboard.isDown('a') then player.x = player.x - player.speed end
    if love.keyboard.isDown('d') then player.x = player.x + player.speed end
end

function love.draw()
        -- Draw frame around view.
    draft:rectangle(window.width / 2, window.height / 2, view.width, view.height, 'line')
        -- Draw tiles.
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
            if (block == '0') then
                love.graphics.setColor(1, 1, 1)
            elseif (block == '1') then
                love.graphics.setColor(0, 0, 0)
            elseif (block == '2') then
                love.graphics.setColor(1, 0, 0)
            elseif (block == '3') then
                love.graphics.setColor(0, 1, 0)
            elseif (block == '4') then
                love.graphics.setColor(0, 0, 1)
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
        -- Draw player.
    love.graphics.setColor(0, 1, 1, 0.5)
    draft:rectangle(player.x, player.y, 50, 64, 'fill')
end
