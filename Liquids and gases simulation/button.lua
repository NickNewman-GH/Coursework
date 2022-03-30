Button = Object:extend()

function Button:new(x, y, width, height, action, text)
    self.x = x
    self.y = y
    self.pressedColor = {0.7, 0.7, 0.7, 0.7}
    self.releaseColor = {1, 1, 1, 0.7}
    self.textColor = {0, 0, 0, 0.7}
    self.color = self.releaseColor
    self.width = width
    self.height = height
    self.action = action
    self.text = text
end

function Button:draw(fieldClass, newField, dt)
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    local text = love.graphics.newText(font, self.text)
    love.graphics.setColor(self.textColor)
    love.graphics.draw(text, math.ceil(self.x + self.width/2 - text:getWidth()/2), math.ceil(self.y + self.height/2 - text:getHeight()/2))
end

function Button:isCursorOn(mouseX, mouseY)
    return (mouseX >= self.x and mouseX <= self.x + self.width) and (mouseY >= self.y and mouseY <= self.y + self.height)
end