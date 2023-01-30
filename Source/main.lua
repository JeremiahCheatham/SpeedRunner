require("player")
require("ship")
require("rover")

function love.load()
    -- load game graphics
    love.graphics.setDefaultFilter("nearest", "nearest")
    Background = love.graphics.newImage("images/background2.png")

    -- load game music
    Gameover = love.audio.newSource("sounds/gameover.ogg", "static")
    Music = love.audio.newSource("music/music.ogg", "stream")
    Music:play()

    -- instantiate game objects
    MyPlayer = Player:new(12, 16, 5, 0.4)
    MyShip = Ship:new(5)
    MyRover = Rover:new(5)

    -- game variables
    Running = false
    IsGameOver = false
    Time = 0

    -- fonts
    TimeFont = love.graphics.newFont(35)
    GameFont = love.graphics.newFont(60)
end

function love.keypressed(k)
    if k == 'escape' then
       love.event.quit()
    elseif k == "space" then
        Time = 0
        MyPlayer:reset()
        MyRover:reset()
        MyShip:reset()
        Music:play()
        Running = true
        IsGameOver = false
    end
end

function love.update(dt)
    if Running then
        MyPlayer:update(dt)
        MyShip:update(dt)
        MyRover:update(dt)
        Time = Time + dt
    end
end


function love.draw()
    love.graphics.draw(Background, 0, 0, 0, 1)
    MyPlayer:draw()
    MyShip:draw()
    MyRover:draw()
    love.graphics.setFont(TimeFont)
    love.graphics.print(tostring(math.floor(Time)), 20, 20)
    love.graphics.setFont(GameFont)
    if not Running then
        love.graphics.printf("PrEsS sPaCe", 0, 400, love.graphics.getWidth(), "center")
        if IsGameOver then
            love.graphics.printf("GaMe OvEr!", 0, 200, love.graphics.getWidth(), "center")
        else
            love.graphics.printf(">>S.P.E.E.D.RUNNER>>", 0, 200, love.graphics.getWidth(), "center")
        end
    end
end

function PlayerCollision(a, b)
    if a.right > b.left and a.left < b.right and a.bottom > b.top and a.top < b.bottom then
        return true
    else
        return false
    end
end