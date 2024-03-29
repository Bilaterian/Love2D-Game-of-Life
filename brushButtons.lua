local brushButtons = {}

    local colors = {
        {0, 0, 0, 255}, --black
        {157, 157, 157, 255}, --gray
        {255, 255, 255, 255}, --white
        {190, 38, 51, 255}, --red
        {224, 111, 139, 255}, --pink
        {73, 60, 43, 255}, --dark brown
        {164, 100, 34, 255}, --brown
        {235, 137, 49, 255}, --orange
        {247, 226, 107, 255}, --yellow
        {47, 72, 0, 255}, --dark green
        {68, 137, 26, 255}, --green
        {163, 206, 39, 255}, --yellow green
        {27, 38, 50, 255}, --dark blue
        {0, 87, 132, 255}, --blue
        {49, 162, 242, 255}, --light blue
        {178, 220, 239, 255}, --pale blue
        {255, 0, 255, 255}, -- magenta
        {100, 100, 100, 255}, --buttonColor
    }

    local currentColor = colors[3]

    local brushStates = {
        "PAINT",
        "ERASE",
        "COLOR"
    }

    local currentBrush = "PAINT"

    local paintButton = {
        width = 126,
        height = 95,
        offsetX = 5,
        offsetY = 305,
        text = "Draw",
        isPressed = false,
    }

    local eraseButton = {
        width = 126,
        height = 95,
        offsetX = 136,
        offsetY = 305,
        text = "Erase",
        isPressed = false,
    }
    local colorButton = {
        width = 128,
        height = 95,
        offsetX = 267,
        offsetY = 305,
        text = "Color",
        isPressed = false,
    }

    function brushButtons.getPaintButtonDimensions()
        return {paintButton.offsetX, paintButton.offsetY, paintButton.width, paintButton.height}
    end

    function brushButtons.getPaintText()
        return paintButton.text
    end

    function brushButtons.getEraseButtonDimensions()
        return {eraseButton.offsetX, eraseButton.offsetY, eraseButton.width, eraseButton.height}
    end

    function brushButtons.getEraseText()
        return eraseButton.text
    end

    function brushButtons.getColorButtonDimensions()
        return {colorButton.offsetX, colorButton.offsetY, colorButton.width, colorButton.height}
    end

    function brushButtons.getColorText()
        return colorButton.text
    end

    function brushButtons.getColor(i)
        if i == nil then
            return currentColor
        end
        return colors[i]
    end

    function brushButtons.getRandomColor()
        return colors[math.random(2, #colors - 1)]
    end

    function brushButtons.setBrush(x, y)
        if x > paintButton.offsetX and x < paintButton.offsetX + paintButton.width then
            if y > paintButton.offsetY and y < paintButton.offsetY + paintButton.height then
                currentBrush = brushStates[1]
                paintButton.isPressed = true
            end
        elseif x > eraseButton.offsetX and x < eraseButton.offsetX + eraseButton.width then
            if y > eraseButton.offsetY and y < eraseButton.offsetY + eraseButton.height then
                currentBrush = brushStates[2]
                eraseButton.isPressed = true
            end
        elseif x > colorButton.offsetX and x < colorButton.offsetX + colorButton.width then
            if y > colorButton.offsetY and y < colorButton.offsetY + colorButton.height then
                currentBrush = brushStates[3]
                colorButton.isPressed = true
            end
        end
    end

    function brushButtons.offButton()
        paintButton.isPressed = false
        eraseButton.isPressed = false
        colorButton.isPressed = false
    end

    function brushButtons.getPaintButtonState()
        return paintButton.isPressed
    end

    function brushButtons.getEraseButtonState()
        return eraseButton.isPressed
    end

    function brushButtons.getColorButtonState()
        return colorButton.isPressed
    end

    function brushButtons.getBrush()
        return currentBrush
    end

    local paintbox = {
        width = 35,
        height = 35,
    }

    local palette_selector = love.graphics.newImage("palette_selector.png")

    local XPAD = 25
    local YPAD = 410

    function brushButtons.drawPalette()
        local x = XPAD
        local y = YPAD

        love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
        love.graphics.rectangle("fill", XPAD - 5, YPAD - 5, 360, 90)
        for i = 2, #colors - 1 do
            love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(i)))
            love.graphics.rectangle("fill", x, y, paintbox.width, paintbox.height)
            if currentColor == colors[i] then
                love.graphics.draw(palette_selector, x - 5, y - 5)
            end
            x = x + paintbox.width + 10
            if x + paintbox.width >= 400 then
                x = XPAD
                y = y + paintbox.height + 10
            end
        end
    end

    function brushButtons.setColor(x, y)
        local offsetX = XPAD
        local offsetY = YPAD
        for i = 2, #colors - 1 do
            if x > offsetX and x < offsetX + paintbox.width then
                if y > offsetY and y < offsetY + paintbox.height then
                    currentColor = colors[i]
                end
            end

            offsetX = offsetX + paintbox.width + 10
            if offsetX + paintbox.width >= 400 then
                offsetX = XPAD
                offsetY = offsetY + paintbox.height + 10
            end
        end
        
    end

return brushButtons