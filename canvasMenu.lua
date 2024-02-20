local canvasMenu = {}

local generateButton = require "generateButton"
local pausePlayButton = require "pausePlayButton"
local printButton = require "printButton"
local brushButtons = require "brushButtons"

local canvas = love.graphics.newCanvas(400, 800)

function canvasMenu.drawCanvas()
    love.graphics.setCanvas(canvas)
    --draws generate button
    local dimensions = generateButton.getButtonDimensions()
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    local font = love.graphics.newFont(24)
    local text = love.graphics.newText(font, generateButton.getText())
    local width = ((dimensions[3] - font:getWidth(generateButton.getText())) / 2) + dimensions[1]
    local height = ((dimensions[4] - font:getHeight(generateButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    --draws pause/play button
    dimensions = pausePlayButton.getButtonDimensions()
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    font = love.graphics.newFont(24)
    text = love.graphics.newText(font, pausePlayButton.getText())
    width = ((dimensions[3] - font:getWidth(pausePlayButton.getText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(pausePlayButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    --draws print button
    dimensions = printButton.getButtonDimensions()
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    font = love.graphics.newFont(24)
    text = love.graphics.newText(font, printButton.getText())
    width = ((dimensions[3] - font:getWidth(printButton.getText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(printButton.getText())) / 2) + dimensions[2]
    love.graphics.setColor(brushButtons.getColor(1))
    love.graphics.draw(text, width, height)

    --draws paint, erase and color buttons
    dimensions = brushButtons.getPaintButtonDimensions()
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    font = love.graphics.newFont(24)
    text = love.graphics.newText(font, brushButtons.getPaintText())
    width = ((dimensions[3] - font:getWidth(brushButtons.getPaintText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(brushButtons.getPaintText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    dimensions = brushButtons.getEraseButtonDimensions()
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    font = love.graphics.newFont(24)
    text = love.graphics.newText(font, brushButtons.getEraseText())
    width = ((dimensions[3] - font:getWidth(brushButtons.getEraseText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(brushButtons.getEraseText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    dimensions = brushButtons.getColorButtonDimensions()
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", dimensions[1], dimensions[2], dimensions[3], dimensions[4])
    
    font = love.graphics.newFont(24)
    text = love.graphics.newText(font, brushButtons.getColorText())
    width = ((dimensions[3] - font:getWidth(brushButtons.getColorText())) / 2) + dimensions[1]
    height = ((dimensions[4] - font:getHeight(brushButtons.getColorText())) / 2) + dimensions[2]
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)
    love.graphics.setCanvas()
end

function canvasMenu.getCanvas()
    return canvas
end

return canvasMenu