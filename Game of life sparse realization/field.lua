Field = Object:extend()

function Field:new(width, height, cellSet)
    self.width = width
    self.height = height

    self.cells = self:checkCellSet(cellSet)

    self.cellSideSize = 0
    self.widthOffset = 0
    self.heightOffset = 0
    self:sizesComputing(love.graphics.getDimensions())
end

function Field:generate()
    self.cells = {}
    for i=1,self.height do
        for j=1,self.width do
            if not (j == 1 or j == self.width or i == 1 or i == self.height) and love.math.random(0, 1) > 0 then
                table.insert(self.cells, Cell(i, j))
            end
        end
    end
end

function Field:draw()
    love.graphics.setColor({0,0,0})
    for i, cell in ipairs(self.cells) do
        love.graphics.rectangle("fill", self.widthOffset + self.cellSideSize * (cell.x - 1), self.heightOffset + self.cellSideSize * (cell.y - 1), self.cellSideSize, self.cellSideSize)
    end
end

function Field:update()
    -- self.cells = self:nextGeneration()
    self:nextGeneration()
end

function Field:nextGeneration()
    local cells = {}
    local countNb = {}
    local elemKey = nil
    for i, cell in pairs(self.cells) do
        elemKey = getElementKey(cells, cell)
        if elemKey == nil then
            table.insert(cells, cell)
            table.insert(countNb, 0)
        end
        local nbs = self:getNeighbors(cell.y, cell.x)
        for j, nb in pairs(nbs) do
            elemKey = getElementKey(cells, nb)
            if elemKey == nil then
                table.insert(cells, nb)
                table.insert(countNb, 1)
            else
                countNb[elemKey] = countNb[elemKey] + 1
            end
        end
    end
    for i, cell in pairs(cells) do
        if (countNb[i] > 3 or countNb[i] < 2) then
            elemKey = getElementKey(self.cells, cell)
            if elemKey then
                table.remove(self.cells, elemKey)
            end
        elseif (countNb[i] == 3) then
            if getElementKey(self.cells, cell) == nil then
                table.insert(self.cells, cell)
            end
        end
    end

    -- 1 таблица со всеми клетками (1), вторая с количеством соседей по индексу каждой.
    -- for i=1,self.height do
    --     table.insert(newField, {})
    --     for j=1,self.width do
    --         if j == 1 or j == self.width or i == 1 or i == self.height then
    --             newField[i][j] = 0
    --         else
    --             local neighbors = self:countNeighbors(i, j)
    --             if self.cells[i][j] == 1 and (neighbors > 3 or neighbors < 2) then
    --                 newField[i][j] = 0
    --             elseif self.cells[i][j] == 0 and neighbors == 3 then
    --                 newField[i][j] = 1
    --             else
    --                 newField[i][j] = self.cells[i][j]
    --             end
    --         end
    --     end
    -- end
    -- return newField
end

function Field:getNeighbors(y, x)
    local neighbors = {}
    if x - 1 > 1 then table.insert(neighbors, Cell(y, x - 1)) end
    if y - 1 > 1 then table.insert(neighbors, Cell(y - 1, x)) end
    if x + 1 < self.width - 1 then table.insert(neighbors, Cell(y, x + 1)) end
    if y + 1 < self.height - 1 then table.insert(neighbors, Cell(y + 1, x)) end
    if y - 1 > 1 and x + 1 < self.width - 1 then table.insert(neighbors, Cell(y - 1, x + 1)) end
    if y + 1 < self.height - 1 and x - 1 > 1 then table.insert(neighbors, Cell(y + 1, x - 1)) end
    if y - 1 > 1 and x - 1 > 1 then table.insert(neighbors, Cell(y - 1, x - 1)) end
    if x + 1 < self.width - 1 and y + 1 < self.height - 1 then table.insert(neighbors, Cell(y + 1, x + 1)) end
    return neighbors
    -- local neighbors = self.cells[y][x]
    -- for i=-1,1 do
    --     for j=-1,1 do
    --         neighbors = neighbors - self.cells[y + i][x + j]
    --     end
    -- end
    -- neighbors = -neighbors
    -- return neighbors
end

function Field:sizesComputing(windowWidth, windowHeight)
    if windowWidth/windowHeight < self.width/self.height then
        self.cellSideSize = windowWidth / self.width
        self.heightOffset = (windowHeight - self.cellSideSize * self.height) / 2
        self.widthOffset = 0
    elseif windowWidth/windowHeight > self.width/self.height then
        self.cellSideSize = windowHeight / self.height
        self.widthOffset = (windowWidth - self.cellSideSize * self.width) / 2
        self.heightOffset = 0
    else 
        self.cellSideSize = windowHeight / self.height
        self.widthOffset = 0
        self.heightOffset = 0
    end
end

function Field:checkCellSet(cellSet)
    if cellSet == nil then
        return {}
    else
        for i=#cellSet,1,-1 do
            if (cellSet[i].y < 1 or cellSet[i].y > self.height) or 
            (cellSet[i].x < 1 or cellSet[i].x > self.width) then
                table.remove(cellSet, i)
            end
        end
    end
    return cellSet
end

function getElementKey(cellTable, cell)
    for key, value in pairs(cellTable) do
        if value.x == cell.x and value.y == cell.y then
            return key
        end
    end
    return nil
end