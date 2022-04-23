addEvent('rod:updateRod', true)
addEvent('rod:toggleRod', true)

local rod = {}

function removeRod(thePlayer)
	if (getElementData(client, "rodon") == true) then
		triggerEvent("rod:toggleRod", client, client)
	else
		return
	end
end
addEventHandler("accounts:characters:change", root, removeRod)

function rod_toggleRod(p)
	local int = getElementInterior(p)
	local dim = getElementDimension(p)
	setElementData(p, 'rodon', false)
	
	if not rod[p] then 
		local x, y, z = getElementPosition(p)
		local rodobj = createObject(16442, x, y, z)
		setElementInterior(rodobj, int)
		setElementDimension(rodobj, dim)
		setObjectScale(rodobj, 2)
		setElementDoubleSided(rodobj, false)
		exports.bone_attach:attachElementToBone(rodobj,p,11,0,0.037,0.08,0,270,0)
		triggerClientEvent(p, 'rod:startChecking', p, true)
		rod[p] = rodobj
		setElementData(p, 'rodon', true)
	else
		triggerClientEvent(p, 'rod:startChecking', p, false)
		destroyElement(rod[p])
		rod[p] = nil
		setElementData(p, 'rodon', false)
	end
end
addEventHandler('rod:toggleRod', root, rod_toggleRod)

addCommandHandler('rod',
function(p)
	triggerEvent('rod:toggleRod', root, p)
end)

addEventHandler("onPlayerQuit", root,
function()
	if rod[source] then
		destroyElement(rod[source])
		rod[source] = nil
	end
end)

addEventHandler('rod:updateRod', root,
function(p, newInt, newDim)
	setElementInterior(rod[p], newInt)
	setElementDimension(rod[p], newDim)
end)