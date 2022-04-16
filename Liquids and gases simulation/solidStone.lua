SolidStone = Solid:extend()

function SolidStone:new(x, y)
    SolidStone.super.new(self, x, y)
    self.color = {0.5, 0.5, 0.5, 0.65}
    self.density = 1500
    self.tempBounds = {upper = {1000, Lava}}
end

function SolidStone:copy()
    local elem = SolidStone(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end

function SolidStone:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/250 + self.temp/250
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end