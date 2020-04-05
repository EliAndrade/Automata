local DrawState = {}
DrawState.name = ""
DrawState.x = 0
DrawState.y = 0
DrawState.transitions = {}
DrawState.terminal = false

function DrawState:new(name, x, y)
	local o = {}
	o.name = name
	o.x = x
	o.y = y
	o.terminal = false
	o.transitions = {}
	
	o.__index = self
	setmetatable(o, o)
	
	return o
end

function DrawState:draw()
	if self.terminal then
		love.graphics.setColor(1, 0, 0)
	else
		love.graphics.setColor(0, 0, 0)
	end
	love.graphics.circle("line", self.x, self.y, 16, 16)
end

return DrawState