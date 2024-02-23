local debugPrint = require "debugPrint"

local clickAnimation = {}

local animation = {
    x = 0,
    y = 0,
    width = 40,
    height = 40,
    source = "sprite.png",
    isPressed = false,
}
local image = love.graphics.newImage(animation.source)
local frames = {}

function clickAnimation.onLoad()
    frames.spriteSheet = image
    frames.quads = {}
    frames.currentFrame = 1

    for i = 1, 4 do
        table.insert(
            frames.quads, love.graphics.newQuad(
                (i - 1) * animation.width, 0, animation.width, animation.height, image:getDimensions()
            )
        )
    end
    debugPrint.setText("loaded")
    
end

function clickAnimation.animate()
    if animation.isPressed == true then
        frames.currentFrame = frames.currentFrame + 1
        if frames.currentFrame > 4 then
            frames.currentFrame = 1
            animation.isPressed = false
        end
        
    end
end

function clickAnimation.drawSprite()
    debugPrint.setText(frames.currentFrame .. "   " .. animation.x .. "   " .. animation.y)
    love.graphics.draw(frames.spriteSheet, frames.quads[frames.currentFrame], animation.x, animation.y)
end

function clickAnimation.onClick(x, y)
    animation.x = x - 10
    animation.y = y - 10
    animation.isPressed = true
end

function clickAnimation.isPressed()
    return animation.isPressed
end

return clickAnimation