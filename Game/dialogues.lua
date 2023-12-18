-- dialogues.lua

local dialogues = {
    {
        text = "Welcome to the EcoCraft Challenge!",
        character = "Guide",
    },
    {
        text = "You are tasked with crafting eco-friendly objects to save the planet.",
        character = "Guide",
        options = {
            { text = "Yes", next = 1 },
            { text = "No", next = 4 },
        },
    },
    {
        text = "Do you accept the challenge?",
        character = "Guide",
        options = {
            { text = "Yes", next = 4 },
            { text = "No", next = 6 },
        },
    },
    {
        text = "Last one?",
        character = "Guide",
        options = {
            { text = "Yes", next = 4 },
            { text = "No", next = 6 },
        },
    },
    -- More dialogues...
}

return dialogues
