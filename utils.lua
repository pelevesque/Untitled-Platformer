local Utils = {}

    -- Print out tables, bools, or anything else.
function Utils:dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k, v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. self:dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

function Utils:randomFloat(min, max)
    return math.random() * (max - min) + min
end

    -- Merge two tables recursively.
function Utils:tableMerge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                self:tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

return Utils
