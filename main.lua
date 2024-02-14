---@diagnostic disable: undefined-global
local colors = {
    {255, 0, 0},
    {0, 255, 0},
    {0, 0, 255},
    {0, 0, 0},
    {255, 255, 255},
}

local PIXEL_SIZE = 5

local width, height, flags = love.window.getMode( )

local boardWidth = math.floor(width/PIXEL_SIZE)
local boardHeight = math.floor(height/PIXEL_SIZE)

local boards = require "boards"
local generateButton = require "generateButton"

function love.load()
    boards.setWidth(boardWidth)
    boards.setHeight(boardHeight)
    generateButton.setSeed()
    boards.populateBoard()
end

function love.update(dt)
--want to check board here
    boards.transferBoards()
end

function love.draw()
    local i = 1
    local j = 1
    for x = 0, width - 1, PIXEL_SIZE do
        for y = 0, height - 1, PIXEL_SIZE do
            if boards.getCellValue(i, j) == 1 then
                love.graphics.setColor(colors[5])
                love.graphics.rectangle("fill", x, y, PIXEL_SIZE, PIXEL_SIZE)
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end
end