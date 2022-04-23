addEvent('helmet:startChecking', true)

local currentInterior, currentDimension = 0, 0

function helmet_startChecking(check)
	check = check or false
	if check then
		currentInterior, currentDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
		addEventHandler('onClientPreRender', root, helmet_checkHelmet)
	else
		removeEventHandler('onClientPreRender', root, helmet_checkHelmet)
	end
end

function helmet_checkHelmet()
	local newInterior, newDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
	if currentInterior ~= newInterior or currentDimension ~= newDimension then
		triggerServerEvent('helmet:updateHelmet', root, localPlayer, newInterior, newDimension)
		currentInterior, currentDimension = newInterior, newDimension
	end
end
addEventHandler('helmet:startChecking', root, helmet_startChecking)