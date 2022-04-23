addEvent('helmet:updateHelmet', true)
addEvent('helmet:toggleHelmet', true)

local helmet = {}

function removeHelmet(thePlayer)
	if (getElementData(client, "helmeton") == true) then
		triggerEvent("helmet:toggleHelmet", client, client)
	else
		return
	end
end
addEventHandler("accounts:characters:change", root, removeHelmet)

function helmet_toggleHelmet(p)
	local int = getElementInterior(p)
	local dim = getElementDimension(p)
	setElementData(p, 'helmeton', false)
	
	--outputDebugString ( "Interior " .. int .. "." )
	--outputDebugString ( "Dimension " .. dim .. "." )
	if not helmet[p] then 
		local x, y, z = getElementPosition(p)
		local helmetobj = createObject(2799, x, y, z)
		setElementInterior(helmetobj, int)
		setElementDimension(helmetobj, dim)
		setObjectScale(helmetobj, 2.6)
		setElementDoubleSided(helmetobj, false)
		exports.bone_attach:attachElementToBone(helmetobj,p,1,0,0.037,0.08,7.5,0,180)
		triggerClientEvent(p, 'helmet:startChecking', p, true)
		helmet[p] = helmetobj
		--exports.global:sendLocalMeAction(p, "puts a helmet over their head.")
		setElementData(p, 'helmeton', true)
	else
		--exports.global:sendLocalMeAction(p, "takes their helmet off.")
		triggerClientEvent(p, 'helmet:startChecking', p, false)
		destroyElement(helmet[p])
		helmet[p] = nil
		setElementData(p, 'helmeton', false)
	end
end
addEventHandler('helmet:toggleHelmet', root, helmet_toggleHelmet)

addCommandHandler('kasktak',
function(p)
	triggerEvent('helmet:toggleHelmet', root, p)
end)

addEventHandler("onPlayerQuit", root,
function()
	if helmet[source] then
		destroyElement(helmet[source])
		helmet[source] = nil
	end
end)


addEventHandler('helmet:updateHelmet', root,
function(p, newInt, newDim)
	setElementInterior(helmet[p], newInt)
	setElementDimension(helmet[p], newDim)
end)