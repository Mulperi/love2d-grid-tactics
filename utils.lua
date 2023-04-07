DegreesToRadians = function(degrees)
    return degrees * math.pi / 180
end

RadiansToDegrees = function(radians)
    return radians * 180 / math.pi
end

GetCellByPixelCoordinates = function(px, py, grid, tileSize)
    local x = math.floor(px / tileSize)
    local y = math.floor(py / tileSize)
    if x > 0 and x <= #grid and y > 0 and y <= #grid then
        return grid[x][y]
    else
        return nil
    end
end

PixelOutOfBounds = function(px, py)
    if px < 0 or px > love.graphics.getWidth() or
        py < 0 or py > love.graphics.getHeight() then
        return true
    end
    return false
end
