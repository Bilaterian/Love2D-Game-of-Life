---@diagnostic disable: undefined-global

local PIXEL_SIZE = 5

local width, height, flags = love.window.getMode()
local offsetX = 400
local offsetY = 0
local boardWidth = math.floor((width - offsetX)/PIXEL_SIZE)
local boardHeight = math.floor((height - offsetY)/PIXEL_SIZE)

local boards = require "boards"
local generateButton = require "generateButton"
local pausePlayButton = require "pausePlayButton"
local printButton = require "printButton"
local brushButtons = require "brushButtons"

function love.load()
    boards.setWidth(boardWidth)
    boards.setHeight(boardHeight)
    generateButton.setSeed()
    boards.populateBoard()

    love.filesystem.setIdentity("Game of Life")
    printButton.mkdir(printButton.getScreenshotDirectory())
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        --all button checks will happen here
        if generateButton.checkBounds(x, y) == true then
            boards.populateBoard()
        end
        if pausePlayButton.checkBounds(x, y) == true then
            pausePlayButton.switchStates()
        end
        if printButton.checkBounds(x, y) == true then
            printButton.saveScreenshot()
        end
    end
end

function love.update(dt)
--want to check board here
    if pausePlayButton.paused() == false then
        if pausePlayButton.isFrame() == true then
            boards.transferBoards()
            pausePlayButton.resetFrame()
        else
            pausePlayButton.incrementFrame()
        end
    end
    if love.mouse.isDown(1) == true then
        if boards.checkBounds(love.mouse.getX(), love.mouse.getY()) == true then
            --add brush state check here
            boards.onCell(math.ceil((love.mouse.getX() - offsetX)/PIXEL_SIZE),
                math.ceil((love.mouse.getY() - offsetY)/PIXEL_SIZE))
        end
    end
end

function love.draw()
    local i = 1
    local j = 1
    --draws board
    for x = 0, width - 1 - offsetX, PIXEL_SIZE do
        for y = 0, height - 1 - offsetY, PIXEL_SIZE do
            if boards.getCellValue(i, j) == 1 then
                love.graphics.setColor(boards.getColor(i, j))
                love.graphics.rectangle("fill", x + offsetX, y + offsetY, PIXEL_SIZE, PIXEL_SIZE)
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end
    
    --draws generate button
    local dimensions = generateButton.getButtonDimensions()
    love.graphics.setColor(brushButtons.getColor(1))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    local font = love.graphics.newFont(24)
    local text = love.graphics.newText(font, generateButton.getText())
    local width = ((dimensions[3] - font:getWidth(generateButton.getText())) / 2) + dimensions[1]
    local height = ((dimensions[4] - font:getHeight(generateButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(brushButtons.getColor(4))
    love.graphics.draw(text, width, height)

    --draws pause/play button
    dimensions = pausePlayButton.getButtonDimensions()
    love.graphics.setColor(brushButtons.getColor(2))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    font = love.graphics.newFont(24)
    text = love.graphics.newText(font, pausePlayButton.getText())
    width = ((dimensions[3] - font:getWidth(pausePlayButton.getText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(pausePlayButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(brushButtons.getColor(4))
    love.graphics.draw(text, width, height)

    --draws print button
    dimensions = printButton.getButtonDimensions()
    love.graphics.setColor(brushButtons.getColor(3))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    font = love.graphics.newFont(24)
    text = love.graphics.newText(font, printButton.getText())
    width = ((dimensions[3] - font:getWidth(printButton.getText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(printButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(brushButtons.getColor(4))
    love.graphics.draw(text, width, height)

end