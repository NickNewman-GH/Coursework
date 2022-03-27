Sand = Element:extend()

function Sand:new(x, y)
    Sand.super.new(self, x, y)
    self.color = {0.82, 0.65, 0}
    self.density = 1500
end

function Sand:update(fieldClass, newField, updateType, dt)
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
                local sideChoice = love.math.random(0,1)
                if sideChoice == 0 then self.x = self.x - 1
                else self.x = self.x + 1 end
            elseif isDownLeftReachable then
                self.y = self.y + 1
                self.x = self.x - 1
            elseif isDownRightReachable then
                self.y = self.y + 1
                self.x = self.x + 1
            end
        end
    elseif updateType == fieldClass.elementManager.updateTypes.SWAP then
        local targetCell = fieldClass.field[self.y + 1][self.x]
        local isDownCanBeSwapped = not (targetCell == 0) and not targetCell.isUpdated and targetCell.density < self.density
        if isDownCanBeSwapped then
            fieldClass.field[self.y + 1][self.x].y = fieldClass.field[self.y + 1][self.x].y - 1
            newField[self.y][self.x] = fieldClass.field[self.y + 1][self.x]:copy()
            fieldClass.field[self.y + 1][self.x].isUpdated = true
            self.y = self.y + 1
        else
            targetCell = fieldClass.field[self.y + 1][self.x - 1]
            local isDownLeftCanBeSwapped = not (targetCell == 0) and not (targetCell == nil) and not targetCell.isUpdated and (targetCell.density < self.density)
            targetCell = fieldClass.field[self.y + 1][self.x + 1]
            local isDownRightCanBeSwapped = not (targetCell == 0) and not (targetCell == nil) and not targetCell.isUpdated and (targetCell.density < self.density)
            if isDownLeftCanBeSwapped then
                fieldClass.field[self.y + 1][self.x - 1].y = fieldClass.field[self.y + 1][self.x - 1].y - 1
                fieldClass.field[self.y + 1][self.x - 1].x = fieldClass.field[self.y + 1][self.x - 1].x + 1
                newField[self.y][self.x] = fieldClass.field[self.y + 1][self.x - 1]:copy()
                fieldClass.field[self.y + 1][self.x - 1].isUpdated = true
                self.y = self.y + 1
                self.x = self.x - 1
            elseif isDownRightCanBeSwapped then
                fieldClass.field[self.y + 1][self.x + 1].y = fieldClass.field[self.y + 1][self.x + 1].y - 1
                fieldClass.field[self.y + 1][self.x + 1].x = fieldClass.field[self.y + 1][self.x + 1].x - 1
                --fieldClass.field[self.y + 1][self.x + 1].color = {0.82, 0.85, 0.81}
                --fieldClass.field[self.y + 1][self.x + 1].isUpdated = true
                newField[self.y][self.x] = fieldClass.field[self.y + 1][self.x + 1]:copy()
                fieldClass.field[self.y + 1][self.x + 1].isUpdated = true
                self.y = self.y + 1
                self.x = self.x + 1
            end
            -- if isDownLeftCanBeSwapped and isDownRightCanBeSwapped then
            --     fieldClass.field[self.y + 1][self.x].y = fieldClass.field[self.y + 1][self.x].y - 1
            --     newField[self.y][self.x] = fieldClass.field[self.y + 1][self.x]:copy()
            --     fieldClass.field[self.y + 1][self.x].isUpdated = true
            --     self.y = self.y + 1
        end
    end
    newField[self.y][self.x] = self:copy()
    self.isUpdated = true
end

function Sand:copy()
    return Sand(self.x, self.y)
end

function Sand:getUpdateType(fieldClass)
    local isLowerBound = self.y == fieldClass.height
    if isLowerBound then
        return fieldClass.elementManager.updateTypes.NONE
    else
        local targetCell = fieldClass.field[self.y + 1][self.x]
        local isDownReachable = targetCell == 0
        local isDownLowerDensity = not isDownReachable and targetCell.density < self.density
        if isDownReachable then
            return fieldClass.elementManager.updateTypes.MOVE
        elseif isDownLowerDensity then
            return fieldClass.elementManager.updateTypes.SWAP
        else
            --local isLeftBound = self.x - 1 == 0
            local downLeftTargetCell = fieldClass.field[self.y + 1][self.x - 1]
            local isDownLeftReachable = downLeftTargetCell == 0
            
            --local isRightBound = self.x + 1 > fieldClass.width
            local downRigthTargetCell = fieldClass.field[self.y + 1][self.x + 1]
            local isDownRightReachable = downRigthTargetCell == 0

            -- local isLeftBound = self.x - 1 == 0
            -- if isLeftBound then
            --     local downLeftTargetCell = false
            --     local isDownLeftReachable = false
            -- else
            --     local downLeftTargetCell = fieldClass.field[self.y + 1][self.x - 1]
            --     local isDownLeftReachable = downLeftTargetCell == 0
            -- end
            -- local isRightBound = self.x + 1 > fieldClass.width
            -- if isRightBound then 
            --     local downRightTargetCell = false
            --     local isDownRightReachable = false
            -- else
            --     local downRightTargetCell = fieldClass.field[self.y + 1][self.x + 1]
            --     local isDownRightReachable = downRightTargetCell == 0
            -- end

            if isDownLeftReachable or isDownRightReachable then
                return fieldClass.elementManager.updateTypes.MOVE
            else
                local isDownLeftLowerDensity = not ((downLeftTargetCell == 0) or (downLeftTargetCell == nil)) and downLeftTargetCell.density < self.density
                local isDownRightLowerDensity = not ((downRightTargetCell == 0) or (downRightTargetCell == nil)) and downRightTargetCell.density < self.density
                if isDownLeftLowerDensity or isDownRightLowerDensity then
                    return fieldClass.elementManager.updateTypes.SWAP
                end
            end
            return fieldClass.elementManager.updateTypes.NONE
        end
    end
end