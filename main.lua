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
local brushSizes = require "brushSizes"
local debugPrint = require "debugPrint"
local filenameWindow = require "filenameWindow"
local clickAnimation = require "clickAnimation"

function love.load()
    boards.setWidth(boardWidth)
    boards.setHeight(boardHeight)
    generateButton.setSeed()
    boards.populateBoard()

    love.filesystem.setIdentity("Game of Life")
    love.window.setTitle("Love2D Game of Life")
    local image = love.image.newImageData("icon.png")
    love.window.setIcon(image)
    
    printButton.mkdir(printButton.getScreenshotDirectory())
    love.keyboard.setKeyRepeat(true)
    canvasMenu.drawCanvas()
    clickAnimation.onLoad()
end

local text = ""

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        --all button checks will happen here
        if filenameWindow.screenState() == false then
            if generateButton.checkBounds(x, y) == true then
                generateButton.pressed()
                boards.populateBoard()
            end
            if pausePlayButton.checkBounds(x, y) == true then
                pausePlayButton.pressed()
                pausePlayButton.switchStates()
            end
            if printButton.checkBounds(x, y) == true then
                printButton.pressed()
                printButton.saveBoard()
                filenameWindow.updateDefaultFilename()
                filenameWindow.onScreen()
            end
            brushButtons.setBrush(x, y)
            brushButtons.setColor(x, y)
            brushSizes.checkBounds(x, y)
            text = ""
        else
            --mouse presses when window is on 
            filenameWindow.checkBounds(x, y)
        end
        clickAnimation.onClick(x, y)
    end
end

function love.mousereleased( x, y, button, istouch, presses )
    generateButton.unPressed()
    pausePlayButton.unPressed()
    printButton.unPressed()
    brushButtons.offButton()
    brushSizes.unPressed()
    filenameWindow.unPressed()
end

function love.textinput(t)
    if filenameWindow.screenState() == true then
        if #text < 19 then
            text = text .. t
            filenameWindow.updateFilename(text)
        end
    end
end

function love.keypressed(key)
    if filenameWindow.screenState() == true then
        if key == "backspace" then
            if #text > 0 then
                text = text:sub(1, -2)
                filenameWindow.updateFilename(text)
            end
        elseif key == "return" then
            filenameWindow.printFile()
            filenameWindow.offScreen()
        elseif key == "escape" then
            filenameWindow.offScreen()
        end
    end
end

function love.update(dt)
--want to check board here
    clickAnimation.animate()
    if filenameWindow.screenState() == false then
        --update board on gol
        if pausePlayButton.paused() == false then
            if pausePlayButton.isFrame() == true then
                boards.transferBoards()
                pausePlayButton.resetFrame()
            else
                pausePlayButton.incrementFrame()
            end
        end
        --draw on board
        if love.mouse.isDown(1) == true then
            if boards.checkBounds(love.mouse.getX(), love.mouse.getY()) == true then
                local area = brushSizes.getArea(love.mouse.getX(), love.mouse.getY())
    
                for i = 1, # area do
                    if boards.checkBounds(area[i][1], area[i][2]) == true then
                        if brushButtons.getBrush() == "PAINT" then
                            boards.onCell(math.ceil((area[i][1] - offsetX)/PIXEL_SIZE),
                                          math.ceil((area[i][2] - offsetY)/PIXEL_SIZE))
                            boards.setColor(math.ceil((area[i][1] - offsetX)/PIXEL_SIZE),
                                            math.ceil((area[i][2] - offsetY)/PIXEL_SIZE),
                                            brushButtons.getColor())
                        elseif brushButtons.getBrush() == "ERASE" then
                            boards.offCell(math.ceil((area[i][1] - offsetX)/PIXEL_SIZE),
                                           math.ceil((area[i][2] - offsetY)/PIXEL_SIZE))
                        elseif brushButtons.getBrush() == "COLOR" then
                            boards.setColor(math.ceil((area[i][1] - offsetX)/PIXEL_SIZE),
                                            math.ceil((area[i][2] - offsetY)/PIXEL_SIZE),
                                            brushButtons.getColor())
                        end
                    end
                end
            end
        end
    end
end

function love.draw()
    canvasMenu.drawCanvas()
    local i = 1
    local j = 1
    --draws board
    for x = 0, width - 1 - offsetX, PIXEL_SIZE do
        for y = 0, height - 1 - offsetY, PIXEL_SIZE do
            if boards.getCellValue(i, j) == 1 then
                love.graphics.setColor(love.math.colorFromBytes(boards.getColor(i, j)))
                love.graphics.rectangle("fill", x + offsetX, y + offsetY, PIXEL_SIZE, PIXEL_SIZE)
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(canvasMenu.getCanvas(), 0, 0)

    if filenameWindow.screenState() == true and filenameWindow.getWait() == true then
        filenameWindow.drawWindow()
    elseif filenameWindow.screenState() == true then
        filenameWindow.switchWait()
    end
    clickAnimation.drawSprite()
    --debugPrint.setText(love.window.getDisplayName(1))
    --debugPrint.print()
end