require "grid"
require "map"
require "cursor"
require "player"
require "units"
require "reach"
require "raycast"

function Game()
    return {
        debug        = false,
        font         = love.graphics.newFont("pico8mono.ttf", 8),
        grid         = nil,
        map          = nil,
        cursor       = nil,
        cursorMode   = nil,
        selectedUnit = nil,
        reachCells   = nil,
        visibleCells = nil,
        time         = 12,
        day          = true,
        units        = nil,
        players      = nil,
        turnNumber   = 1,
        playerInTurn = 1,
        selectUnit   = function(self, x, y)
            if self.grid.cells[x][y].unit then
                self.selectedUnit = self.grid.cells[x][y].unit
            else
                self.selectedUnit = nil
            end
        end,
        init         = function(self, tileSize, gridLength)
            love.graphics.setFont(self.font)
            self.player = PlayerCreate()
            self.grid = GridCreate()
            self.map = MapCreate()
            self.cursor = CursorCreate()
            -- self.units = UnitsCreate()
            self.grid:init(tileSize, gridLength)
            self.map:init()
            self.map:generate(self.grid.cells, 2)
            self.units = {}
            self.players = {
                {
                    actionPoints = 10
                },
                {}
            }
            self.cursorMode = "select"
            self.selectedUnit = nil
            self.reachCells = nil
            self.visibleCells = {}
            self.day = true
            self.time = 12



            -- test unit
            table.insert(self.units, {
                type = "base",
                owner = 1,
                reachMove = 1,
                reachAttack = 4,
                costMove = 1,
                costAttack = 1,
                x = 10,
                y = 6,
            })
            self.grid.cells[10][6].unit = self.units[1]


            self.visibleCells = Raycast(self.grid.cells, self.grid.tileSize, 10, 6)
            print("Visible cells length: " .. #self.visibleCells)
        end,
        tick         = function(self)

        end,
        keypressed   = function(self, key)
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
                -- self.map:generate(self.grid.cells, 2)
                -- self.cursor.selected = nil
            end


            if key == "return" then
                if self.selectedUnit then
                    -- UNSELECT UNIT.
                    for i = 1, #self.reachCells do
                        self.reachCells[i].pathCost = nil
                        self.reachCells[i].visited = false
                    end
                    self.reachCells = nil
                    self.selectedUnit = nil
                else
                    if self.grid.cells[cursorX][cursorY].unit then
                        -- SELECT UNIT.
                        self.selectedUnit = self.grid.cells[cursorX][cursorY].unit
                        -- CALCULATE CELLS THAT CAN BE MOVED TO.
                        self.reachCells = GetReach(self.grid.cells, cursorX, cursorY,
                            self.selectedUnit.reachMove)
                    end
                end
            end
        end,
        update       = function(self, dt)
        end,
        draw         = function(self, dt)
            self.map:draw(self.grid.cells, self.grid.tileSize, self.day)
            -- self.player:draw(self.grid.tileSize)
            -- self.units:draw(self.grid)

            -- HIGHLIGHT CELLS THAT CAN BE MOVED TO OR ATTACKED TO.
            if self.reachCells then
                for i = 1, #self.reachCells do
                    local x = self.reachCells[i].x
                    local y = self.reachCells[i].y
                    love.graphics.setColor(0, 1, 0, 0.5)
                    love.graphics.rectangle("fill",
                        x * self.grid.tileSize - self.grid.tileSize,
                        y * self.grid.tileSize - self.grid.tileSize,
                        self.grid.tileSize,
                        self.grid.tileSize)
                end
            end

            -- UNITS.
            for i = 1, #self.units do
                local x = self.units[i].x
                local y = self.units[i].y
                love.graphics.setColor(0, 1, 1, 1)
                love.graphics.rectangle("fill",
                    x * self.grid.tileSize - self.grid.tileSize,
                    y * self.grid.tileSize - self.grid.tileSize,
                    self.grid.tileSize,
                    self.grid.tileSize)
            end

            -- HELP TEXT FOR SELECTED UNIT.
            if self.selectedUnit then
                love.graphics.print("(M)OVE", 0, 512)
                love.graphics.print("(A)TTACK", 0, 524)
            end

            -- LINE OF SIGHT CELLS.
            if self.visibleCells then
                for i = 1, #self.visibleCells do
                    local x = self.visibleCells[i].x
                    local y = self.visibleCells[i].y

                    love.graphics.setColor(1, 1, 1, 0.2)
                    love.graphics.rectangle("fill",
                        x * self.grid.tileSize - self.grid.tileSize,
                        y * self.grid.tileSize - self.grid.tileSize,
                        self.grid.tileSize - 1,
                        self.grid.tileSize - 1)


                    -- love.graphics.setColor(1, 1, 1, 1)
                    -- love.graphics.print(i,
                    --     x * self.grid.tileSize - self.grid.tileSize,
                    --     y * self.grid.tileSize - self.grid.tileSize)
                end
            end

            -- CURSOR.
            self.grid:draw(self.debug)
            self.cursor:draw(self.grid)
        end
    }
end

return Game()
