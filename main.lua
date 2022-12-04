
--[[

This is a shooter game to learn Lua.
It it realy important whit naming.
The 
]]

-- Load the love content
-- Variable is decleard in this function
function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50
    score = 0
    timer = 0
    gameState = 1
    
    gameFont = love.graphics.newFont(40)
    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    love.mouse.setVisible(false)
    --love.mouse.setRelativeMode(true)
end

-- Delta time function
-- The variables will be updated in the update function
function love.update(dt)

    if timer > 0 then
        timer = timer - dt
    end

    if timer < 0 then
        timer = 0
        gameState = 1
    end
end

-- Draws everything on the screens. Do not put other code.
function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)
    -- Initial ponter to set the target. 
    --[[
        love.graphics.setColor(1,0,0)
        love.graphics.circle("fill", target.x,target.y,target.radius)
    ]]

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: ".. score,10,10)
    love.graphics.print("Timer: " ..math.ceil(timer),300,10)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin the game!", 0, 250, love.graphics.getWidth(), "center")
    end
    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
        love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
end

-- Controlls the mose klick
function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 and gameState == 2 then
        local moseToTarget = distanceBetween(x, y, target.x, target.y)
        if moseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() -target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() -target.radius)
        end
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

-- this is a formel for klick in the target
function distanceBetween(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end
