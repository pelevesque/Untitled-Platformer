local Draft = require('draft/draft')
local draft = Draft()

function love.draw()
    draft:rectangle(960, 540, 1200, 800, 'line')
end
