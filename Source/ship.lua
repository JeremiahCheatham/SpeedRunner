Ship = {
    love.graphics.setDefaultFilter("nearest", "nearest"),
    image = love.graphics.newImage("images/flying_saucer.png"),
    x = math.random(800,1600),
    y = 435,
    speed = 300
}

function Ship:new(scale)
    local newShip = {}
    local width = self.image:getWidth()
    local height = self.image:getHeight()
    newShip.width = width * scale
    newShip.height = height * scale
    newShip.scale = scale
    newShip.left = self.x
    newShip.right = self.x + newShip.width
    newShip.top = self.y + (newShip.height / 2)
    newShip.bottom = self.y + newShip.height
    setmetatable(newShip, self)
    self.__index = self
    return newShip
end

function Ship:update(dt)
    self:moove(dt)
    if PlayerCollision(self, MyPlayer) then
        Running = false
        IsGameOver = true
        Gameover:play()
        Music:stop()
    end
end


function Ship:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale)
end

function Ship:moove(dt)
    self.x = self.x - (self.speed * dt)
    if self.x + self.width < 0 then
        self:reset()
    end
    self.left = self.x
    self.right = self.x + self.width
end

function Ship:reset()
    repeat
        self.x = math.random(800,1600)
        local distance = math.abs((self.x - MyRover.x))
    until (distance > 350)
end
