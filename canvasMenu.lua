local canvasMenu = {}

local generateButton = require "generateButton"
local pausePlayButton = require "pausePlayButton"
local printButton = require "printButton"
local brushButtons = require "brushButtons"
local brushSizes = require "brushSizes"

local canvas = love.graphics.newCanvas(400, 800)

function canvasMenu.drawCanvas()
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", 0, 0, 400, 800)
    --draws generate button
    local dimensions = generateButton.getButtonDimensions()
    if generateButton.getPressedState() == false then
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
    else
        love.graphics.setColor(love.math.colorFromBytes(80, 80, 80, 255))
    end
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    local font = love.graphics.newFont("Pixel.ttf",20)
    love.graphics.setFont(font)

    local text = love.graphics.newText(font, generateButton.getText())
    local width = ((dimensions[3] - font:getWidth(generateButton.getText())) / 2) + dimensions[1]
    local height = ((dimensions[4] - font:getHeight(generateButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    --draws pause/play button
    dimensions = pausePlayButton.getButtonDimensions()
    if pausePlayButton.getPressedState() == false then
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
    else
        love.graphics.setColor(love.math.colorFromBytes(80, 80, 80, 255))
    end
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    text = love.graphics.newText(font, pausePlayButton.getText())
    width = ((dimensions[3] - font:getWidth(pausePlayButton.getText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(pausePlayButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    --draws print button
    dimensions = printButton.getButtonDimensions()
    love.graphics.setColor(love.math.colorFromBytes(80, 80, 80, 255))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    --[[
    string = "Print is available in Windows Version"
    text = love.graphics.newText(font, string)
    width = ((dimensions[3] - font:getWidth(string)) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(string)) / 2) + dimensions[2]
    love.graphics.setColor(brushButtons.getColor(1))
    love.graphics.draw(text, width, height)]]--

    --draws paint, erase and color buttons
    dimensions = brushButtons.getPaintButtonDimensions()
    if brushButtons.getBrush() == "PAINT" then
        love.graphics.setColor(love.math.colorFromBytes(80, 80, 80, 255))
    else
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
    end
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    text = love.graphics.newText(font, brushButtons.getPaintText())
    width = ((dimensions[3] - font:getWidth(brushButtons.getPaintText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(brushButtons.getPaintText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    dimensions = brushButtons.getEraseButtonDimensions()
    if brushButtons.getBrush() == "ERASE" then
        love.graphics.setColor(love.math.colorFromBytes(80, 80, 80, 255))
    else
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
    end
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    text = love.graphics.newText(font, brushButtons.getEraseText())
    width = ((dimensions[3] - font:getWidth(brushButtons.getEraseText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(brushButtons.getEraseText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width + 3, height)

    dimensions = brushButtons.getColorButtonDimensions()
    if brushButtons.getBrush() == "COLOR" then
        love.graphics.setColor(love.math.colorFromBytes(80, 80, 80, 255))
    else
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
    end
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    text = love.graphics.newText(font, brushButtons.getColorText())
    width = ((dimensions[3] - font:getWidth(brushButtons.getColorText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(brushButtons.getColorText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width + 3, height)

    brushButtons.drawPalette()
    brushSizes.drawButtons()
    love.graphics.setCanvas()
end

function canvasMenu.getCanvas()
    return canvas
end

return canvasMenu