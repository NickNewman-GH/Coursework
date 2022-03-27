SandDebug = Element:extend()

function SandDebug:new(x, y)
    SandDebug.super.new(self, x, y)
    self.color = {0.32, 0.25, 0.8}
    self.density = 700
end

function SandDebug:update(fieldClass, newField, updateType, dt)
    if updateType == fieldClass.elementManager.updateTypes.MOVE then
        local isDownReachable = fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0
        local isDownLeftReachable = fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0
        local isDownRightReachable = fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0
        if isDownReachable then
            for i=1,self.gravity do
                self.y = self.y + 1
                local isLowerBound = self.y == fieldClass.height
                isDownReachable = not isLowerBound and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
                if not isDownReachable then
                    break
                end
            end
        else
            if isDownLeftReachable and isDownRightReachable then
                self.y = self.y + 1
                local coordChange = {-1, 1}
                self.x = self.x + coordChange[love.math.random(1,2)]
            elseif isDownLeftReachable then
                self.y = self.y + 1
                self.x = self.x - 1
            elseif isDownRightReachable then
                self.y = self.y + 1
                self.x = self.x + 1
            end
        end
    end
    newField[self.y][self.x] = self:copy()
    self.isUpdated = true

    -- local isLowerBound = self.y == fieldClass.height
    -- if not isLowerBound then
    --     local targetCell = fieldClass.field[self.y + 1][self.x]
    --     local isDownReachable = targetCell == 0 and newField[self.y + 1][self.x] == 0
    --     local isDownLeftReachable = self.x - 1 > 0 and (fieldClass.field[self.y + 1][self.x - 1] == 0 and newField[self.y + 1][self.x - 1] == 0)
    --     local isDownRightReachable = self.x + 1 <= fieldClass.width and (fieldClass.field[self.y + 1][self.x + 1] == 0 and newField[self.y + 1][self.x + 1] == 0)
    --     if isDownReachable then
    --         for i=1,self.gravity do
    --             self.y = self.y + 1
    --             isLowerBound = self.y == fieldClass.height
    --             isDownReachable = not isLowerBound and (fieldClass.field[self.y + 1][self.x] == 0 and newField[self.y + 1][self.x] == 0)
    --             if (not isDownReachable) or isLowerBound then
    --                 break
    --             end
    --         end
    --     elseif isDownLeftReachable or isDownRightReachable then
    --         if isDownLeftReachable and isDownRightReachable then
    --             self.y = self.y + 1
    --             local coordChange = {-1, 1}
    --             self.x = self.x + coordChange[love.math.random(1,2)]
    --         elseif isDownLeftReachable then
    --             self.y = self.y + 1
    --             self.x = self.x - 1
    --         elseif isDownRightReachable then
    --             self.y = self.y + 1
    --             self.x = self.x + 1
    --         end
    --     -- elseif not (targetCell == 0) and fieldClass.field[self.y + 1][self.x].density < self.density then
    --     --     newField[self.y][self.x] = fieldClass.field[self.y + 1][self.x]:copy()
    --     --     fieldClass.field[self.y + 1][self.x].isUpdated = true
    --     --     self.y = self.y + 1
    --     end
    -- end
    -- --if newField[self.y][self.x] == 0 then
    -- newField[self.y][self.x] = self:copy()
    -- --end
    -- self.isUpdated = true
end

function SandDebug:copy()
    return SandDebug(self.x, self.y)
end

function SandDebug:getUpdateType(fieldClass)
    local isLowerBound = self.y == fieldClass.height
    if isLowerBound then
        return fieldClass.elementManager.updateTypes.NONE
    else
        local isDownReachable = fieldClass.field[self.y + 1][self.x] == 0
        local isLeftBound = self.x - 1 == 0
        local isDownLeftReachable = not isLeftBound and fieldClass.field[self.y + 1][self.x - 1] == 0
        local isRightBound = self.x + 1 > fieldClass.width
        local isDownRightReachable = not isRightBound and fieldClass.field[self.y + 1][self.x + 1] == 0
        if isDownReachable or isDownLeftReachable or isDownRightReachable then
            return fieldClass.elementManager.updateTypes.MOVE
        else
            return fieldClass.elementManager.updateTypes.NONE
        end
    end
end