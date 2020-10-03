statemachine = class{}

function statemachine:init(states)
	self.empty = {
		render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
	}
	self.states = states or {} -- [name] -> [function that returns states]
	self.current = self.empty
end

function statemachine:change(stateName, enterParams)
	
	self.current = self.states[stateName]()
end

function statemachine:update(dt)
	self.current:update(dt)
end

function statemachine:render()
	self.current:render()
end
