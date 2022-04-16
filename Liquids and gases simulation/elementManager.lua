ElementManager = Object:extend()

function ElementManager:new()
    self.updateTypes = {
        REPLACE = 1,
        SWAP = 2,
        MOVE = 3,
        NONE = 4,
    }
    self.updates = { {}, {}, {}, {} } -- REPLACE, SWAP, MOVE, NONE
end

function ElementManager:clearUpdates()
    for i=1,#self.updates do
        self.updates[i] = {}
    end
end

function ElementManager:getUpdates(fieldClass)
    self:clearUpdates()
    local updateType = 0
    for i=1,fieldClass.height do
        for j=1,fieldClass.width do
            local cell = fieldClass.field[i][j]
            if not (cell == 0) then
                updateType = cell:getUpdateType(fieldClass)
                if updateType == self.updateTypes.REPLACE then
                    table.insert(self.updates[updateType], {cell.y, cell.x})
                elseif updateType == self.updateTypes.SWAP then
                    table.insert(self.updates[updateType], {cell.y, cell.x})
                elseif updateType == self.updateTypes.MOVE then
                    table.insert(self.updates[updateType], {cell.y, cell.x})
                elseif updateType == self.updateTypes.NONE then
                    table.insert(self.updates[updateType], {cell.y, cell.x})
                end
            end
        end
    end
end

function ElementManager:shuffleUpdates()
    for k=1,#self.updates do
        for i = #self.updates[k], 2, -1 do
            local j = love.math.random(i)
            self.updates[k][i], self.updates[k][j] = self.updates[k][j], self.updates[k][i]
        end
    end
end

function ElementManager:getAllElementShuffledCoords(fieldClass)
    local coordsTable = {}
    for i=1,fieldClass.height do
        for j=1,fieldClass.width do
            if not (fieldClass.field[i][j] == 0) then
                table.insert(coordsTable, {i, j})
            end
        end
    end
    for i = #coordsTable, 2, -1 do
        local j = love.math.random(i)
        coordsTable[i], coordsTable[j] = coordsTable[j], coordsTable[i]
    end
    return coordsTable
end