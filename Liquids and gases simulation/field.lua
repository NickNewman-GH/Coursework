Field = Object:extend()

function Field:new(width, height)
    self.width = width
    self.height = height

    self.field = self:newField()
    self.elementManager = ElementManager()

    self.sideSize = 0
    self.widthOffset = 0
    self.heightOffset = 0
    self:sizesComputing(love.graphics.getDimensions())

    self.createdElement = Water
    self.creationAreaSideSize = 11

    self.isPauseUpdate = false

    self.mouseFieldXPos = nil
    self.mouseFieldYPos = nil

    self.tempChangeType = 0
    self.tempChangePerSec = 100

    self.insideTemp = 25
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

function Field:drawCreationArea()
    if self.mouseFieldXPos and self.mouseFieldYPos and isShowCreationArea then
        love.graphics.setColor({0.5, 0.5, 0.5, 0.5})
        love.graphics.rectangle("line", self.widthOffset + (self.mouseFieldXPos - (self.creationAreaSideSize - 1) / 2 - 1)*self.sideSize, self.heightOffset + 
        (self.mouseFieldYPos - (self.creationAreaSideSize - 1) / 2 - 1)*self.sideSize, self.sideSize * self.creationAreaSideSize, self.sideSize * self.creationAreaSideSize)
    end
end

function Field:updateMouseFieldPos(mouseX, mouseY)
    self.mouseFieldXPos = math.floor((mouseX - self.widthOffset) / self.sideSize) + 1
    self.mouseFieldYPos = math.floor((mouseY - self.heightOffset) / self.sideSize) + 1
end

function Field:update(dt)
    local newField = self:newField()
    self.elementManager:getUpdates(self)
    self.elementManager:shuffleUpdates()
    for i=1,#self.elementManager.updates do
        for j=1,#self.elementManager.updates[i] do
            local coords = self.elementManager.updates[i][j]
            local cell = self.field[coords[1]][coords[2]]
            if not cell.isUpdated then 
                cell:update(self, newField, i, dt)
            end
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

function Field:addElements()
    sideSize = math.floor(self.creationAreaSideSize/2)
    for i=-sideSize,sideSize do
        if self.mouseFieldYPos+i <= self.height and self.mouseFieldYPos+i > 0 then
            for j=-sideSize,sideSize do
                if self.mouseFieldXPos+j <= self.width and self.mouseFieldXPos+j > 0 and self.field[self.mouseFieldYPos+i][self.mouseFieldXPos+j] == 0 then
                    self.field[self.mouseFieldYPos+i][self.mouseFieldXPos+j] = self.createdElement(self.mouseFieldXPos+j, self.mouseFieldYPos+i)
                end
            end
        end
    end
end

function Field:removeElements()
    sideSize = math.floor(self.creationAreaSideSize/2)
    for i=-sideSize,sideSize do
        if self.mouseFieldYPos+i <= self.height and self.mouseFieldYPos+i > 0 then
            for j=-sideSize,sideSize do
                if self.mouseFieldXPos+j <= self.width and self.mouseFieldXPos+j > 0 then
                    self.field[self.mouseFieldYPos+i][self.mouseFieldXPos+j] = 0
                end
            end
        end
    end
end

function Field:changeElementsTemp(dt)
    sideSize = math.floor(self.creationAreaSideSize/2)
    for i=-sideSize,sideSize do
        if self.mouseFieldYPos+i <= self.height and self.mouseFieldYPos+i > 0 then
            for j=-sideSize,sideSize do
                if self.mouseFieldXPos+j <= self.width and self.mouseFieldXPos+j > 0 and not (self.field[self.mouseFieldYPos+i][self.mouseFieldXPos+j] == 0) then
                    self.field[self.mouseFieldYPos+i][self.mouseFieldXPos+j].temp = self.field[self.mouseFieldYPos+i][self.mouseFieldXPos+j].temp + self.tempChangePerSec * dt * self.tempChangeType
                end
            end
        end
    end
end