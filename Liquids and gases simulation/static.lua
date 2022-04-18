Static = Element:extend()

function Static:new(x, y)
    Static.super.new(self, x, y)
    self.density = nil
end

function Static:update(fieldClass, updateType, dt)
    if updateType == fieldClass.elementManager.updateTypes.REPLACE then
        if self.tempBounds["lower"] and self.temp < self.tempBounds["lower"][1] then
            fieldClass.field[self.y][self.x] = self.tempBounds["lower"][2](self.x, self.y)
            fieldClass.field[self.y][self.x].temp = self.temp
            self.isUpdated = true
        elseif self.tempBounds["upper"] and self.temp > self.tempBounds["upper"][1] then
            fieldClass.field[self.y][self.x] = self.tempBounds["upper"][2](self.x, self.y)
            fieldClass.field[self.y][self.x].temp = self.temp
            self.isUpdated = true
        end
        fieldClass.field[self.y][self.x]:colorChangeDueTemp(fieldClass)
        return
    end
    self:colorChangeDueTemp(fieldClass)
    fieldClass.field[self.y][self.x] = self
    self.isUpdated = true
end

function Static:getUpdateType(fieldClass)
    if self.tempBounds then
        if self.tempBounds["lower"] and self.temp < self.tempBounds["lower"][1] then
            return fieldClass.elementManager.updateTypes.REPLACE
        elseif self.tempBounds["upper"] and self.temp > self.tempBounds["upper"][1] then
            return fieldClass.elementManager.updateTypes.REPLACE
        end
    end
    return fieldClass.elementManager.updateTypes.NONE
end