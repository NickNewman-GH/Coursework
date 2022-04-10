Static = Element:extend()

function Static:new(x, y)
    Static.super.new(self, x, y)
    self.density = nil
end

function Static:update(fieldClass, newField, dt)
    self:giveTempToOthers(fieldClass, dt)
    newField[self.y][self.x] = self:copy()
end

function Static:getUpdateType(fieldClass)
    return fieldClass.elementManager.updateTypes.NONE
end