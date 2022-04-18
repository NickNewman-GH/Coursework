Smoke = Gas:extend()

function Smoke:new(x, y)
    Smoke.super.new(self, x, y)
    self.color = {0.3, 0.3, 0.3, 0.65}
    self.dispersionRate = field.width / 10 + 1
    self.density = 15
end

function Smoke:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/250 + self.temp/250
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end