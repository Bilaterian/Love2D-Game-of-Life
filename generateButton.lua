local generateButton = {}
local seed = 0
local button = {
    width = 10,
    heigt = 10,
    text = "generate",
    clicked = false,
}



function generateButton.setSeed(newSeed)
    if newSeed == nil then
        math.randomseed(os.time())
    else
        seed = newSeed
    end
    
end

return generateButton