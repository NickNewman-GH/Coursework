Smoke = Gas:extend()

function Smoke:new(x, y)
    Smoke.super.new(self, x, y)
    self.color = {0.3, 0.3, 0.3}
    self.dispersionRate = field.width / 10
    self.density = 15
end

function Smoke:copy()
    return Smoke(self.x, self.y)
end