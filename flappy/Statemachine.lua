Statemachine = Class{}

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

function Statemachine:change(statename)
	assert(self.states[statename]) -- state must exist!
	
	self.current = self.states[statename]()

end

function Statemachine:update(dt)
	self.current:update(dt)
end

function Statemachine:render()
	self.current:render()
end