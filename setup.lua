local s = {}
s.window = {}
s.playfield = {}; s.playfield.offset = {}
s.tiles = {}
s.levels = {}
s.colors = {}; s.colors.tiles = {}
s.player = {}

    s.window.w          = 1424 -- Must be even, Same as t.window.width in conf.lua
    s.window.h          = 932  -- Must be even, Same as t.window.height in conf.lua
    s.playfield.w       = 1024 -- Must be even, Multiple of tile.size
    s.playfield.h       = 832  -- Must be even, Multiple of tile.size
    s.tiles.size        = 32   -- Must be even, Dividable by s.playfield.w/h
    s.levels.start      = 1
    s.levels.num        = 1
    s.levels.folder     = 'levels'
    s.levels.extension  = 'level'
    s.levels.charsRegex = '[_@\\.^]'
    s.colors.grid  = { 1, 1, 1 }
    s.colors.tiles = {
        ['_'] = { 1, 1, 1 }, -- Empty
        ['@'] = { 0, 0, 0 }, -- Full
        ['.'] = { 1, 0, 0 }, -- Door A
        ['^'] = { 0, 0, 1 }, -- Door B
    }
    s.colors.debug  = { 1, 1, 1 }
    s.colors.player = { 0, 1, 0 }
    s.player.x = 500
    s.player.y = 500
    s.player.w = 30 -- Must be even
    s.player.h = 50 -- Must be even
    s.player.speed = 1400
    s.gravity = 400

    s.playfield.offset.x = (s.window.w - s.playfield.w) / 2 -- Centered
    s.playfield.offset.y = (s.window.h - s.playfield.h) / 2 -- Centered
    s.tiles.numCols = s.playfield.w / s.tiles.size
    s.tiles.numRows = s.playfield.h / s.tiles.size

return s
