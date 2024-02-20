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
        {255, 0, 255, 255} -- magenta
    }

    local currentColor = colors[4]

    local brushStates = {
        "PAINT",
        "ERASE",
        "COLOR"
    }

    local currentBrush = "PAINT"

    local paintButton = {
        width = 130,
        height = 100,
        offsetX = 0,
        offsetY = 300,
        text = "Paint",
    }

    local eraseButton = {
        width = 130,
        height = 100,
        offsetX = 135,
        offsetY = 300,
        text = "Erase",
    }
    local colorButton = {
        width = 130,
        height = 100,
        offsetX = 270,
        offsetY = 300,
        text = "Color",
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

    function brushButtons.setBrush(x, y)
        if x > paintButton.offsetX and x < paintButton.offsetX + paintButton.width then
            if y > paintButton.offsetY and y < paintButton.offsetY + paintButton.height then
                currentBrush = brushStates[1]
            end
        elseif x > eraseButton.offsetX and x < eraseButton.offsetX + eraseButton.width then
            if y > eraseButton.offsetY and y < eraseButton.offsetY + eraseButton.height then
                currentBrush = brushStates[2]
            end
        elseif x > colorButton.offsetX and x < colorButton.offsetX + colorButton.width then
            if y > colorButton.offsetY and y < colorButton.offsetY + colorButton.height then
                currentBrush = brushStates[3]
            end
        end
    end

    function brushButtons.getBrush()
        return currentBrush
    end

    local paintbox = {}


return brushButtons