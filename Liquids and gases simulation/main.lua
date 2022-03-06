function love.load()
    Object = require "classic"
    require "field"
    require "element"
    require "sand"
    require "water"

    windowWidth, windowHeight = 800, 800
    love.window.setMode(windowWidth, windowHeight, {resizable=true, vsync=true})

    -- love.graphics.setBackgroundColor({0, 0, 0})
    
    field = Field(500, 500)
    fullscreen = false

    -- mouseX, mouseY = love.mouse.getPosition()

    -- love.mouse.setVisible(false)

    -- fps = 60

    ---
    fieldX, fieldY = 0, 0
    ---
end

function love.update(dt)
    if love.mouse.isDown(1) then
        field:addElement(love.mouse.getPosition())
        ---
        mouseX, mouseY = love.mouse.getPosition()
        fieldX = math.floor((mouseX - field.widthOffset) / field.sideSize)
        fieldY = math.floor((mouseY - field.heightOffset) / field.sideSize)
        ---
    end
    -- field:generate()
    
    -- if dt < 1/fps then
    --     love.timer.sleep(1/fps - dt)
    -- end
    field:update(dt)
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
    love.graphics.setColor({1, 0, 0})
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    love.graphics.print("Field height: "..tostring(field.height), 10, 30)
    love.graphics.print("Field width: "..tostring(field.width), 10, 50)
    love.graphics.print("Window width: "..tostring(windowWidth), 10, 70)
    love.graphics.print("Window height: "..tostring(windowHeight), 10, 90)
    ---
    -- love.graphics.print("Mouse position on field: "..tostring(fieldX + 1).."; "..tostring(fieldY + 1), 10, 110)
    ---
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen)
        love.resize(love.graphics.getDimensions())
    elseif key == "r" then
        field.field = field:newField()
    elseif key == "1" then
        field.createdElement = Water
    elseif key == "2" then
        field.createdElement = Sand
    end
end

function love.resize(w, h)
    windowWidth, windowHeight = w, h
    field:sizesComputing(w, h)
end