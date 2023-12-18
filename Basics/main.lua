
function randomText()
    return 'This is some bullshit i want them to see'
end
function love.load()
    anim8 = require 'libraries/anim8'
    -- to avoid blurry image
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- To load map into game
    sti = require 'libraries/sti'
    gameMap = sti('maps/testMap.lua')

    -- Loading camera
    camera = require 'libraries/camera'
    cam = camera()

    -- loading font and dialove
    Dialove = require 'libraries/Dialove'
    dialogManager = Dialove.init({
        font = love.graphics.newFont("fonts/ARCADECLASSIC.TTF", 26)
    })
    dialogManager:show({text = randomText(), title = 'Title of quest'}) 
    -- dialogManager:show({text = "some 2nd random bullshit", title = "title of quest 2"})

    player = {}
    player.x = 400
    player.y = 200
    player.speed = 6
    player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png')

    player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animation = {}
    -- Inside player.grid 1st specify column i.e. from 1 to 4 and which row the down comes from which is 1
    -- 0.2 means frames will change every 0.2 secs
    player.animation.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
    player.animation.left = anim8.newAnimation(player.grid('1-4', 2), 0.2)
    player.animation.right = anim8.newAnimation(player.grid('1-4', 3), 0.2)
    player.animation.up = anim8.newAnimation(player.grid('1-4', 4), 0.2)

    -- players animation direction 
    player.anim = player.animation.left

    background = love.graphics.newImage('sprites/background.png')
end

function love.update(dt)
    local isMoving = false
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animation.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animation.left
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.anim = player.animation.up
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animation.down
        isMoving = true
    end

    if isMoving == false then
        -- use 2nd fram of each row which indicates the still standing position of object
        player.anim:gotoFrame(2)
    end
    player.anim:update(dt)

    -- Making view to move alongside camera
    cam:lookAt(player.x, player.y)

    -- Check width and height of screen so that we don't get black screen
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    -- For eliminating left border
    if cam.x < w / 2 then
        cam.x = w / 2
    end
    -- For eliminating top border
    if cam.y < h / 2 then
        cam.y = h / 2
    end
    -- Get width/height of background
    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight
    -- Right border
    if cam.x > (mapW - w / 2) then
        cam.x = (mapW - w / 2)
    end
    -- Bottom border
    if cam.y > (mapH - h / 2) then
        cam.y = (mapH - h / 2)
    end

    dialogManager:update(dt)

end

function love.draw()
    -- Everything needs to be seen through perspective of camera
    cam:attach()
    -- These 2 lines are for making large map which will follow the camera
    gameMap:drawLayer(gameMap.layers["Ground"])
    gameMap:drawLayer(gameMap.layers["Trees"])
    -- gameMap:draw()
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 6, nil, 6, 9) -- scale 6 times but its blurry
    cam:detach()

    dialogManager:draw()

end
