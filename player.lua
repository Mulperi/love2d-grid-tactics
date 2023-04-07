function PlayerCreate()
    return {
        color = nil,
        pos = nil,
        image = nil,
        init = function(self, pos, color)
            self.pos = pos
            self.color = color
        end,
        keypressed = function(self, key, grid)
            -- if key == "return" then
            --     if not self.selected then
            --         self.selected = {
            --             x = self.pos.x,
            --             y = self.pos.y
            --         }
            --     else
            --         self.selected = nil
            --     end
            -- end
        end,
        draw = function(self, tileSize)
            -- Player position.
            -- love.graphics.setColor(self.color[1], self.color[2], self.color[3], 1)
            -- love.graphics.rectangle("fill",
            --     self.pos.x * tileSize - tileSize,
            --     self.pos.y * tileSize - tileSize,
            --     tileSize,
            --     tileSize)
            -- love.graphics.draw(self.image,
            --     self.pos.x * tileSize - tileSize,
            --     self.pos.y * tileSize - tileSize,
            --     0,
            --     4, 4
            -- )
        end
    }
end

return PlayerCreate()
