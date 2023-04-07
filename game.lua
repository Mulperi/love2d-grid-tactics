require "grid"
require "terrain"
require "cursor"
require "player"
require "units"
require "reach"

function Game()
    return {
        debug = false,
        player = nil,
        grid = nil,
        terrain = nil,
        cursor = nil,
        cursorMode = nil,
        selectedUnit = nil,
        reachCells = nil,
        time = 12,
        day = true,
        units = nil,
        selectUnit = function(self, x, y)
            if self.grid.cells[x][y].unit then
                self.selectedUnit = self.grid.cells[x][y].unit
            else
                self.selectedUnit = nil
            end
        end,
        init = function(self, tileSize, gridLength)
            self.player = PlayerCreate()
            self.grid = GridCreate()
            self.terrain = TerrainCreate()
            self.cursor = CursorCreate()
            -- self.units = UnitsCreate()
            self.units = {}
            self.grid:init(TileSize, GridLength)
            self.player:init({ x = 8, y = 8 }, { 0, 0, 1 })
            self.terrain:init()
            self.terrain:generate(self.grid.cells, 2)
            self.cursorMode = "select"
            self.selectedUnit = nil
            self.reachCells = nil
            self.day = true
            self.time = 12


            self.grid.cells[10][10].unit = {
                type = "base",
                owner = 1,
                reach = 3,
                x = 10,
                y = 10,
            }
            table.insert(self.units, self.grid.cells[10][10].unit)
        end,
        tick = function(self)

        end,
        keypressed = function(self, key)
            local cursorX = self.cursor.pos.x
            local cursorY = self.cursor.pos.y


            self.cursor:keypressed(key, #self.grid.cells)

            -- if self.cursorMode == "cursor" then
            -- end
            -- if self.cursorMode == "player" then
            --     self.player:keypressed(key, self.grid)
            -- end


            -- Player movement.

            if key == "escape" then
                love.event.quit()
                -- if self.cursorMode == "cursor" then
                --     self.cursorMode = "player"
                -- else
                --     self.cursorMode = "cursor"
                -- end
            end

            if key == "space" then
                -- self.grid:init(TileSize, GridLength)
                -- self.terrain:generate(self.grid.cells, 2)
                -- self.cursor.selected = nil
            end


            if key == "return" then
                if self.selectedUnit then
                    print("unselecting")
                    for i = 1, #self.reachCells do
                        self.reachCells[i].pathCost = nil
                        self.reachCells[i].visited = false
                    end
                    self.reachCells = nil
                    self.selectedUnit = nil
                else
                    if self.grid.cells[cursorX][cursorY].unit then
                        print("selecting unit")
                        self.selectedUnit = self.grid.cells[cursorX][cursorY].unit
                        self.reachCells = GetReach(self.grid.cells, cursorX, cursorY,
                            self.selectedUnit.reach)

                        print("reach cells length: " .. #self.reachCells)
                    end
                end
            end
        end,
        update = function(self, dt)
        end,
        draw = function(self, dt)
            self.terrain:draw(self.grid.cells, self.grid.tileSize, self.day)
            self.grid:draw(self.debug)
            self.player:draw(self.grid.tileSize)
            -- self.units:draw(self.grid)

            if self.reachCells then
                for i = 1, #self.reachCells do
                    local x = self.reachCells[i].x
                    local y = self.reachCells[i].y
                    love.graphics.setColor(0.2, 1, 0.2, 0.8)
                    love.graphics.rectangle("fill",
                        x * self.grid.tileSize - self.grid.tileSize,
                        y * self.grid.tileSize - self.grid.tileSize,
                        self.grid.tileSize,
                        self.grid.tileSize)
                end
            end

            for i = 1, #self.units do
                local x = self.units[i].x
                local y = self.units[i].y
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("fill",
                    x * self.grid.tileSize - self.grid.tileSize,
                    y * self.grid.tileSize - self.grid.tileSize,
                    self.grid.tileSize,
                    self.grid.tileSize)
            end

            if self.selectedUnit then

            end






            -- Time.
            -- love.graphics.setColor(1, 0, 0, 1)
            -- love.graphics.print(self.time, 0, 0)

            self.cursor:draw(self.grid)
        end
    }
end

return Game()
