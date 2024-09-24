-- Make more stars far than close.
-- Wraping, or generating a new star outside.
-- Many stars seems to have a similar speed. Why? More variation?

local Utils = require('Utils')
local Starfield = {}

local defaultOptions = {
    numStars = 800,
    star = {
        x =  { min = 0,  max = love.graphics.getWidth()  },
        y =  { min = 0,  max = love.graphics.getHeight() },
        vx = { min = 10, max = 10 },
        vy = { min = 5,  max = 5  },
        radius = { min = 1, max = 7 },
        color = {
            red =   { min = 1, max = 1 },
            green = { min = 1, max = 1 },
            blue =  { min = 1, max = 1 },
            alpha = { min = 0, max = 1 },
        },
        drawMode = 0, -- 0 = line, 1 = fill, 0.6 = 60% fill
    },
}

function Starfield.new(options)
    o = Utils:tableMerge(defaultOptions, options or {})
    local self = {}

        -- Create stars.
    local stars = {}
    for i = 1, o.numStars do
        table.insert(stars, {
            x = math.random(o.star.x.min, o.star.x.max),
            y = math.random(o.star.y.min, o.star.y.max),
            vx = Utils:randomFloat(o.star.vx.min, o.star.vx.max),
            vy = Utils:randomFloat(o.star.vy.min, o.star.vy.max),
            radius =  math.random(o.star.radius.min, o.star.radius.max),
            color = {
                red = Utils:randomFloat(o.star.color.red.min, o.star.color.red.max),
                green = Utils:randomFloat(o.star.color.green.min, o.star.color.green.max),
                blue = Utils:randomFloat(o.star.color.blue.min, o.star.color.blue.max),
                alpha = Utils:randomFloat(o.star.color.alpha.min, o.star.color.alpha.max),
            },
            drawMode = o.star.drawMode <= math.random() and 'line' or 'fill',
        })
    end

    function self:update(dt)
        for i, star in ipairs(stars) do
                -- Move stars.
            star.x = star.x + (star.vx * star.radius * star.color.alpha * dt)
            star.y = star.y + (star.vy * star.radius * star.color.alpha * dt)
                -- Wrap stars.
            local bounds = {
                left   = o.star.x.min - star.radius,
                right  = o.star.x.max + star.radius,
                top    = o.star.y.min - star.radius,
                bottom = o.star.y.max + star.radius,
            }
            if star.x < bounds.left   then star.x = bounds.right  end
            if star.x > bounds.right  then star.x = bounds.left   end
            if star.y < bounds.top    then star.y = bounds.bottom end
            if star.y > bounds.bottom then star.y = bounds.top    end
        end
    end

    function self:draw()
        for i, star in ipairs(stars) do
            love.graphics.setColor(
                star.color.red,
                star.color.green,
                star.color.blue,
                star.color.alpha
            )
            love.graphics.circle(
                star.drawMode,
                star.x,
                star.y,
                star.radius
            )
        end
    end

    return self
end

return Starfield
