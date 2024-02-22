local printButton = {}

local button = {
    width = 390,
    height = 95,
    offsetX = 5,
    offsetY = 205,
    text = "Print",
}

local separator = package.config:sub(1,1)

function printButton.checkBounds(x, y)
    if x > button.offsetX and x < button.offsetX + button.width then
        if y > button.offsetY and y < button.offsetY + button.height then
            return true
        end
    end
    return false
end

function printButton.getButtonDimensions()
    return {button.offsetX, button.offsetY, button.width, button.height}
end

function printButton.getText()
    return button.text
end

function printButton.setText(text)
    button.text = text
end

function printButton.mkdir(path)
    -- Notice we are using %q to allow for spaces (and prevent command injection)
    os.execute(string.format("mkdir %q", path)) -- System dependant
end

local function combinePaths(...)
    return (table.concat({...}, separator):gsub(separator .. "+", separator)) -- System dependant
end

local screenshotDirectory = combinePaths(love.filesystem.getWorkingDirectory(), "Pictures")


function printButton.getScreenshotDirectory()
    return screenshotDirectory
end

local fileName = os.time()..".png"

function printButton.setFilename(text)
    fileName = text..".png"
end

function printButton.saveScreenshot()
    local filePath = combinePaths(love.filesystem.getSaveDirectory(), fileName)
    local destPath = combinePaths(screenshotDirectory, fileName)

    local width, height = 400, 600
    local croppedImageData = love.image.newImageData(width, height)
    ---@param image love.ImageData
    love.graphics.captureScreenshot(function(image)
        croppedImageData:paste(image, 0, 0, 400, 0, 400, 600)
        croppedImageData:encode("png", fileName)
        os.rename(filePath, destPath)
    end)
end

return printButton