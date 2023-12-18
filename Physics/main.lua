function love.load()
    wf = require 'libraries/windfield'

    -- 1. Create world
    world = wf.newWorld(0, 500)-- x, y
    -- +ve value of y means downwards gravity

    player = world:newRectangleCollider(350, 100, 80, 80) -- x, y, width, height
    ground = world:newRectangleCollider(100, 400, 600, 100)
    -- change type of ground so that it wont be falling and will stay still
    ground:setType("static")
end

function love.update(dt)
    local px, py = player:getLinearVelocity()
    if love.keyboard.isDown('left') and px > -3000 then
        -- get actual speed of player
        player:applyForce(-8000, 0)
    elseif love.keyboard.isDown('right') and px < 3000 then
        player:applyForce(8000, 0)
    end
    world:update(dt)
end 

function love.draw()
    world:draw()
end

-- making player jump on impulse
function love.keypressed(key)
    if key == 'up' then
        player:applyLinearImpulse(0, -5000) -- -ve y value means it will push player upward
    end
    
end