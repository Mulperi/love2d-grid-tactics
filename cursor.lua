function CursorCreate()
    return {
        pos = { x = 1, y = 1 },
        selected = nil,
        keypressed = function(self, key, gridLength)
            if key == "up" then
                if self.pos.y > 1 then
                    self.pos.y = self.pos.y - 1
                end
            end
            if key == "right" then
                if self.pos.x < gridLength then
                    self.pos.x = self.pos.x + 1
                end
            end
            if key == "down" then
                if self.pos.y < gridLength then
                    self.pos.y = self.pos.y + 1
                end
            end
            if key == "left" then
                if self.pos.x > 1 then
                    self.pos.x = self.pos.x - 1
                end
            end
            if key == "return" then
                if not self.selected then
                    self.selected = {
                        x = self.pos.x,
                        y = self.pos.y
                    }
                else
                    self.selected = nil
                end
            end
        end,
        draw = function(self, grid)
            -- Cursor position.
            love.graphics.setColor(1, 0, 1, 1)
            love.graphics.rectangle("line",
                self.pos.x * grid.tileSize - grid.tileSize,
                self.pos.y * grid.tileSize - grid.tileSize,
                grid.tileSize,
                grid.tileSize)

            -- Selected position.
            if self.selected then
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.rectangle("line",
                    self.selected.x * grid.tileSize - grid.tileSize,
                    self.selected.y * grid.tileSize - grid.tileSize,
                    grid.tileSize,
                    grid.tileSize)
            end
        end
    }
end

return CursorCreate()
