local boards = {}

local board = {}
local nextBoard = {}
local colorBoard = {}

local boardWidth = 0;
local boardHeight = 0;

local xBound = 400
local yBound = 0

local brushButtons = require "brushButtons"

function boards.checkBounds(x, y)
    if x > xBound and x < xBound + 800 then
        if y > yBound and y < yBound + 800 then
            return true
        end
    end
    return false
end

function boards.setWidth(width)
    boardWidth = width
end

function boards.setHeight(height)
    boardHeight = height
end

function boards.getCellValue(i, j)
    return board[i][j]
end

function boards.populateBoard()
    for i = 1, boardWidth do
        board[i] = {}
        nextBoard[i] = {}
        colorBoard[i] = {}
        for j = 1, boardHeight do
            board[i][j] = math.random(0,1)
            nextBoard[i][j] = 0
            colorBoard[i][j] = brushButtons.getRandomColor()
        end
    end
end

local function isInList(list, colorNum)
    local numColor = 0

    for i = 1, #list do
        numColor = table.concat(list[i][1],"")
        if numColor == colorNum then
            return i
        end
    end
    return -1
end

local function voteColor(colorList)
    local color = colorList[1]
    for i = 2, #colorList do
        if colorList[i][2] > color[2] then
            color = colorList[i]
        end
    end

    return color[1]
end

local function checkNeighbors(x, y)
    local isLive = board[x][y]
    local liveNeigbors = 0
    local neighborColors = {}

    local neighbors = {
        topLeft =     {x-1, y-1},
        top =         {x,   y-1},
        topRight =    {x+1, y-1},
        left =        {x-1, y},
        right =       {x+1, y},
        bottomLeft =  {x-1, y+1},
        bottom =      {x,   y+1},
        bottomRight = {x+1, y+1}
    }

    for key, value in pairs(neighbors) do
        if value[1] > 0 and value[1] <= boardWidth then
            if value[2] > 0 and value[2] <= boardHeight then
                if board[value[1]][value[2]] == 1 then
                    liveNeigbors = liveNeigbors + 1

                    if next(neighborColors) == nil then
                        table.insert(neighborColors, {colorBoard[value[1]][value[2]], 1})
                    else
                        local listval = isInList(neighborColors, table.concat(colorBoard[value[1]][value[2]]))
                        if listval > 0 then
                            neighborColors[listval][2] = neighborColors[listval][2] + 1
                        else
                            table.insert(neighborColors, {colorBoard[value[1]][value[2]], 1})
                        end
                    end

                end
            end
        end
    end

    if next(neighborColors) ~= nil then
        colorBoard[x][y] = voteColor(neighborColors)
    end

    if liveNeigbors < 2 then
        return 0
    elseif liveNeigbors > 3 then
        return 0
    elseif liveNeigbors == 3 then
        return 1
    elseif isLive == 1 and liveNeigbors == 2 then
        return 1
    end
end

function boards.transferBoards()
    for i = 1, boardWidth do
        for j = 1, boardHeight do
            nextBoard[i][j] = checkNeighbors(i,j)
        end
    end
    for i = 1, boardWidth do
        for j = 1, boardHeight do
            board[i][j] = nextBoard[i][j]
        end
    end
end

function boards.onCell(i, j)
    board[i][j] = 1
end

function boards.offCell(i, j)
    board[i][j] = 0
end

function boards.getColor(i, j)
    return colorBoard[i][j]
end

function boards.setColor(i, j, color)
    colorBoard[i][j] = color
end

return boards