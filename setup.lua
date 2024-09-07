local s = {}
s.window = {}
s.tiles = {}
s.levels = {}
s.colors = {}; s.colors.tiles = {}
s.player = {}
s.font = {}
s.stars = {}

    s.window.w          = 1920 -- Must be even, Same as t.window.width in conf.lua
    s.window.h          = 1080 -- Must be even, Same as t.window.height in conf.lua
    s.tiles.size        = 30   -- Must be even, Dividable by s.playfield.w/h
    s.levels.start      = 1
    s.levels.folder     = 'levels'
    s.levels.extension  = 'level'
    s.levels.charsRegex = '[_#\\+\\^]'
    s.colors.grid  = { 0, 0, 0, 0 }
    s.colors.tiles = {
        ['_'] = { 0, 0, 0, 0 }, -- Empty
        ['#'] = { 0, 0, 1, 0.8 }, -- Full
        ['+'] = { 1, 0, 0, 0.4 }, -- Target
        ['^'] = { 0, 1, 1, 0.6 }, -- Trampoline
    }
    s.colors.tiles2 = {
        ['_'] = { 0, 0, 0, 0 }, -- Empty
        ['#'] = { 1, 1, 1, 0.05 }, -- Full
        ['+'] = { 1, 0, 0, 0.4 }, -- Target
        ['^'] = { 0, 1, 1, 0.6 }, -- Trampoline
    }

    s.colors.debug  = { 1, 1, 1 }
    s.colors.player = { 1, 1, 0 }
    s.player.x = 500
    s.player.y = 500
    s.player.w = 36 -- Must be even
    s.player.h = 50 -- Must be even
    s.player.speed = 300
    s.player.jumpHeight = 600
    s.gravity = 1800
    s.debug = false -- Adds debugging info if true
    s.controls = false
    s.goal = false
    s.font.file = 'fonts/IBMPlexMono/ttf/IBMPlexMono-Regular.ttf'
    s.font.size = 16
    s.stars.num = 799
    s.stars.maxSize = 1.5

    s.tiles.numCols = s.window.w / s.tiles.size
    s.tiles.numRows = s.window.h / s.tiles.size

return s
