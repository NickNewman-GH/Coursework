Ice = Static:extend()

function Ice:new(x, y)
    Ice.super.new(self, x, y)
    self.color = {0.5, 0.72, 0.94, 0.65}
    self.thermalConductivity = 1
    self.tempBounds = {upper = {1, Water}}
end

function Ice:copy()
    local elem = Ice(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end

function Ice:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/500 + self.temp/500
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end