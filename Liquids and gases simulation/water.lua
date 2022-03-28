Water = Liquid:extend()

function Water:new(x, y)
    Water.super.new(self, x, y)
    self.color = {0, 0.72, 0.94}
    self.dispersionRate = field.width / 10
    self.density = 900
end

function Water:copy()
    return Water(self.x, self.y)
end