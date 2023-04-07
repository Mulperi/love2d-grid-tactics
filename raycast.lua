require "utils"

function CellInList(list, cell)
    for i = 1, #list, 1 do
        if list[i].x == cell.x and list[i].y == cell.y then
            return true
        end
    end
    return false
end

Raycast = function(grid, tileSize, cellX, cellY)
    local points = {}
    local visibleCells = {}

    -- RAY COUNT.
    for angle = 0, 360, 1 do
        local radius = 1
        local targetX = cellX * tileSize
        local targetY = cellY * tileSize
        -- RAY DEPTH.
        for i = 1, love.graphics.getWidth(), 1 do
            local cellToCheck = GetCellByPixelCoordinates(targetX, targetY, grid, tileSize)

            -- CELL NOT FOUND.
            if not cellToCheck then
                break
            end

            -- WALL.
            if cellToCheck.blocked then
                if not CellInList(visibleCells, cellToCheck) then
                    table.insert(visibleCells, cellToCheck)
                end
                break
            end

            -- NORMAL CELL THAT SHOULD BE VISIBLE.
            if not CellInList(visibleCells, cellToCheck) then
                table.insert(visibleCells, cellToCheck)
            end

            -- ADJUST RAY DEPTH AND COORDINATES FOR NEXT ITERATION.
            radius = radius + 1
            targetX = cellX * tileSize + math.cos(DegreesToRadians(angle)) * radius
            targetY = cellY * tileSize + math.sin(DegreesToRadians(angle)) * radius
            -- table.insert(points, { x = targetX, y = targetY })
        end
    end
    return visibleCells
end
