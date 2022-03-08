Stone = Element:extend()

function Stone:new(x, y)
    Stone.super.new(self, x, y)
    self.color = {0.4, 0.4, 0.4}
end

function Stone:update(fieldClass, newField, dt)
    newField[self.y][self.x] = self
end