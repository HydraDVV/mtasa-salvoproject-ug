addEvent('kevlarvest:startChecking', true)

local currentInterior, currentDimension = 0, 0

function kevlarvest_startChecking(check)
	check = check or false
	if check then
		currentInterior, currentDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
		addEventHandler('onClientPreRender', root, kevlarvest_checkKevlarVest)
	else
		removeEventHandler('onClientPreRender', root, kevlarvest_checkKevlarVest)
	end
end

function kevlarvest_checkKevlarVest()
	local newInterior, newDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
	if currentInterior ~= newInterior or currentDimension ~= newDimension then
		triggerServerEvent('kevlarvest:updateKevlarVest', root, localPlayer, newInterior, newDimension)
		currentInterior, currentDimension = newInterior, newDimension
	end
end
addEventHandler('kevlarvest:startChecking', root, kevlarvest_startChecking)