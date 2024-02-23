local generateButton = {}
local seed = 0
local button = {
    width = 390,
    height = 95,
    offsetX = 5,
    offsetY = 5,
    text = "Generate",
    isPressed = false,
}

function generateButton.setSeed(newSeed)
    if newSeed == nil then
        math.randomseed(os.time())
    else
        seed = newSeed
    end
end

function generateButton.checkBounds(x,y)
    if x > button.offsetX and x < button.offsetX + button.width then
        if y > button.offsetY and y < button.offsetY + button.height then
            return true
        end
    end
    return false
end

function generateButton.getButtonDimensions()
    return {button.offsetX, button.offsetY, button.width, button.height}
end

function generateButton.getText()
    return button.text
end

function generateButton.pressed()
    button.isPressed = true
end

function generateButton.unPressed()
    button.isPressed = false
end

function generateButton.getPressedState()
    return button.isPressed
end

return generateButton