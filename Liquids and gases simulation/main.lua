function love.load()
    Object = require "classic"
    require "elementManager"
    require "field"
    require "element"
    require "sand"
    require "liquid"
    require "oil"
    require "slime"
    -----
    require "sand1"
    require "sand2"
    -----
    require "water"
    require "stone"

    windowWidth, windowHeight = 800, 800
    love.window.setMode(windowWidth, windowHeight, {resizable=true, vsync=true})
    
    field = Field(150, 150)
    fullscreen = false
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
        field.createdElement = Oil
    elseif key == "3" then
        field.createdElement = Slime
    elseif key == "4" then
        field.createdElement = Stone
    elseif key == "5" then
        field.createdElement = Sand
    -----
    elseif key == "6" then
        field.createdElement = Sand1
    elseif key == "7" then
        field.createdElement = Sand2
    -----
    elseif key == "right" and field.isPauseUpdate then
        field:update()
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

function drawInformation()
    love.graphics.setColor({1, 0, 0})
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.print("Field height: "..tostring(field.height), 10, 30)
    love.graphics.print("Field width: "..tostring(field.width), 10, 50)
    love.graphics.print("Creation area size: "..tostring(field.creationAreaSideSize+1), 10, 70)
    -- love.graphics.print("Window width: "..tostring(windowWidth), 10, 70)
    -- love.graphics.print("Window height: "..tostring(windowHeight), 10, 90)
    love.graphics.print("Key Assignment:", 10, 100)
    love.graphics.print("1 - Water (by default, dens = 900)", 10, 120)
    love.graphics.print("2 - Oil (dens = 750)", 10, 140)
    love.graphics.print("3 - Slime (dens = 800)", 10, 160)
    love.graphics.print("4 - Stone (static)", 10, 180)
    love.graphics.print("5 - Sand 1 (dens = 1500)", 10, 200)
    love.graphics.print("6 - Sand 2 (dens = 950)", 10, 220)
    love.graphics.print("7 - Sand 3 (dens = 775)", 10, 240)
    love.graphics.print("Mwheel up - larger particle creation area", 10, 260)
    love.graphics.print("Mwheel down - smaller particle creation area", 10, 280)
    love.graphics.print("R - Clear field", 10, 300)
    love.graphics.print("P - Pause/Unpause", 10, 320)
    love.graphics.print("Right arrow - Next frame (when paused)", 10, 340)
    love.graphics.print("F11 - Full screen/Windowed mode", 10, 360)
    love.graphics.print("Lmouse button - Create particles", 10, 380)
    love.graphics.print("Rmouse button - Delete particles", 10, 400)
end