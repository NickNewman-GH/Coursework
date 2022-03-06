Sand = Element:extend()

function Sand:new(x, y)
    Sand.super.new(self, x, y)
    self.color = {0.82, 0.65, 0}
end

function Sand:update(fieldClass, newField, dt)
    if self.y >= fieldClass.height then
        self.y = fieldClass.height
        newField[self.y][self.x] = self
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
        end
    end
end