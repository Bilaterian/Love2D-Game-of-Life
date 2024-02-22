local brushSizes = {}

    local brushButtons = require "brushButtons"
    local debugPrint = require "debugPrint"

    local brushSize = {
        1, --1x1
        3, --3x3
        5, --5x5
        7, --7x7
    }

    local brush = brushSize[1]

    function brushSizes.getArea(x, y)
        local area = {}
        if brush >= 1 then
            table.insert(area, {x, y})
        end
        if brush >= 3 then
            table.insert(area, {x - 5, y - 5})
            table.insert(area, {x, y - 5})
            table.insert(area, {x + 5, y - 5})
            table.insert(area, {x - 5, y})
            table.insert(area, {x + 5, y})
            table.insert(area, {x - 5, y + 5})
            table.insert(area, {x, y + 5})
            table.insert(area, {x + 5, y + 5})
        end
        if brush >= 5 then
            table.insert(area, {x - 5, y - 10})
            table.insert(area, {x, y - 10})
            table.insert(area, {x + 5, y - 10})
            table.insert(area, {x - 10, y - 5})
            table.insert(area, {x + 10, y - 5})
            table.insert(area, {x - 10, y})
            table.insert(area, {x + 10, y})
            table.insert(area, {x - 10, y + 5})
            table.insert(area, {x + 10, y + 5})
            table.insert(area, {x - 5, y + 10})
            table.insert(area, {x, y + 10})
            table.insert(area, {x + 5, y + 10})
        end
        if brush == 7 then
            table.insert(area, {x - 5, y - 15})
            table.insert(area, {x, y - 15})
            table.insert(area, {x + 5, y - 15})
            table.insert(area, {x - 10, y - 10})
            table.insert(area, {x + 10, y - 10})
            table.insert(area, {x - 15, y - 5})
            table.insert(area, {x + 15, y - 5})
            table.insert(area, {x - 15, y})
            table.insert(area, {x + 15, y})
            table.insert(area, {x - 15, y + 5})
            table.insert(area, {x + 15, y + 5})
            table.insert(area, {x - 10, y + 10})
            table.insert(area, {x + 10, y + 10})
            table.insert(area, {x - 5, y + 15})
            table.insert(area, {x, y + 15})
            table.insert(area, {x + 5, y + 15})
        end
        return area
    end

    function brushSizes.setBrush(i)
        brush = brushSize[i]
    end

    local button = {
        width = 93,
        height = 95,
        offsetX = 5,
        offsetY = 500,
    }

    function brushSizes.drawButtons()
        local x = button.offsetX
        for i = 1, #brushSize do
            love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(18)))
            love.graphics.rectangle("fill", x, button.offsetY, button.width, button.height)

            local font = love.graphics.newFont(24)
            local textString = "x" .. tostring(brushSize[i])
            local text = love.graphics.newText(font, textString)
            local width = ((button.width - font:getWidth(textString)) / 2) + x
            local height = ((button.height - font:getHeight(textString)) / 2) + button.offsetY
            love.graphics.setColor(love.math.colorFromBytes(brushButtons.getColor(1)))
            love.graphics.draw(text, width, height)

            x = x + button.offsetX + button.width
        end
    end

    function brushSizes.checkBounds(x, y)
        local offsetX = button.offsetX
        for i = 1, #brushSize do
            if x > offsetX and x < offsetX + button.width then
                if y > button.offsetY and y < button.offsetY + button.height then
                    brush = brushSize[i]
                end
            end
            offsetX = offsetX + button.offsetX + button.width
        end
    end

return brushSizes