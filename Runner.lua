local Runner = {}

function Runner.runDFA(firstState, word, regex)
	local actual = firstState

	for token in word:gmatch(regex) do
		print(("%s--%s-->"):format(actual:getName(), token))
		actual = actual:step(token)
		if not actual then
			print("##Invalid!##")
			break
		end
	end
	if actual then
		if actual:isTerminal() then
			print(("%s: Accepted"):format(actual:getName()))
		else
			print(("%s: Rejected"):format(actual:getName()))
		end
	end
end

return Runner