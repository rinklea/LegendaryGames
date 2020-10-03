util=class{}

function generatequads(atlas,tilewidth,tileheight)
	sheetwidth=atlas:getWidth()/tilewidth
	sheetheight=atlas:getHeight()/tileheight

	spritesheet={}
	spritecounter=1

	for y=0,sheetheight -1 do
		for x=0,sheetwidth-1 do
			spritesheet[spritecounter]=love.graphics.newQuad(x*tilewidth,y*tileheight,tilewidth,tileheight,
				atlas:getDimensions())
			spritecounter=spritecounter+1
		end
	end
	return spritesheet
end

function table.slice(tbl,first,last,step)
	sliced={}
	counter=1
	for i=first or 1,last or #tbl,step or 1 do
		sliced[counter]=tbl[i]
		counter=counter+1
	end
	return sliced
end

function generatequadbricks(atlas)
	quads={}
	quads= table.slice(generatequads(atlas,32,16),1,21,1)
	quads[22]=love.graphics.newQuad(160,48,32,16,atlas:getDimensions())
	return quads
end

function generatequadpaddles(atlas)
	x=0
	y=64

	quads={}
	counter=1

	for i=0,3 do
		quads[counter]=love.graphics.newQuad(x,y,32,16,atlas:getDimensions())
		counter=counter+1
		quads[counter]=love.graphics.newQuad(x+32,y,64,16,atlas:getDimensions())
		counter=counter+1
		quads[counter]=love.graphics.newQuad(x+96,y,96,16,atlas:getDimensions())
		counter=counter+1
		quads[counter]=love.graphics.newQuad(x,y+16,128,16,atlas:getDimensions())
		counter=counter+1

		x=0
		y=y+32
	end
	return quads
end

function generatequadballs(atlas)
	x=96
	y=48

	quads={}
	counter=1

	for i=0,3 do
		quads[counter]=love.graphics.newQuad(x,y,8,8,atlas:getDimensions())
		counter=counter+1
		x=x+8
	end

	x=96
	y=y+8
	for i=0,2 do
		quads[counter]=love.graphics.newQuad(x,y,8,8,atlas:getDimensions())
		counter=counter+1
		x=x+8
	end
	return quads
end


function generatequadhealth(atlas)
	quads={}
	counter=1
	x=128
	y=48
	for i=0,1 do
		quads[counter]=love.graphics.newQuad(x,y,10,8,atlas:getDimensions())
		counter=counter+1
		x=x+10
	end
	return quads
end

function generatequadpower(atlas)
	x=0
	y=192
	counter=1
	quads={}
	for i=0,9 do
		quads[counter]=love.graphics.newQuad(x,y,16,16,atlas:getDimensions())
		counter=counter+1
		x=x+16
	end
	return quads

end










