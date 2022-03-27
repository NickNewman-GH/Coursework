Element = Object:extend()

function Element:new(x, y)
    self.x = x
    self.y = y
    self.color = {1, 1, 1}
    self.gravity = field.height/50 + 1
    self.isUpdated = false
    self.density = 999999
end

function Element:update(fieldClass, newField, dt)
    return
end

function Element:copy()
    return
end