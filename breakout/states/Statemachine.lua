Statemachine = class{}

function Statemachine:init(states)
	self.empty = {
		render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
	}
	self.states = states or {} -- [name] -> [function that returns states]
	self.current = self.empty
end

function Statemachine:change(stateName, enterParams)
	self.current = self.states[stateName]()
	end

function Statemachine:update(dt)
	self.current:update(dt)
end

function Statemachine:render()
	self.current:render()
end
