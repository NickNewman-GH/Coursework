Static = Element:extend()

function Static:new(x, y)
    Static.super.new(self, x, y)
    self.density = nil
end

function Static:update(fieldClass, newField, dt)
    newField[self.y][self.x] = self
end

function Static:getUpdateType(fieldClass)
    return fieldClass.elementManager.updateTypes.NONE
end