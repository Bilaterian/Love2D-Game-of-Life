---@diagnostic disable: undefined-global
local colors = {
    {255, 0, 0},
    {0, 255, 0},
    {0, 0, 255},
    {0, 0, 0},
    {255, 255, 255},
}

local PIXEL_SIZE = 5

local width, height, flags = love.window.getMode()
local offsetX = 400
local offsetY = 0
local boardWidth = math.floor((width - offsetX)/PIXEL_SIZE)
local boardHeight = math.floor((height- offsetY)/PIXEL_SIZE)

local boards = require "boards"
local generateButton = require "generateButton"

function love.load()
    boards.setWidth(boardWidth)
    boards.setHeight(boardHeight)
    generateButton.setSeed()
    boards.populateBoard()
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        --all button checks will happen here
        if generateButton.checkBounds(x, y) == true then
            boards.populateBoard()
        end
    end
end

function love.update(dt)
--want to check board here
    boards.transferBoards()
end

function love.draw()
    local i = 1
    local j = 1
    
    --draws board
    for x = 0, width - 1 - offsetX, PIXEL_SIZE do
        for y = 0, height - 1 - offsetY, PIXEL_SIZE do
            if boards.getCellValue(i, j) == 1 then
                love.graphics.setColor(colors[5])
                love.graphics.rectangle("fill", x + offsetX, y + offsetY, PIXEL_SIZE, PIXEL_SIZE)
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end
    
    --draws button
    local dimensions = generateButton.getButtonDimensions()
    love.graphics.setColor(colors[1])
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    local font = love.graphics.newFont(24)
    local text = love.graphics.newText(font, generateButton.getText())
    local width = (dimensions[3] - font:getWidth(generateButton.getText())) / 2
    local height = (dimensions[4] - font:getHeight(generateButton.getText())) / 2
    love.graphics.setColor(colors[4])
    love.graphics.draw(text, width, height)
end