local brushButtons = {}

    local colors = {
        {255, 0, 0},
        {0, 255, 0},
        {0, 0, 255},
        {0, 0, 0},
        {255, 255, 255},
    }

    local currentColor = 0

    local brushStates = {
        "PAINT",
        "ERASE",
        "COLOR"
    }

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
        offsetY = 200,
        text = "Erase",
    }
    local colorButton = {
        width = 130,
        height = 100,
        offsetX = 270,
        offsetY = 200,
        text = "Color",
    }

    function brushButtons.getColor(i)
        return colors[i]
    end

return brushButtons