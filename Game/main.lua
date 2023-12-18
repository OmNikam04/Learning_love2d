-- main.lua

local dialogues = require "dialogues"

local currentDialogue = 2

function love.draw()
    love.graphics.print(dialogues[currentDialogue].character .. ": " .. dialogues[currentDialogue].text, 20, 20)
    -- Display options if available
    if dialogues[currentDialogue].options then
        for i, option in ipairs(dialogues[currentDialogue].options) do
            love.graphics.print(i .. ". " .. option.text, 30, 50 + i * 20)
        end
    end
end

function love.keypressed(key)
    if dialogues[currentDialogue].options then
        local option = tonumber(key)
        if option and dialogues[currentDialogue].options[option] then
            currentDialogue = dialogues[currentDialogue].options[option].next
        end
    else
        currentDialogue = currentDialogue + 1
    end
end
