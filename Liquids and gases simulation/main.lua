function love.load()
    Object = require "classic"
    require "field"
    require "element"
    require "sand"
    require "water"
    require "stone"

    windowWidth, windowHeight = 800, 800
    love.window.setMode(windowWidth, windowHeight, {resizable=true, vsync=true})
    
    field = Field(250, 250)
    fullscreen = false

    ---
    -- fieldX, fieldY = 0, 0
    ---
end

function love.update(dt)
    if love.mouse.isDown(1) then
        field:addElements(love.mouse.getPosition())
    elseif love.mouse.isDown(2) then
        field:removeElements(love.mouse.getPosition())
    end
    -- if love.keyboard.isDown('space') then
    --     field:update(dt)
    -- end
    if not field.isPauseUpdate then
        field:update(dt)
    end
end

function love.draw()
    field:draw()
    love.graphics.setColor({0.8, 0.8, 0.8})
    if field.widthOffset > 0 then
        love.graphics.rectangle("fill", 0, 0, field.widthOffset, windowHeight)
        love.graphics.rectangle("fill", windowWidth - field.widthOffset, 0, field.widthOffset, windowHeight)
    elseif field.heightOffset > 0 then
        love.graphics.rectangle("fill", 0, 0, windowWidth, field.heightOffset)
        love.graphics.rectangle("fill", 0, windowHeight - field.heightOffset, windowWidth, field.heightOffset)
    end
    drawInformation()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen)
        love.resize(love.graphics.getDimensions())
    elseif key == "r" then
        field.field = field:newField()
    elseif key == "p" then
        field.isPauseUpdate = not field.isPauseUpdate
    elseif key == "1" then
        field.createdElement = Water
    elseif key == "2" then
        field.createdElement = Sand
    elseif key == "3" then
        field.createdElement = Stone
    elseif key == "right" then
        field:update()
    end
end

function love.resize(w, h)
    windowWidth, windowHeight = w, h
    field:sizesComputing(w, h)
end

function love.wheelmoved(x, y)
    if y > 0 and field.creationAreaSideSize < 19 then
        field.creationAreaSideSize = field.creationAreaSideSize + 1
    elseif y < 0 and field.creationAreaSideSize > -1 then
        field.creationAreaSideSize = field.creationAreaSideSize - 1
    end
end

function drawInformation()
    love.graphics.setColor({1, 0, 0})
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.print("Field height: "..tostring(field.height), 10, 30)
    love.graphics.print("Field width: "..tostring(field.width), 10, 50)
    love.graphics.print("Creation area size: "..tostring(field.creationAreaSideSize+1), 10, 70)
    -- love.graphics.print("Window width: "..tostring(windowWidth), 10, 70)
    -- love.graphics.print("Window height: "..tostring(windowHeight), 10, 90)
    love.graphics.print("Key Assignment:", 10, 100)
    love.graphics.print("1 - Water (by default)", 10, 120)
    love.graphics.print("2 - Sand", 10, 140)
    love.graphics.print("3 - Stone", 10, 160)
    love.graphics.print("Mwheel up - larger particle creation area", 10, 180)
    love.graphics.print("Mwheel down - smaller particle creation area", 10, 200)
    love.graphics.print("R - Clear field", 10, 220)
    love.graphics.print("F11 - Full screen/Windowed mode", 10, 240)
    love.graphics.print("Lmouse button - Create particles", 10, 260)
    love.graphics.print("Rmouse button - Delete particles", 10, 280)
end