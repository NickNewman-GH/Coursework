function love.load()
    Object = require "classic"
    require "button"
    require "elementManager"
    require "field"
    require "element"
    require "liquid"
    require "static"
    require "ice"
    require "gas"
    require "steam"
    require "lava"
    require "solid"
    require "solidStone"
    require "oil"
    require "sand"
    require "slime"
    require "resizeFieldWindow"
    -----
    require "sand1"
    require "sand2"
    -----
    require "water"
    require "stone"
    
    require "smoke"
    -----
    require "smoke1"
    -----

    windowWidth, windowHeight = 800, 800
    love.window.setMode(windowWidth, windowHeight, {resizable=true, vsync=true})

    font = love.graphics.getFont()
    resizeFieldWindow = resizeFieldWindow()

    field = Field(100, 100)
    fullscreen = false

    isActiveItemPressed = false
    isShowWindowInformation = true
    isShowKeysInformation = true
    isShowResizeFieldWindow = false
    isShowButtons = true
    isShowCreationArea = true

    windowInformation = getWindowInformation()
    keysAssignmentInformation = getKeysAssignmentInformation()

    buttons = createButtons()
end

function getWindowInformation()
    return {
        love.graphics.newText(font, "Window information:"),
        love.graphics.newText(font, "Current FPS: "..tostring(love.timer.getFPS( ))),
        love.graphics.newText(font, "Field width: "..tostring(field.width)),
        love.graphics.newText(font, "Field height: "..tostring(field.height)),
        love.graphics.newText(font, "Creation area size: "..tostring(field.creationAreaSideSize))
    }
end

function updateWindowInformation()
    windowInformation = {
        love.graphics.newText(font, "Window information:"),
        love.graphics.newText(font, "Current FPS: "..tostring(love.timer.getFPS( ))),
        love.graphics.newText(font, "Field width: "..tostring(field.width)),
        love.graphics.newText(font, "Field height: "..tostring(field.height)),
        love.graphics.newText(font, "Creation area size: "..tostring(field.creationAreaSideSize))
    }
end

function getKeysAssignmentInformation()
    return {
        love.graphics.newText(font, "Key Assignment:"),
        love.graphics.newText(font, "1 - Water (by default, dens = 900)"), 
        love.graphics.newText(font, "2 - Oil (dens = 900)"),
        love.graphics.newText(font, "3 - Slime (dens = 800)"),
        love.graphics.newText(font, "4 - Stone (static)"),
        love.graphics.newText(font, "5 - Sand"),
        love.graphics.newText(font, "6 - Smoke"),
        love.graphics.newText(font, "7 - Heat"),
        love.graphics.newText(font, "8 - Freeze"),
        love.graphics.newText(font, "Mwheel up - Larger particle creation area"),
        love.graphics.newText(font, "Mwheel down - Smaller particle creation area"),
        love.graphics.newText(font, "R - Clear field"),
        love.graphics.newText(font, "H - Show/hide buttons"),
        love.graphics.newText(font, "L - Hide all/show buttons and creation area"),
        love.graphics.newText(font, "P - Pause/Unpause"),
        love.graphics.newText(font, "Right arrow - Next frame (when paused)"),
        love.graphics.newText(font, "F11 - Full screen/Windowed mode"),
        love.graphics.newText(font, "Lmouse button - Create particles"),
        love.graphics.newText(font, "Rmouse button - Delete particles")
    }
end

function createButtons()
    local buttonWidth = 75
    local buttonHeight = 30
    return {
        Button(10, 10, buttonWidth, buttonHeight, "isShowWindowInformation", "Window"),
        Button(10 + buttonWidth + 10, 10, buttonWidth, buttonHeight, "isShowKeysInformation", "Keys"),
        Button(10 + (buttonWidth + 10) * 2 , 10, 100, buttonHeight, "isShowResizeFieldWindow", "Resize field")
    }
end

function love.update(dt)
    if isShowWindowInformation then
        updateWindowInformation()
    end
    if love.mouse.isDown(1) then
        if not isActiveItemPressed then
            if not (field.tempChangeType == 0) then
                field:changeElementsTemp(dt)
            else
                field:addElements()
            end
        end
    elseif love.mouse.isDown(2) then
        field:removeElements()
    end
    if not field.isPauseUpdate then
        field:update(dt)
    end
end

function love.draw()
    field:draw()
    field:drawCreationArea()
    love.graphics.setColor({0.5, 0.5, 0.5})
    if field.widthOffset > 0 then
        love.graphics.rectangle("fill", 0, 0, field.widthOffset, windowHeight)
        love.graphics.rectangle("fill", windowWidth - field.widthOffset, 0, field.widthOffset, windowHeight)
    elseif field.heightOffset > 0 then
        love.graphics.rectangle("fill", 0, 0, windowWidth, field.heightOffset)
        love.graphics.rectangle("fill", 0, windowHeight - field.heightOffset, windowWidth, field.heightOffset)
    end
    if isShowButtons then
        drawButtons()
    end
    drawInformation()
    if isShowResizeFieldWindow then
        if isShowButtons then
            if not (resizeFieldWindow.y == 20 + buttons[1].height) then
                resizeFieldWindow.y = 20 + buttons[1].height
                resizeFieldWindow:updateFields()
            end
        else
            if not (resizeFieldWindow.y == 10) then
                resizeFieldWindow.y = 10
                resizeFieldWindow:updateFields()
            end
        end
        resizeFieldWindow:draw()
    end
end

function love.keypressed(key, scancode, isrepeat, dt)
    if (resizeFieldWindow.widthTextField.isFocused or resizeFieldWindow.heightTextField.isFocused) and 
    ((key == "1") or (key == "2") or (key == "3") or (key == "4") or (key == "5") or 
    (key == "6") or (key == "7") or (key == "8") or (key == "9") or  (key == "0") or 
    (key == "kp1") or (key == "kp2") or (key == "kp3") or (key == "kp4") or (key == "kp5") or 
    (key == "kp6") or (key == "kp7") or (key == "kp8") or (key == "kp9") or  (key == "kp0") or 
    (key == "backspace")) then
        if resizeFieldWindow.widthTextField.isFocused then
            if key == "backspace" then
                resizeFieldWindow.widthTextField.text = string.sub(resizeFieldWindow.widthTextField.text, 1, #resizeFieldWindow.widthTextField.text-1)
            elseif #resizeFieldWindow.widthTextField.text < 4 then
                resizeFieldWindow.widthTextField.text = resizeFieldWindow.widthTextField.text..string.sub(key, -1)
            end
        else
            if key == "backspace" then
                resizeFieldWindow.heightTextField.text = string.sub(resizeFieldWindow.heightTextField.text, 1, #resizeFieldWindow.heightTextField.text-1)
            elseif #resizeFieldWindow.heightTextField.text < 4 then
                resizeFieldWindow.heightTextField.text = resizeFieldWindow.heightTextField.text..string.sub(key, -1)
            end
        end
	elseif key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen)
        love.resize(love.graphics.getDimensions())
    elseif key == "r" then
        field.field = field:newField()
    elseif key == "p" then
        field.isPauseUpdate = not field.isPauseUpdate
    elseif key == "h" then
        isShowButtons = not isShowButtons
    elseif key == "l" then
        if isShowCreationArea then
            isShowWindowInformation = false
            isShowKeysInformation = false
            isShowResizeFieldWindow = false
            isShowButtons = false
            isShowCreationArea = false
            love.mouse.setVisible( false )
        else
            isShowCreationArea = true
            isShowButtons = true
            isShowWindowInformation = true
            love.mouse.setVisible( true )
        end
    elseif key == "1" then
        field.createdElement = Water
        field.tempChangeType = 0
    elseif key == "2" then
        field.createdElement = Oil
        field.tempChangeType = 0
    elseif key == "3" then
        field.createdElement = Slime
        field.tempChangeType = 0
    elseif key == "4" then
        field.createdElement = Stone
        field.tempChangeType = 0
    elseif key == "5" then
        field.createdElement = Sand
        field.tempChangeType = 0
    elseif key == "6" then
        field.createdElement = Smoke
        field.tempChangeType = 0
    elseif key == "7" then
        field.tempChangeType = 1
    elseif key == "8" then
        field.tempChangeType = -1

    elseif key == "right" and field.isPauseUpdate then
        field:update(love.timer.getDelta())
    end
end

function love.resize(w, h)
    windowWidth, windowHeight = w, h
    field:sizesComputing(w, h)
end

function love.wheelmoved(x, y)
    if y > 0 and field.creationAreaSideSize < 20 then
        field.creationAreaSideSize = field.creationAreaSideSize + 2
    elseif y < 0 and field.creationAreaSideSize > 1 then
        field.creationAreaSideSize = field.creationAreaSideSize - 2
    end
end

function drawButtons()
    for i=1,#buttons do
        buttons[i]:draw()
    end
end

function drawInformation()
    if isShowWindowInformation or isShowKeysInformation then
        local maxTextWidth = 0
        if isShowWindowInformation then
            for i=1,#windowInformation do
                local w = windowInformation[i]:getWidth()
                if w > maxTextWidth then
                    maxTextWidth = w
                end
            end
        end
        if isShowKeysInformation then
            for i=1,#keysAssignmentInformation do
                local w = keysAssignmentInformation[i]:getWidth()
                if w > maxTextWidth then
                    maxTextWidth = w
                end
            end
        end
        local margin = 10
        local leftOffset = 10
        local startingHeightPoint = 20 + margin + buttons[1].height
        if not isShowButtons then
            startingHeightPoint = 10 + margin
        end
        love.graphics.setColor({0, 0, 0, 0.5})
        local backgroundHeight = 0
        local marginBetweenBlocks = 15
        local textHeight = windowInformation[1]:getHeight()
        if isShowWindowInformation then
            backgroundHeight = backgroundHeight + (textHeight + margin)*#windowInformation
        end
        if isShowWindowInformation and isShowKeysInformation then
            backgroundHeight = backgroundHeight + marginBetweenBlocks
        end
        if isShowKeysInformation then
            backgroundHeight = backgroundHeight + (textHeight + margin)*#keysAssignmentInformation
        end
        love.graphics.rectangle("fill", leftOffset, startingHeightPoint - margin, maxTextWidth + margin * 2, backgroundHeight + margin)
        love.graphics.setColor({1, 1, 1})
        love.graphics.rectangle("line", leftOffset, startingHeightPoint - margin, maxTextWidth + margin * 2, backgroundHeight + margin)
        --love.graphics.setColor({1, 1, 1, 0.7})
        
        if isShowWindowInformation then
            for i=1,#windowInformation do
                love.graphics.draw(windowInformation[i], leftOffset + margin, startingHeightPoint + (textHeight + margin) * (i - 1))
            end
            startingHeightPoint = startingHeightPoint + (textHeight + margin) * (#windowInformation) + marginBetweenBlocks
        end
        if isShowKeysInformation then
            for i=1,#keysAssignmentInformation do
                love.graphics.draw(keysAssignmentInformation[i], leftOffset + margin, startingHeightPoint + (textHeight + margin) * (i - 1))
            end
        end
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 and isShowButtons then
        for i=1,#buttons do
            if buttons[i]:isCursorOn(x, y) then
                buttons[i].color = buttons[i].pressedColor
                if buttons[i].action == "isShowWindowInformation" then
                    isShowWindowInformation = not isShowWindowInformation
                    isShowResizeFieldWindow = false
                elseif buttons[i].action == "isShowKeysInformation" then
                    isShowKeysInformation = not isShowKeysInformation
                    isShowResizeFieldWindow = false
                elseif buttons[i].action == "isShowResizeFieldWindow" then
                    isShowResizeFieldWindow = not isShowResizeFieldWindow
                    isShowKeysInformation = false
                    isShowWindowInformation = false
                end
                resizeFieldWindow.widthTextField.isFocused = false
                resizeFieldWindow.heightTextField.isFocused = false
                isActiveItemPressed = true
            end
        end
    end
    if button == 1 and isShowResizeFieldWindow then
        if resizeFieldWindow:isCursorOnTextFields(x, y) then
            isActiveItemPressed = true
        else
            for i=1,#resizeFieldWindow.buttons do
                if resizeFieldWindow.buttons[i]:isCursorOn(x, y) then
                    resizeFieldWindow.buttons[i].color = resizeFieldWindow.buttons[i].pressedColor
                    if resizeFieldWindow.buttons[i].action == "ConfirmResize" then
                        if not ((resizeFieldWindow.widthTextField.text == '') or (resizeFieldWindow.heightTextField.text == '')) then
                            field = Field(tonumber(resizeFieldWindow.widthTextField.text), tonumber(resizeFieldWindow.heightTextField.text))
                            resizeFieldWindow.widthTextField.text = ''
                            resizeFieldWindow.heightTextField.text = ''
                            isShowResizeFieldWindow = false
                            isShowWindowInformation = true
                        end
                    elseif resizeFieldWindow.buttons[i].action == "Cancel" then
                        resizeFieldWindow.widthTextField.text = ''
                        resizeFieldWindow.heightTextField.text = ''
                        isShowResizeFieldWindow = false
                    end
                    isActiveItemPressed = true
                end
            end
            resizeFieldWindow.widthTextField.isFocused = false
            resizeFieldWindow.heightTextField.isFocused = false 
        end
    end
end

function love.mousereleased(x, y, button) 
    if button == 1 then
        if isShowButtons then
            for i=1,#buttons do
                buttons[i].color = buttons[i].releaseColor
            end
        end
        if isShowResizeFieldWindow then
            for i=1,#resizeFieldWindow.buttons do
                resizeFieldWindow.buttons[i].color = resizeFieldWindow.buttons[i].releaseColor
            end
        end
        isActiveItemPressed = false
    end
end

function love.mousemoved( x, y, dx, dy, istouch )
    field:updateMouseFieldPos(x, y)
end

function lerp(a,b,t) return a+(b-a)*t end