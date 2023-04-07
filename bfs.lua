-- Breadth first search.
function Bfs(startCell, targetCell)
    local queue = {}
    local path = {}

    startCell.visited = true
    table.insert(queue, startCell)

    while #queue > 0 do
        local currentCell = queue[1]
        table.remove(queue, 1)

        if currentCell.x == targetCell.x and currentCell.y == targetCell.y then
            table.insert(path, currentCell)
            while currentCell.parent do
                currentCell = currentCell.parent
                table.insert(path, currentCell)
            end
            break
        end

        -- Add neighbors to queue if cells are not blocked.
        for i = 1, 4 do
            if currentCell.neighbors[i]
                and not currentCell.neighbors[i].blocked
                and not currentCell.neighbors[i].visited
            then
                table.insert(queue, currentCell.neighbors[i])
                currentCell.neighbors[i].visited = true
                currentCell.neighbors[i].parent = currentCell
            end
        end
    end

    return path
end
