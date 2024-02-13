function test()
    local colors = {
        {255, 0, 0},
        {0, 255, 0},
        {0, 0, 255},
        {0, 0, 0},
        {255, 255, 255},
    }
    
    local board = {}
    
    local PIXEL_SIZE = 5
    
    local width = 600
    local height = 800
    
    print(width, height)
    print(width/PIXEL_SIZE, height/PIXEL_SIZE)
    for i = 1, width/PIXEL_SIZE do
        board[i] = {}
        for j = 1, height/PIXEL_SIZE do
            board[i][j] = math.random(0,1)
            --print(i,j, board[i][j])
        end
    end
    local i = 1
    local j = 1
    
    for x = 0, width - 1, PIXEL_SIZE do
        for y = 0, height - 1, PIXEL_SIZE do
            print(x, y, i, j)
            if board[i][j] == 1 then
                --print(i, j)
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end
    
end

test()