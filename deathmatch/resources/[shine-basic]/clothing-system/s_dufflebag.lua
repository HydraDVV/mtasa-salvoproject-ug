addEvent('dufflebag:updateDuffleBag', true)
addEvent('dufflebag:toggleDuffleBag', true)

local dufflebag = {}

function removeDuffleBag(thePlayer)
	if (getElementData(client, "dufflebagon") == true) then
		triggerEvent("dufflebag:toggleDuffleBag", client, client)
	else
		return
	end
end
addEventHandler("accounts:characters:change", root, removeDuffleBag)

function dufflebag_toggleDuffleBag(p)
	local int = getElementInterior(p)
	local dim = getElementDimension(p)
	setElementData(p, 'dufflebagon', false)
	
	if not dufflebag[p] then 
		local x, y, z = getElementPosition(p)
		local dufflebagobj = createObject(3915, x, y, z)
		setElementInterior(dufflebagobj, int)
		setElementDimension(dufflebagobj, dim)
		setObjectScale(dufflebagobj, 1)
		setElementDoubleSided(dufflebagobj, true)
		exports.bone_attach:attachElementToBone(dufflebagobj,p,3,0,-0.1325,0.145,0,0,0)
		triggerClientEvent(p, 'dufflebag:startChecking', p, true)
		dufflebag[p] = dufflebagobj
		setElementData(p, 'dufflebagon', true)
	else
		triggerClientEvent(p, 'dufflebag:startChecking', p, false)
		destroyElement(dufflebag[p])
		dufflebag[p] = nil
		setElementData(p, 'dufflebagon', false)
	end
end
addEventHandler('dufflebag:toggleDuffleBag', root, dufflebag_toggleDuffleBag)

addCommandHandler('cantatak',
function(p)
	triggerEvent('dufflebag:toggleDuffleBag', root, p)
end)

addEventHandler("onPlayerQuit", root,
function()
	if dufflebag[source] then
		destroyElement(dufflebag[source])
		dufflebag[source] = nil
	end
end)


addEventHandler('dufflebag:updateDuffleBag', root,
function(p, newInt, newDim)
	setElementInterior(dufflebag[p], newInt)
	setElementDimension(dufflebag[p], newDim)
end)