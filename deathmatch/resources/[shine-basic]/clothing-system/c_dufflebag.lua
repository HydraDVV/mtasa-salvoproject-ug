addEvent('dufflebag:startChecking', true)

local currentInterior, currentDimension = 0, 0

function dufflebag_startChecking(check)
	check = check or false
	if check then
		currentInterior, currentDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
		addEventHandler('onClientPreRender', root, dufflebag_checkDuffleBag)
	else
		removeEventHandler('onClientPreRender', root, dufflebag_checkDuffleBag)
	end
end

function dufflebag_checkDuffleBag()
	local newInterior, newDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
	if currentInterior ~= newInterior or currentDimension ~= newDimension then
		triggerServerEvent('dufflebag:updateDuffleBag', root, localPlayer, newInterior, newDimension)
		currentInterior, currentDimension = newInterior, newDimension
	end
end
addEventHandler('dufflebag:startChecking', root, dufflebag_startChecking)