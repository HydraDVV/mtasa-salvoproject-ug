addEvent('kevlarvest:updateKevlarVest', true)
addEvent('kevlarvest:toggleKevlarVest', true)

local kevlarvest = {}

function removeKevlarVest(thePlayer)
	if (getElementData(client, "kevlarveston") == true) then
		triggerEvent("kevlarvest:toggleKevlarVest", client, client)
	else
		return
	end
end
addEventHandler("accounts:characters:change", root, removeKevlarVest)

function kevlarvest_toggleKevlarVest(p)
	local int = getElementInterior(p)
	local dim = getElementDimension(p)
	setElementData(p, 'kevlarveston', false)
	
	if not kevlarvest[p] then 
		local x, y, z = getElementPosition(p)
		local kevlarvestobj = createObject(3916, x, y, z)
		setElementInterior(kevlarvestobj, int)
		setElementDimension(kevlarvestobj, dim)
		setObjectScale(kevlarvestobj, 1.125)
		setElementDoubleSided(kevlarvestobj, true)
		exports.bone_attach:attachElementToBone(kevlarvestobj,p,3,0,0.025,0.075,0,270,0)
		triggerClientEvent(p, 'kevlarvest:startChecking', p, true)
		kevlarvest[p] = kevlarvestobj
		setElementData(p, 'kevlarveston', true)
	else
		triggerClientEvent(p, 'kevlarvest:startChecking', p, false)
		destroyElement(kevlarvest[p])
		kevlarvest[p] = nil
		setElementData(p, 'kevlarveston', false)
	end
end
addEventHandler('kevlarvest:toggleKevlarVest', root, kevlarvest_toggleKevlarVest)

addCommandHandler('barikattak',
function(p)
	triggerEvent('kevlarvest:toggleKevlarVest', root, p)
end)

addEventHandler("onPlayerQuit", root,
function()
	if kevlarvest[source] then
		destroyElement(kevlarvest[source])
		kevlarvest[source] = nil
	end
end)


addEventHandler('kevlarvest:updateKevlarVest', root,
function(p, newInt, newDim)
	setElementInterior(kevlarvest[p], newInt)
	setElementDimension(kevlarvest[p], newDim)
end)