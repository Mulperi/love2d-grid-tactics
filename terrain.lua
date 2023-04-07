function TerrainCreate()
    return {
        wall = nil,
        setBlockedCells = function(self, grid, blockValue)
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    if cell.terrainValue == blockValue then
                        cell.blocked = true
                        cell.hp = 2
                    end
                end
            end
        end,
        init = function(self)
            self.wall = love.graphics.newImage("wall.png")
        end,
        generate = function(self, grid, iterations)
            -- Create initial terrain values.
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    cell.terrainValue = love.math.random(1, 2) - 1 > 0 and 1 or 0
                end
            end

            -- Iterate and create terrain types.
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    local north = cell.neighbors[0] and cell.neighbors[0].terrainValue or 0
                    local east = cell.neighbors[1] and cell.neighbors[1].terrainValue or 0
                    local south = cell.neighbors[2] and cell.neighbors[2].terrainValue or 0
                    local west = cell.neighbors[3] and cell.neighbors[3].terrainValue or 0
                    for i = 1, iterations do
                        if north + east + south + west < 1 then
                            cell.terrainValue = 0
                        elseif north + east + south + west > 1 then
                            cell.terrainValue = 1
                        end
                    end
                end
            end

            -- Set blocked to cells that should be blocked.
            self:setBlockedCells(grid, 0)
        end,
        draw = function(self, grid, tileSize, day)
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]

                    -- Movable tiles.
                    if not cell.blocked then
                        if day then
                            love.graphics.setColor(0.8, 0.8, 0.8, 1)
                        else
                            love.graphics.setColor(0, 0, 0.8, 1)
                        end
                        love.graphics.rectangle("fill",
                            x * tileSize - tileSize,
                            y * tileSize - tileSize,
                            tileSize,
                            tileSize)
                    else
                        -- Blocked tiles.
                        -- love.graphics.setColor(0.2, 0.2, 0.2, 1)
                        -- love.graphics.rectangle("fill",
                        --     x * tileSize - tileSize,
                        --     y * tileSize - tileSize,
                        --     tileSize,
                        --     tileSize)

                        love.graphics.draw(self.wall,
                            x * tileSize - tileSize,
                            y * tileSize - tileSize,
                            0,
                            4, 4
                        )
                    end

                    -- Terrain value.
                    -- love.graphics.setColor(1, 1, 1, 1)
                    -- love.graphics.print(cell.terrainValue, x * tileSize, y * tileSize)
                end
            end
        end
    }
end

return TerrainCreate()
