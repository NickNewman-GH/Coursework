Oil = Liquid:extend()

function Oil:new(x, y)
    Oil.super.new(self, x, y)
    self.color = {1, 0.9, 0, 0.65}
    self.dispersionRate = field.width / 15
    self.density = 900
    self.thermalConductivity = 2
end

function Oil:copy()
    local elem = Oil(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end