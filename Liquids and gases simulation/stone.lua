Stone = Element:extend()

function Stone:new(x, y)
    Stone.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5}
end

function Stone:update(fieldClass, newField, dt)
    newField[self.y][self.x] = self
end

function Stone:copy()
    return Stone(self.x, self.y)
end

function Stone:getUpdateType(fieldClass)
    return fieldClass.elementManager.updateTypes.NONE
end