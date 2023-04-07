function MapCreate()
    return {
        wall = nil,
        setBlockedCells = function(self, grid, blockValue)
            print("setBlockedCells")
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    if cell.mapValue == blockValue then
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
            print("generating map")
            ---- Create initial map values.

            map = {
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", "#", "#", ".", ".", "#", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "#", "#", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "#", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", "#", ".", ".", "#", "#", "#", ".", ".", "#", "#", ".", ".", ".", },
                { ".", ".", ".", "#", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", "#", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", },
                { ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", }
            }

            for x = 1, #map do
                for y = 1, #map do
                    local cell = map[y][x]
                    grid[x][y].mapValue = cell
                end
            end




            --for x = 1, #grid do
            --for y = 1, #grid do
            --local cell = grid[x][y]
            --cell.mapValue = love.math.random(1, 2) - 1 > 0 and 1 or 0
            --end
            --end

            -- Iterate and create terrain types.
            --for x = 1, #grid do
            --for y = 1, #grid do
            --local cell = grid[x][y]
            --local north = cell.neighbors[0] and cell.neighbors[0].mapValue or 0
            --local east = cell.neighbors[1] and cell.neighbors[1].mapValue or 0
            --local south = cell.neighbors[2] and cell.neighbors[2].mapValue or 0
            --local west = cell.neighbors[3] and cell.neighbors[3].mapValue or 0
            --for i = 1, iterations do
            --if north + east + south + west < 1 then
            --cell.mapValue = 0
            --elseif north + east + south + west > 1 then
            --cell.mapValue = 1
            --end
            --end
            --end
            --end

            -- Set blocked to cells that should be blocked.
            self:setBlockedCells(grid, "#")
        end,
        draw = function(self, grid, tileSize)
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]

                    if cell.blocked then
                        love.graphics.setColor(1, 0, 0, 1)
                        love.graphics.draw(self.wall,
                            x * tileSize - tileSize,
                            y * tileSize - tileSize,
                            0,
                            4, 4
                        )
                        -- love.graphics.rectangle("fill",
                        --     x * tileSize - tileSize,
                        --     y * tileSize - tileSize,
                        --     tileSize,
                        --     tileSize)
                    else
                        -- Blocked tiles.
                        -- love.graphics.setColor(0.2, 0.2, 0.2, 1)
                        -- love.graphics.rectangle("fill",
                        --     x * tileSize - tileSize,
                        --     y * tileSize - tileSize,
                        --     tileSize,
                        --     tileSize)
                    end

                    -- Map value.
                    -- love.graphics.setColor(1, 1, 1, 1)
                    -- love.graphics.print(cell.mapValue, x * tileSize, y * tileSize)
                end
            end
        end
    }
end

return MapCreate()
