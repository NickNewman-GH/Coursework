Slime = Liquid:extend()

function Slime:new(x, y)
    Slime.super.new(self, x, y)
    self.color = {0.25, 0.75, 0.25}
    self.dispersionRate = field.width / 50
    self.density = 800
end

function Slime:copy()
    return Slime(self.x, self.y)
end