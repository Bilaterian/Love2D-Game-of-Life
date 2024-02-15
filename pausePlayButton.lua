local pausePlayButton = {}
local FRAME_RATE = 7
local frame = 1
local isPaused = false

local button = {
    width = 400,
    height = 100,
    offsetX = 0,
    offsetY = 100,
    text = "Pause/Play",
}

function pausePlayButton.isFrame()
    if frame == FRAME_RATE then
        return true
    end
    return false
end

function pausePlayButton.resetFrame()
    frame = 1
end

function pausePlayButton.incrementFrame()
    frame = frame + 1
end

function pausePlayButton.switchStates()
    isPaused = not isPaused
end

function pausePlayButton.paused()
    return isPaused
end

function pausePlayButton.checkBounds(x, y)
    if x > button.offsetX and x < button.offsetX + button.width then
        if y > button.offsetY and y < button.offsetY + button.height then
            return true
        end
    end
    return false
end

function pausePlayButton.getButtonDimensions()
    return {button.offsetX, button.offsetY, button.width, button.height}
end

function pausePlayButton.getText()
    return button.text
end

return pausePlayButton