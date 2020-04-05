local State = {}
State.name = ""
State.terminal = false
State.transitions = {}

function State:new(name, isTerminal)
	local o = {}
	o.name = name
	o.terminal = isTerminal
	o.transitions = {}
	o.__index = self
	
	setmetatable(o, o)
	return o
end

function State:step(token)
	return self.transitions[token]
end

function State:add(token, target)
	if self.transitions[token] == nil then
		self.transitions[token] = {}
	end
	table.insert(self.transitions[token], target)
end

function State:getName()
	return self.name
end

function State:isTerminal()
	return self.terminal
end

function State:getTransitions()
	return self.transitions
end

return State