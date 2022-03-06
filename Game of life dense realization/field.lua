Field = Object:extend()

function Field:new(width, height, cellCoordinates)
    self.width = width
    self.height = height

    self.cellCoordinates = self:checkCellCoordinates(cellCoordinates)
    self.field = {}
    self:fieldDeclaration()

    self.sideSize = 0
    self.widthOffset = 0
    self.heightOffset = 0
    self:sizesComputing(love.graphics.getDimensions())
end

function Field:generate()
    self.field = {}
    for i=1,self.height do
        table.insert(self.field, {})
        for j=1,self.width do
            if j == 1 or j == self.width or i == 1 or i == self.height then
                table.insert(self.field[i], 0)
            else
                table.insert(self.field[i], love.math.random(0, 1))
            end
        end
    end
end

function Field:draw()
    for i, row in ipairs(self.field) do
        for j, cell in ipairs(row) do
            if not (cell == 0) then
                love.graphics.setColor({0,0,0})
                love.graphics.rectangle("fill", self.widthOffset + self.sideSize * (j - 1), self.heightOffset + self.sideSize * (i - 1), self.sideSize, self.sideSize)
            end
        end
    end
end

function Field:update()
    self.field = self:nextGeneration()
end

function Field:nextGeneration()
    local newField = {}
    for i=1,self.height do
        table.insert(newField, {})
        for j=1,self.width do
            if j == 1 or j == self.width or i == 1 or i == self.height then
                newField[i][j] = 0
            else
                local neighbors = self:countNeighbors(i, j)
                if self.field[i][j] == 1 and (neighbors > 3 or neighbors < 2) then
                    newField[i][j] = 0
                elseif self.field[i][j] == 0 and neighbors == 3 then
                    newField[i][j] = 1
                else
                    newField[i][j] = self.field[i][j]
                end
            end
        end
    end
    return newField
end

function Field:countNeighbors(y, x)
    local neighbors = self.field[y][x]
    for i=-1,1 do
        for j=-1,1 do
            neighbors = neighbors - self.field[y + i][x + j]
        end
    end
    neighbors = -neighbors
    return neighbors
end

function Field:sizesComputing(windowWidth, windowHeight)
    if windowWidth/windowHeight < self.width/self.height then
        self.sideSize = windowWidth / self.width
        self.heightOffset = (windowHeight - self.sideSize * self.height) / 2
        self.widthOffset = 0
    elseif windowWidth/windowHeight > self.width/self.height then
        self.sideSize = windowHeight / self.height
        self.widthOffset = (windowWidth - self.sideSize * self.width) / 2
        self.heightOffset = 0
    else 
        self.sideSize = windowHeight / self.height
        self.widthOffset = 0
        self.heightOffset = 0
    end
end

function Field:checkCellCoordinates(cellCoordinates)
    if cellCoordinates == nil then
        return nil
    else
        for i=#cellCoordinates,1,-1 do
            if (cellCoordinates[i][1] < 1 or cellCoordinates[i][1] > self.height) or 
            (cellCoordinates[i][2] < 1 or cellCoordinates[i][2] > self.width) then
                table.remove(cellCoordinates, i)
            end
        end
    end
    return cellCoordinates
end

function Field:fieldDeclaration()
    if self.cellCoordinates == nil then
        self:generate()
    else
        self.field = {}
        for i=1,self.height do
            table.insert(self.field, {})
            for j=1,self.width do
                table.insert(self.field[i], 0)
            end
        end
        for i,cell in pairs(self.cellCoordinates) do
            self.field[cell[1]][cell[2]] = 1
        end
    end
end