Water = Element:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0, 0.72, 0.94}
end

function Water:update(fieldClass, newField, dt)
    if self.y == fieldClass.height then
        for i=0,10 do
            isLeftReachable = self.x - 1 > 0 and 
            (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
            isRightReachable = self.x + 1 <= fieldClass.width and 
            (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
            if isLeftReachable and isRightReachable then
                if love.math.random(0,1) == 0 then self.x = self.x - 1
                else self.x = self.x + 1 end
            elseif isLeftReachable then self.x = self.x - 1
            elseif isRightReachable then self.x = self.x + 1 end
            if not (isLeftReachable or isRightReachable) then
                break
            end
        end
        newField[self.y][self.x] = self
    elseif fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0 then
        for i = 0,5 do
            isDownReachable = self.y < fieldClass.height and fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0
            if isDownReachable then
                self.y = self.y + 1
            else
                break
            end
        end
        newField[self.y][self.x] = self
    else
        for i=0,50 do
            isDownLeftReachable = (self.x - 1 > 0 and self.y < fieldClass.height) and 
            (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
            isDownRightReachable = (self.x + 1 <= fieldClass.width and self.y < fieldClass.height) and 
            (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
            isLeftReachable = self.x - 1 > 0 and 
            (fieldClass.field[self.y][self.x - 1] == 0 and newField[self.y][self.x - 1] == 0)
            isRightReachable = self.x + 1 <= fieldClass.width and 
            (fieldClass.field[self.y][self.x + 1] == 0 and newField[self.y][self.x + 1] == 0)
            if isDownLeftReachable and isDownRightReachable then
                self.y = self.y + 1
                if love.math.random(0,1) == 0 then self.x = self.x - 1
                else self.x = self.x + 1 end
            elseif isDownLeftReachable then
                self.y = self.y + 1
                self.x = self.x - 1
            elseif isDownRightReachable then
                self.y = self.y + 1
                self.x = self.x + 1
            elseif isLeftReachable and isRightReachable then
                if love.math.random(0,1) == 0 then self.x = self.x - 1
                else self.x = self.x + 1 end
            elseif isLeftReachable then self.x = self.x - 1
            elseif isRightReachable then self.x = self.x + 1 end
            if not ((isLeftReachable or isRightReachable) or (isDownLeftReachable or isDownRightReachable)) then
                break
            end
        end
        newField[self.y][self.x] = self
    end

    -- if self.y == fieldClass.height then
    --     isLeftReachable = self.x - 1 > 0 and newField[self.y][self.x - 1] == 0
    --     isRightReachable = self.x + 1 < fieldClass.width and newField[self.y][self.x + 1] == 0
    --     if isLeftReachable then
    --         self.x = self.x - 1
    --     elseif isRightReachable then
    --         self.x = self.x + 1
    --     end
    --     newField[self.y][self.x] = self
    -- elseif fieldClass.field[self.y + 1][self.x] == 0 then
    --     self.y = self.y + 1
    --     newField[self.y][self.x] = self
    -- else
    --     isDownLeftReachable = self.x - 1 > 0 and newField[self.y + 1][self.x - 1] == 0
    --     isDownRightReachable = self.x + 1 < fieldClass.width and newField[self.y + 1][self.x + 1] == 0
    --     isLeftReachable = self.x - 1 > 0 and newField[self.y][self.x - 1] == 0
    --     isRightReachable = self.x + 1 < fieldClass.width and newField[self.y][self.x + 1] == 0
    --     if isDownLeftReachable then
    --         self.y = self.y + 1
    --         self.x = self.x - 1
    --     elseif isDownRightReachable then
    --         self.y = self.y + 1
    --         self.x = self.x + 1
    --     elseif isLeftReachable then
    --         self.x = self.x - 1
    --     elseif isRightReachable then
    --         self.x = self.x + 1
    --     end
    --     newField[self.y][self.x] = self
    -- end

    -- if self.y == fieldClass.height then
    --     newField[self.y][self.x] = self
    -- elseif newField[self.y + 1][self.x] == 0 then
    --     self.y = self.y + 1
    -- elseif self.x - 1 > 0 and newField[self.y + 1][self.x - 1] == 0 then
    --     self.y = self.y + 1
    --     self.x = self.x - 1
    -- elseif self.x + 1 < fieldClass.width and newField[self.y + 1][self.x + 1] == 0 then
    --     self.y = self.y + 1
    --     self.x = self.x + 1
    -- elseif self.x - 1 > 0 and newField[self.y][self.x - 1] == 0 then
    --     self.x = self.x - 1
    -- elseif self.x + 1 < fieldClass.width and fieldClass.field[self.y][self.x + 1] == 0 then
    --     self.x = self.x + 1
    -- end
    -- newField[self.y][self.x] = self
end