addEvent('rod:startChecking', true)

local currentInterior, currentDimension = 0, 0

function rod_startChecking(check)
    check = check or false
    if check then
        currentInterior, currentDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
        addEventHandler('onClientPreRender', root, rod_checkRod)
    else
        removeEventHandler('onClientPreRender', root, rod_checkRod)
    end
end

function rod_checkRod()
    local newInterior, newDimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
    if currentInterior ~= newInterior or currentDimension ~= newDimension then
        triggerServerEvent('rod:updateRod', root, localPlayer, newInterior, newDimension)
        currentInterior, currentDimension = newInterior, newDimension
    end
end
addEventHandler('rod:startChecking', root, rod_startChecking)