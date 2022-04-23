addEvent('gasmask:updateGasMask', true)
addEvent('gasmask:toggleGasMask', true)

local gasmask = {}

function removeGasMask(thePlayer)
	if (getElementData(client, "maskon") == true) then
		triggerEvent("gasmask:toggleGasMask", client, client)
	else
		return
	end
end
addEventHandler("accounts:characters:change", root, removeGasMask)

function gasmask_toggleGasMask(p)
	local int = getElementInterior(p)
	local dim = getElementDimension(p)
	setElementData(p, 'maskon', false)

	if not gasmask[p] then 
		local x, y, z = getElementPosition(p)
		gasmask[p] = createObject(3890, x, y, z)
		setElementInterior(gasmask[p], int) 
		setElementDimension(gasmask[p], dim)
		setObjectScale(gasmask[p], 0.8725)
		setElementDoubleSided(gasmask[p], true)
		exports.bone_attach:attachElementToBone(gasmask[p],p,1,0.00825,0.092,0.021,0,-3,90)
		--outputDebugString ( "MOTHERFUKIN MASK SERVER" )
		triggerClientEvent(p, 'gasmask:startChecking', p, true)
		setElementData(p, 'maskon', true)
	else
		triggerClientEvent(p, 'gasmask:startChecking', p, false)
		destroyElement(gasmask[p])
		gasmask[p] = nil
		setElementData(p, 'maskon', false)
	end
end
addEventHandler('gasmask:toggleGasMask', root, gasmask_toggleGasMask)

addCommandHandler('gazmaskesitak',
function(p)
	triggerEvent('gasmask:toggleGasMask', root, p)
end)

addEventHandler("onPlayerQuit", root,
function()
	if gasmask[source] then
		destroyElement(gasmask[source])
		gasmask[source] = nil
	end
end)


addEventHandler('gasmask:updateGasMask', root,
function(newInt, newDim)
	setElementInterior(gasmask[client], newInt)
	setElementDimension(gasmask[client], newDim)
end)