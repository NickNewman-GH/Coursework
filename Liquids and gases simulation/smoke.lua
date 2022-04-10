Smoke = Gas:extend()

function Smoke:new(x, y)
    Smoke.super.new(self, x, y)
    self.color = {0.3, 0.3, 0.3}
    self.dispersionRate = field.width / 10
    self.density = 15
    --self.tempBounds = {upper = {50, Sand}}
end

function Smoke:copy()
    local elem = Smoke(self.x, self.y)
    elem.temp = self.temp
    elem.color = self.color
    return elem
end