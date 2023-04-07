-- 1. make zip and rename it to .love
-- 2. copy /b love.exe+mygame.love mygame.exe
-- or cmd /c copy /b love.exe+mygame.love mygame.exe

-- D:\repos\love-11.4-win64/lovec.exe .
function love.load()
    TileSize = 32
    GridLength = 16


    -- For sharp pixel art when scaling sprites.
    love.graphics.setDefaultFilter("nearest", "nearest")

    Game = require "game"
    Game:init(TileSize, GridLength)
end

function love.keypressed(key)
    Game:keypressed(key)
end

function love.update(dt)
    Game:update(dt)
    love.timer.sleep(1 / 30 - dt)
end

function love.draw(dt)
    Game:draw()
end
