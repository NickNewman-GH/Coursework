Field = Object:extend()

function Field:new(width, height)
    self.width = width
    self.height = height

    self.field = self:newField()
    self.updateOrder = self:generateUpdateOrderArray()

    self.sideSize = 0
    self.widthOffset = 0
    self.heightOffset = 0
    self:sizesComputing(love.graphics.getDimensions())

    self.createdElement = Water

    self.creationAreaSideSize = 10
end

function Field:newField()
    local newField = {}
    for i=1,self.height do
        table.insert(newField, {})
        for j=1,self.width do
            table.insert(newField[i], 0)
        end
    end
    return newField
end

function Field:draw()
    for i=1,#self.field do
        for j=1,#self.field[i] do
            local cell = self.field[i][j]
            if not (cell == 0) then
                love.graphics.setColor(cell.color)
                love.graphics.rectangle("fill", self.widthOffset + self.sideSize * (j - 1), self.heightOffset + self.sideSize * (i - 1), self.sideSize, self.sideSize)
            end
        end
    end
end

function Field:update(dt)
    local newField = self:newField()
    self:shuffleUpdateOrder()
    for i=1,#self.updateOrder do
        local coords = self.updateOrder[i]
        local cell = self.field[coords[1]][coords[2]]
        if not (cell == 0) then
            cell:update(self, newField, dt)
        end
    end
    self.field = newField
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

function Field:addElements(mouseX, mouseY)
    local fieldX = math.floor((mouseX - self.widthOffset) / self.sideSize) + 1
    local fieldY = math.floor((mouseY - self.heightOffset) / self.sideSize) + 1

    sideSize = math.floor(self.creationAreaSideSize/2)
    for i=-sideSize,sideSize do
        if fieldY+i <= self.height and fieldY+i > 0 then
            for j=-sideSize,sideSize do
                if fieldX+j <= self.width and fieldX+j > 0 and self.field[fieldY+i][fieldX+j] == 0 then
                    self.field[fieldY+i][fieldX+j] = self.createdElement(fieldX+j, fieldY+i)
                end
            end
        end
    end
end

function Field:removeElements(mouseX, mouseY)
    local fieldX = math.floor((mouseX - self.widthOffset) / self.sideSize) + 1
    local fieldY = math.floor((mouseY - self.heightOffset) / self.sideSize) + 1

    sideSize = math.floor(self.creationAreaSideSize/2)
    for i=-sideSize,sideSize do
        if fieldY+i <= self.height and fieldY+i > 0 then
            for j=-sideSize,sideSize do
                if fieldX+j <= self.width and fieldX+j > 0 then
                    self.field[fieldY+i][fieldX+j] = 0
                end
            end
        end
    end
end

function Field:generateUpdateOrderArray()
    array = {}
    for i=1,self.height do
        for j=1,self.width do
            table.insert(array, {i, j})
        end
    end
    return array
end

function Field:shuffleUpdateOrder()
    for i = #self.updateOrder, 2, -1 do
		local j = love.math.random(i)
		self.updateOrder[i], self.updateOrder[j] = self.updateOrder[j], self.updateOrder[i]
	end
end