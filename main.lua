---@diagnostic disable: undefined-global
local colors = {
    {255, 0, 0},
    {0, 255, 0},
    {0, 0, 255},
    {0, 0, 0},
    {255, 255, 255},
}

local board = {}
local nextBoard = {}

local PIXEL_SIZE = 5

local width, height, flags = love.window.getMode( )

local boardWidth = math.floor(width/PIXEL_SIZE)
local boardHeight = math.floor(height/PIXEL_SIZE)

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

function love.load()
    for i = 1, boardWidth do
        board[i] = {}
        nextBoard[i] ={}
        for j = 1, boardHeight do
            board[i][j] = math.random(0,1)
            nextBoard[i][j] = 0
        end
    end
end

function love.update(dt)
--want to check board here
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

function love.draw()
    local i = 1
    local j = 1
    for x = 0, width - 1, PIXEL_SIZE do
        for y = 0, height - 1, PIXEL_SIZE do
            if board[i][j] == 1 then
                love.graphics.setColor(colors[5])
                love.graphics.rectangle("fill", x, y, PIXEL_SIZE, PIXEL_SIZE)
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end
end