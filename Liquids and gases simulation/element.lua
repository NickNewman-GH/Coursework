Element = Object:extend()

function Element:new(x, y)
    self.x = x
    self.y = y
    self.color = {1, 1, 1}
    -- self.gravity = 1
end

function Element:update(fieldClass, newField, dt)
    return
end