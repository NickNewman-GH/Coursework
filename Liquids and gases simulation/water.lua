Water = Element:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0, 0.72, 0.94}
end

function Water:update(fieldClass, newField, dt)
    if self.y == fieldClass.height then
        return
    else
        if fieldClass.field[self.y + 1][self.x] == 0 then
            self.y = self.y + 1
            newField[self.y][self.x] = self
        elseif self.x > 1 and fieldClass.field[self.y + 1][self.x - 1] == 0 then
            self.y = self.y + 1
            self.x = self.x - 1
            newField[self.y][self.x] = self
        elseif self.x < fieldClass.width and fieldClass.field[self.y + 1][self.x + 1] == 0 then
            self.y = self.y + 1
            self.x = self.x + 1
            newField[self.y][self.x] = self
        elseif self.x < fieldClass.width and fieldClass.field[self.y][self.x + 1] == 0 then
            self.x = self.x + 1
            newField[self.y][self.x] = self
        elseif self.x > 1 and fieldClass.field[self.y][self.x - 1] == 0 then
            self.x = self.x - 1
            newField[self.y][self.x] = self
        end
    end
end