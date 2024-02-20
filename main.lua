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
local canvasMenu = require "canvasMenu"

function love.load()
    boards.setWidth(boardWidth)
    boards.setHeight(boardHeight)
    generateButton.setSeed()
    boards.populateBoard()

    love.filesystem.setIdentity("Game of Life")
    printButton.mkdir(printButton.getScreenshotDirectory())
    canvasMenu.drawCanvas()
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
        brushButtons.setBrush(x, y)
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
            if brushButtons.getBrush() == "PAINT" then
                boards.onCell(math.ceil((love.mouse.getX() - offsetX)/PIXEL_SIZE),
                math.ceil((love.mouse.getY() - offsetY)/PIXEL_SIZE))
            elseif brushButtons.getBrush() == "ERASE" then
                boards.offCell(math.ceil((love.mouse.getX() - offsetX)/PIXEL_SIZE),
                math.ceil((love.mouse.getY() - offsetY)/PIXEL_SIZE))
            elseif brushButtons.getBrush() == "COLOR" then
                boards.setColor(math.ceil((love.mouse.getX() - offsetX)/PIXEL_SIZE),
                math.ceil((love.mouse.getY() - offsetY)/PIXEL_SIZE), brushButtons.getColor())
            end
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
    
    love.graphics.draw(canvasMenu.getCanvas(), 0, 0)
end