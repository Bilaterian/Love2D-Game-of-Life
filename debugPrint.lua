local debugPrint = {}
    local textString = ""
    function debugPrint.print()
        local font = love.graphics.newFont(24)
        local text = love.graphics.newText(font, textString)
        love.graphics.setColor(255, 0, 0)
        love.graphics.draw(text, 0, 0)
    end

    function debugPrint.setText(text)
        textString = text
    end
return debugPrint