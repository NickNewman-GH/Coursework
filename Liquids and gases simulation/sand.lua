Sand = Solid:extend()

function Sand:new(x, y)
    Sand.super.new(self, x, y)
    self.color = {0.82, 0.65, 0}
    self.density = 1500
end

function Sand:copy()
    return Sand(self.x, self.y)
end