

Tiles = class{}

function Tiles:init(x, y, color, variety)
    
    -- board positions
    self.gridx = x
    self.gridy = y

    -- coordinate positions
    self.x = (self.gridx - 1) * 32
    self.y = (self.gridy - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    self.isShiny=math.random(23)==1 and true or false

    self.psystem = love.graphics.newParticleSystem(particle, 64)
    self.psystem:setParticleLifetime(0.5, 1)
    self.psystem:setEmissionRate(64)
    self.psystem:setRadialAcceleration(8,20)
    self.psystem:setEmissionArea('normal', 5, 5)
    self.psystem:setSizes(0.9,0.9,0.9) 
    self.psystem:setColors(0.65,0.45,0.56,0.5,0.65,0.45,0.56,1)  
    self.psystem:emit(64) 
end

function Tiles:update(dt)
    self.psystem:update(dt)
end

function Tiles:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34/255, 32/255, 52/255, 255/255)
    love.graphics.draw(spritesheet, colorquads[self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself   
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.draw(spritesheet,colorquads[self.color][self.variety],self.x + x, self.y + y)

    if self.isShiny then
        love.graphics.draw(self.psystem, self.x+16+x, self.y+16+y)
    end
    
end

