Stone = Static:extend()

function Stone:new(x, y)
    Stone.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5}
end

function Stone:update(fieldClass, newField, dt)
    self:giveTempToOthers(fieldClass, dt)
    self.color[1] = 0.5 - field.insideTemp/1500 + self.temp/1500
    newField[self.y][self.x] = self:copy()
end

function Stone:copy()
    local elem = Stone(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end