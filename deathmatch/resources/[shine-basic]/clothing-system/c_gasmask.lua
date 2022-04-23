addEvent('gasmask:startChecking', true)

local currentInterior, currentDimension = 0, 0
local enabled = false

function gasmask_startChecking()
	enabled = not enabled
	
	--outputDebugString("GASMASK") 
	
	if enabled then
		currentInterior, currentDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
		addEventHandler('onClientPreRender', root, gasmask_checkGasMask)
		--outputDebugString("Added")
	else
		removeEventHandler('onClientPreRender', root, gasmask_checkGasMask)
		--outputDebugString("Removed")
	end
end

function gasmask_checkGasMask()
	local newInterior, newDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
	
	if currentInterior ~= newInterior or currentDimension ~= newDimension then
		triggerServerEvent('gasmask:updateGasMask', localPlayer, newInterior, newDimension)
		currentInterior, currentDimension = newInterior, newDimension
	end
end
addEventHandler('gasmask:startChecking', root, gasmask_startChecking)