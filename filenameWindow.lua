local filenameWindow = {}

local brushButtons = require "brushButtons"
local printButton  = require "printButton"

local window = {
    width = 400,
    height = 300,
    offsetX = 200,
    offsetY = 130,
}

local closeButton = {
    width = 35,
    height = 35,
    offsetX = 565,
    offsetY = 130,
    isPressed = false,
}

local saveButton = {
    width = 350,
    height = 75,
    offsetX = 225,
    offsetY = 300,
    text = "Save",
    isPressed = false,
}
local texBox = {
    width = 350,
    height = 50,
    offsetX = 225,
    offsetY = 200,
}

local screenOn = false

local defaultFilename = os.time()..".png"
local fileName = ""

function filenameWindow.drawWindow()
    --window
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.rectangle("line", window.offsetX - 1, window.offsetY - 1, window.width + 2, window.height + 2)
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
    love.graphics.rectangle("fill", window.offsetX, window.offsetY, window.width, window.height)
    --closeButton
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.rectangle("line", closeButton.offsetX - 1, closeButton.offsetY - 1, closeButton.width + 2, closeButton.height + 2)
    if closeButton.isPressed == false then
        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(love.math.colorFromBytes(127, 0, 0, 255))
    end
    love.graphics.rectangle("fill", closeButton.offsetX, closeButton.offsetY, closeButton.width, closeButton.height)
    --saveButton
    if saveButton.isPressed == false then
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
    else
        love.graphics.setColor(love.math.colorFromBytes(80, 80, 80, 255))
    end
    love.graphics.rectangle("fill", saveButton.offsetX, saveButton.offsetY, saveButton.width, saveButton.height)

    local font = love.graphics.newFont(24)
    local text = love.graphics.newText(font, saveButton.text)
    local width = ((saveButton.width - font:getWidth(saveButton.text)) / 2) + saveButton.offsetX
    local height = ((saveButton.height - font:getHeight(saveButton.text)) / 2) + saveButton.offsetY
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.draw(text, width, height)

    text = love.graphics.newText(font, "Save As")
    love.graphics.draw(text, 225 , 170)
    --textBox
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
    love.graphics.rectangle("line", texBox.offsetX - 1, texBox.offsetY - 1, texBox.width + 2, texBox.height + 2)
    love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(3)))
    love.graphics.rectangle("fill", texBox.offsetX, texBox.offsetY, texBox.width, texBox.height)

    if #fileName == 0 then
        text = love.graphics.newText(font, defaultFilename)
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
        love.graphics.draw(text, 230 , 210)
        text = love.graphics.newText(font, ".png")
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
        love.graphics.draw(text, 230 + font:getWidth(defaultFilename), 210)
    else
        text = love.graphics.newText(font, fileName)
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
        love.graphics.draw(text, 230 , 210)
        text = love.graphics.newText(font, ".png")
        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(2)))
        love.graphics.draw(text, 230 + font:getWidth(fileName), 210)
    end

end

function filenameWindow.onScreen()
    screenOn = true
end

function filenameWindow.offScreen()
    screenOn = false
end

function filenameWindow.screenState()
    return screenOn
end

function filenameWindow.printFile()
    if #fileName > 0 then
        printButton.setFilename(fileName)
    else
        printButton.setFilename(defaultFilename)
    end
    printButton.saveScreenshot()
    screenOn = false
    fileName = ""
end

function filenameWindow.checkBounds(x, y)
    if x >= closeButton.offsetX and x <= closeButton.offsetX + closeButton.width then
        if y >= closeButton.offsetY and y <= closeButton.offsetY + closeButton.height then
            closeButton.isPressed = true
            screenOn = false
            fileName = ""
        end
    elseif x >= saveButton.offsetX and x <= saveButton.offsetX + saveButton.width then
        if y >= saveButton.offsetY and y <= saveButton.offsetY + saveButton.height then
            saveButton.isPressed = true
            filenameWindow.printFile()
        end
    end
end

function filenameWindow.unPressed()
    closeButton.isPressed = false
    saveButton.isPressed = false
end

function filenameWindow.updateDefaultFilename()
    defaultFilename = os.time()
end

function filenameWindow.updateFilename(text)
    fileName = text
end

return filenameWindow