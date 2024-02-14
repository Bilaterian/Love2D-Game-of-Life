local boards = {}

local board = {}
local nextBoard = {}

local boardWidth = 0;
local boardHeight = 0;

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
        for j = 1, boardHeight do
            board[i][j] = math.random(0,1)
            nextBoard[i][j] = 0
        end
    end
end

local function checkNeighbors(x, y)
    local isLive = board[x][y]
    local liveNeigbors = 0

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
                end
            end
        end
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

return boards