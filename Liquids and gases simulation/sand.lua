Sand = Solid:extend()

function Sand:new(x, y)
    Sand.super.new(self, x, y)
    self.color = {0.82, 0.65, 0, 0.65}
    self.density = 1500
end

function Sand:colorChangeDueTemp(fieldClass)
    self.color[4] = 0.65 - fieldClass.insideTemp/250 + self.temp/250
    if self.color[4] < 0.3 then
        self.color[4] = 0.3
    end
end