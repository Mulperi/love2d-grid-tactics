function GetReach(grid, x, y, reach)
    print("GetReach")
    print("reach param: " .. reach)
    local queue = {}
    local reachCells = {}

    -- Starting position.
    grid[x][y].visited = true
    grid[x][y].pathCost = 0
    table.insert(queue, grid[x][y])

    while #queue > 0 do
        local currentCell = queue[1]
        table.remove(queue, 1)
        if currentCell.x == x and currentCell.y == y then
            print("alkupiste")
        else
            table.insert(reachCells, currentCell)
        end

        -- Add neighbors to queue if cells are not blocked and if unit can reach them.
        for i = 1, 4 do
            if currentCell.neighbors[i]
                and not currentCell.neighbors[i].blocked
                and not currentCell.neighbors[i].visited
            then
                currentCell.neighbors[i].visited = true
                currentCell.neighbors[i].parent = currentCell
                currentCell.neighbors[i].pathCost = currentCell.pathCost + 1
                if currentCell.pathCost + 1 <= reach then
                    table.insert(queue, currentCell.neighbors[i])
                end
            end
        end
    end
    return reachCells
end
