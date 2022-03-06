function love.load()
    Object = require "classic"
    require "field"
    require "cell"

    windowWidth, windowHeight = 800, 800
    love.window.setMode(windowWidth, windowHeight, {resizable=true, vsync=false})

    local cellCoordinates = {{50,180}, {51,180}, {50,181}, {51,181}, {60,180}, {60,179}, {60,181}, {61,178}, {62,177}, {63,177}, {61,182}, {62,183}, {63,183}, {65,182}, {66,181}, {66,180}, {66,179}, {65,178}, {64,180}, {67,180}, {70,181}, {70,182}, {70,183}, {71,181}, {71,182}, {71,183}, {72,180}, {72,184}, {74,180}, {74,179}, {74,184}, {74,185}, {84,182}, {84,183}, {85,182}, {85,183}}
    local cellTable = toCellTable(cellCoordinates)

    love.graphics.setBackgroundColor({1, 1, 1})
    
    field = Field(200, 200, cellTable)
    fullscreen = false

    if #field.cells == 0 then
        field:generate()
    end
end

function love.update(dt)
    -- field:generate()
    
    -- if dt < 1/fps then
    --     love.timer.sleep(1/fps - dt)
    -- end
    field:update()
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
    love.graphics.print("Cells: "..tostring(#field.cells), 10, 110)
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen)
        love.resize(love.graphics.getDimensions())
    elseif key == "r" then
        field:generate()
    elseif key == "space" then
        field:update()
    end
end

function love.resize(w, h)
    windowWidth, windowHeight = w, h
    field:sizesComputing(w, h)
end

function toCellTable(cellCoordinates)
    local cellTable = {}
    for i=1,#cellCoordinates do
        cellTable[i] = Cell(cellCoordinates[i][1], cellCoordinates[i][2])
    end
    return cellTable
end