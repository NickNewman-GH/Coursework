resizeFieldWindow = Object:extend()

function resizeFieldWindow:new()
    self.x = 10
    self.y = 0
    self.width = 150
    self.height = 0
    self.textHeight = love.graphics.newText(font, "012345689"):getHeight()
    local padding = 5
    local margin = 10
    self.maxTextLength = 4
    self.widthTextField = {
        margin = margin,
        padding = padding,
        x, y = 0, 0,
        height = self.textHeight + padding * 2,
        width = self.width - margin * 2,
        isFocused = false,
        text = ''
    }
    self.heightTextField = {
        margin = margin,
        padding = padding,
        x, y = 0, 0,
        height = self.textHeight + padding * 2,
        width = self.width - margin * 2,
        isFocused = false,
        text = ''
    }
    self.buttons = {
        Button(0, 0, (self.width - margin * 3) / 2, self.textHeight + margin + padding, "ConfirmResize", "Resize"),
        Button(0, 0, (self.width - margin * 3) / 2, self.textHeight + margin + padding, "Cancel", "Cancel")
    }
end

function resizeFieldWindow:updateFields()
    self.widthTextField.x = self.x + self.widthTextField.margin
    self.widthTextField.y = self.y + self.widthTextField.margin * 2 + self.textHeight

    self.heightTextField.x = self.x + self.heightTextField.margin
    self.heightTextField.y = self.y + self.heightTextField.margin * 4 + self.widthTextField.height + self.textHeight * 2

    self.buttons[1].x = self.x + self.widthTextField.margin
    self.buttons[1].y = self.heightTextField.y + self.heightTextField.margin * 2 + self.heightTextField.height
    self.buttons[2].x = self.x + self.widthTextField.margin * 2 + self.buttons[1].width
    self.buttons[2].y = self.heightTextField.y + self.heightTextField.margin * 2 + self.heightTextField.height

    self.height = self.buttons[2].y + self.buttons[2].height + self.heightTextField.margin - self.y
end

function resizeFieldWindow:draw(fieldClass, newField, dt)
    love.graphics.setColor({0, 0, 0, 0.5})
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor({1, 1, 1})
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    local widthText = love.graphics.newText(font, "Field width:")
    love.graphics.draw(widthText, self.x + self.widthTextField.margin, self.y + self.widthTextField.margin)
    love.graphics.rectangle("fill", self.widthTextField.x, self.widthTextField.y, self.widthTextField.width, self.widthTextField.height)

    local heightText = love.graphics.newText(font, "Field height:")
    love.graphics.draw(heightText, self.heightTextField.x, self.heightTextField.y - self.heightTextField.margin - self.textHeight)
    love.graphics.rectangle("fill", self.heightTextField.x, self.heightTextField.y, self.heightTextField.width, self.heightTextField.height)
    
    love.graphics.setColor({0, 0, 0})
    love.graphics.print(self.widthTextField.text, self.widthTextField.x + self.widthTextField.padding, self.widthTextField.y+ self.widthTextField.padding)
    love.graphics.print(self.heightTextField.text, self.heightTextField.x + self.heightTextField.padding, self.heightTextField.y+ self.heightTextField.padding)
    if self.widthTextField.isFocused then
        if #self.widthTextField.text > 3 then
            love.graphics.setColor({0, 0, 0, 0.3})
        end
        love.graphics.rectangle("fill", self.widthTextField.x + self.widthTextField.padding + love.graphics.newText(font, self.widthTextField.text):getWidth(), self.widthTextField.y + self.widthTextField.padding, 2, self.widthTextField.height - self.widthTextField.padding * 2)
    elseif self.heightTextField.isFocused then
        if #self.heightTextField.text > 3 then
            love.graphics.setColor({0, 0, 0, 0.3})
        end
        love.graphics.rectangle("fill", self.heightTextField.x + self.heightTextField.padding + love.graphics.newText(font, self.heightTextField.text):getWidth(), self.heightTextField.y + self.heightTextField.padding, 2, self.heightTextField.height - self.heightTextField.padding * 2)
    end

    self.buttons[1]:draw()
    self.buttons[2]:draw()
end

function resizeFieldWindow:isCursorOnTextFields(mouseX, mouseY)
    if (self.widthTextField.x and (mouseX >= self.widthTextField.x) and mouseX <= self.widthTextField.x + self.widthTextField.width) and 
    (mouseY >= self.widthTextField.y and mouseY <= self.widthTextField.y + self.widthTextField.height) then
        self.widthTextField.isFocused = true
        self.heightTextField.isFocused = false
        return true
    elseif (self.heightTextField.x and (mouseX >= self.heightTextField.x) and mouseX <= self.heightTextField.x + self.heightTextField.width) and 
    (mouseY >= self.heightTextField.y and mouseY <= self.heightTextField.y + self.heightTextField.height) then
        self.heightTextField.isFocused = true
        self.widthTextField.isFocused = false
        return true
    end
    return false
end