Rover = {
    love.graphics.setDefaultFilter("nearest", "nearest"),
    image = love.graphics.newImage("images/rover.png"),
    x = math.random(800,1600),
    y = 500,
    speed = 300
}

function Rover:new(scale)
    local newRover = {}
    local width = self.image:getWidth()
    local height = self.image:getHeight()
    newRover.width = width * scale
    newRover.height = height * scale
    newRover.scale = scale
    newRover.left = self.x
    newRover.right = self.x + newRover.width
    newRover.top = self.y + 20
    newRover.bottom = self.y + newRover.height
    setmetatable(newRover, self)
    self.__index = self
    return newRover
end

function Rover:update(dt)
    self:moove(dt)
    if PlayerCollision(self, MyPlayer) then
        Running = false
        IsGameOver = true
        Gameover:play()
        Music:stop()
    end
end


function Rover:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale)
end

function Rover:moove(dt)
    self.x = self.x - (self.speed * dt)
    if self.x + self.width < 0 then
        self:reset()
    end
    self.left = self.x
    self.right = self.x + self.width
end

function Rover:reset()
    repeat
        self.x = math.random(800,1600)
        local distance = math.abs((self.x - MyShip.x))
    until (distance > 350)
end