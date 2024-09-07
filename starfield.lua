local Utils = require('Utils')
local Starfield = {}

function Starfield.new()
    local self = {}

        -- Settings.
    local numStars = 1000
    local starProps = {
        radius = { min = 1, max = 100 }, -- int between 1 and too big for window
        x = { min = 0, max = love.graphics.getWidth()  }, -- int between 0 and window width
        y = { min = 0, max = love.graphics.getHeight() }, -- int between 0 and window height
        vx = 1, -- any number
        vy = 1, -- any number
        color = {
            red =   { min = 0, max = 1 }, -- float between 0 and 1
            green = { min = 0, max = 1 }, -- float between 0 and 1
            blue =  { min = 0, max = 1 }, -- float between 0 and 1
            alpha = { min = 0, max = 1 }, -- float between 0 and 1
        },
        drawMode = 'fill', -- fill or line
    }

        -- Create stars.
    local stars = {}
    for i = 1, numStars do
        table.insert(stars, {
            x = math.random(starProps.x.min, starProps.x.max),
            y = math.random(starProps.y.min, starProps.y.max),
            vx = starProps.vx,
            vy = starProps.vy,
            radius =  math.random(starProps.radius.min, starProps.radius.max),
            color = {
                red = Utils:randomFloat(starProps.color.red.min, starProps.color.red.max),
                green = Utils:randomFloat(starProps.color.green.min, starProps.color.green.max),
                blue = Utils:randomFloat(starProps.color.blue.min, starProps.color.blue.max),
                alpha = Utils:randomFloat(starProps.color.alpha.min, starProps.color.alpha.max),
            },
            drawMode = starProps.drawMode,
        })
    end

    function self:update(dt)
        for i, star in ipairs(stars) do
                -- Move stars.
            star.x = star.x + (star.vx * star.radius * star.color.alpha * dt)
            star.y = star.y + (star.vy * star.radius * star.color.alpha * dt)
                -- Wrap stars.
            local bounds = {
                left   = starProps.x.min - star.radius,
                right  = starProps.x.max + star.radius,
                top    = starProps.y.min - star.radius,
                bottom = starProps.y.max + star.radius,
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
