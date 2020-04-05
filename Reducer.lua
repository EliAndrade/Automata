local DState = require "DState"

local function exists(t, item)
	for i, v in ipairs(t) do
		if v == item then
			return true
		end
	end

	return false
end

local function equals(t1, t2)
	if #t1 ~= #t2 then
		return false
	else
		for i, v in ipairs(t1) do
			if not exists(t2, v) then
				return false
			end
		end
	end

	return true
end

local Reducer = {}

function Reducer.reduce(first, dictionary)
	local done = {}
	local rows = {}
	local queue = {{first}}

	io.write("\t")
	for i, v in ipairs(dictionary) do
		io.write(v.."\t")
	end
	print()

	while #queue > 0 do
		local item = table.remove(queue, 1)
		table.insert(done, {set = item})
		table.insert(rows, {__set = item})

		for i, v in ipairs(item) do
			io.write(v:getName().."|")
		end
		io.write("\t")
		
		
		
		for j, token in ipairs(dictionary) do
			local comp = {}
			for i, state in ipairs(item) do
				local transitions = state:step(token)

				if transitions then
					for k, target in ipairs(transitions) do
						if not exists(comp, target) then
							table.insert(comp, target)
						end
					end
				end
			end

			local push = true
			for i, v in ipairs(done) do
				if equals(v.set, comp) then
					push = false
					break
				end
			end

			if push then
				table.insert(queue, comp)
			end
			
			rows[#rows][token] = comp
			
			for i, v in pairs(comp) do
				io.write(v:getName().."|")
			end
			io.write("\t")
		end
		print()
	end
	
	
	
	print("---------------")
	for i, v in ipairs(rows) do
		local name = ""
		local terminal = false
		
		for j, k in ipairs(v.__set) do
			name = name..k:getName()
			if k:isTerminal() then
				terminal = true
			end
		end
	
		v.__dstate = DState:new(name, terminal)
	end
	
	for i, source in ipairs(rows) do
		for j, token in ipairs(dictionary) do
			for k, target in ipairs(rows) do
				if equals(source[token], target.__set) then
					source.__dstate:add(token, target.__dstate)
				end
			end
		end
	end
	
	
	
	for i, v in ipairs(rows) do
		print(v.__dstate:getName())
		for j, k in pairs(v.__dstate:getTransitions()) do
			print("\t"..j.."-->"..k:getName())
		end
	end
	
	print('----------------')
	return rows[1].__dstate
end

return Reducer
