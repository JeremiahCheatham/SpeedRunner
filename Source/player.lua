Player = {
    love.graphics.setDefaultFilter("nearest", "nearest"),
    spriteSheet = love.graphics.newImage("images/player.png"),
    slideImage = love.graphics.newImage("images/slide.png"),
    x = 100,
    y = 495,
    bottomY = 495,
    speed = 500,
    spriteNum = 1,
    jump = false,
    slide = false,
    yvel = 0,
    yaccel = 400,
    ydeccel = 500,
    slideTime = 0,
    targetTime = 1
}

function Player:new(width, height, scale, duration)
    local newPlayer = {}
    newPlayer.quads = {}
    for y = 0, self.spriteSheet:getHeight() - height, height do
        for x = 0, self.spriteSheet:getWidth() - width, width do
            table.insert(newPlayer.quads, love.graphics.newQuad(x, y, width, height, self.spriteSheet:getDimensions()))
        end
    end
    newPlayer.width = width * scale
    newPlayer.height = height * scale
    newPlayer.scale = scale
    newPlayer.left = self.x + 10
    newPlayer.right = self.x + newPlayer.width - 10
    newPlayer.top = self.y
    newPlayer.bottom = self.y + newPlayer.height
    newPlayer.duration = duration or 1
    newPlayer.currentTime = 0
    setmetatable(newPlayer, self)
    self.__index = self
    return newPlayer
end

function Player:update(dt)
    self:input()
    self:moove(dt)
    self:animate(dt)
end

function Player:input()
    if not self.slide and not self.jump then
        if love.keyboard.isDown("up") then
            self.jump = true
            self.yvel = self.yaccel
        end
        if love.keyboard.isDown("down") then
            self.slide = true
        end
    end
end


function Player:draw()
    if self.jump then
        love.graphics.draw(self.spriteSheet, self.quads[3], self.x, self.y, 0, self.scale, self.scale)
    elseif self.slide then
        love.graphics.draw(self.slideImage, self.x, self.y, 0, self.scale, self.scale)
    else
        love.graphics.draw(self.spriteSheet, self.quads[self.spriteNum], self.x, self.y, 0, self.scale, self.scale)
    end
end

function Player:moove(dt)
    if self.jump then
        self.y = self.y - (self.yvel * dt)
        if self.y >= self.bottomY then
            self.y = self.bottomY
            self.jump = false
            self.yvel = 0
        else
            self.yvel = self.yvel - (dt * self.ydeccel)
        end
    elseif self.slide then
        self.slideTime = self.slideTime + dt
        if self.slideTime > self.targetTime then
            self.slideTime = 0
            self.slide = false
        end
    end
    if self.slide then
        self.top = self.y + 20
    else
        self.top = self.y
    end
    self.bottom = self.y + self.height
end

function Player:animate(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime >= self.duration then
        self.currentTime = self.currentTime - self.duration
    end
    self.spriteNum = math.floor(self.currentTime / self.duration * (#self.quads - 1)) + 2
end

function Player:reset()
    self.y = self.bottomY
end