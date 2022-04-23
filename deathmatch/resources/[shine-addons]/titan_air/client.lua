airPanel = guiCreateWindow(0, 0, 220, 200, "", false, false)
guiSetVisible(airPanel, false)
centerElement(airPanel)

upBack, up = cImage(180/2 - 35/2, 41, 35, 35, files.images.up, {colors[2], colors[2], colors[1]}, airPanel)

downBack, down = cImage(0, 0, 35, 35, files.images.down, {colors[2], colors[2], colors[1]}, airPanel)
paste(downBack, upBack, "down", 0, 35+4)

leftBack, left = cImage(180/2 - 35/2, 41, 35, 35, files.images.left, {colors[2], colors[2], colors[1]}, airPanel)
paste(leftBack, upBack, "down", -(35+4), 0)

rightBack, right = cImage(180/2 - 35/2, 41, 35, 35, files.images.right, {colors[2], colors[2], colors[1]}, airPanel)
paste(rightBack, upBack, "down", 35+4, 0)

liftUpBack, liftUp = cImage(180/2 - 35/2, 41, 35, 35, files.images.up, {colors[2], colors[2], colors[1]}, airPanel)
paste(liftUpBack, rightBack, "right", 10, (-(35+4)/2))

liftDownBack, liftDown = cImage(180/2 - 35/2, 41, 35, 35, files.images.down, {colors[2], colors[2], colors[1]}, airPanel)
paste(liftDownBack, rightBack, "right", 10, ((35+4)/2))

local timer = false
addEventHandler("onClientGUIMouseDown", resourceRoot, function()
	if source == up then
		killAirTime()
		rootSound(files.sounds.air)
		triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", -0.01)
		timer = setTimer(function()
			triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", -0.01)
		end, 20, 0)
	elseif source == down then
		killAirTime()
		rootSound(files.sounds.air)
		triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", 0.01)
		timer = setTimer(function()
			triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", 0.01)
		end, 20, 0)
	elseif source == left then
		killAirTime()
		rootSound(files.sounds.air)
		triggerServerEvent("s:air", localPlayer, {"centerOfMass", -0.05})
		timer = setTimer(function()
			triggerServerEvent("s:air", localPlayer, {"centerOfMass", -0.05})
		end, 20, 0)
	elseif source == right then
		killAirTime()
		rootSound(files.sounds.air)
		triggerServerEvent("s:air", localPlayer, {"centerOfMass", 0.05})
		timer = setTimer(function()
			triggerServerEvent("s:air", localPlayer, {"centerOfMass", 0.05})
		end, 20, 0)
	elseif source == liftUp then
		killAirTime()
		rootSound(files.sounds.air)
		triggerServerEvent("s:air", localPlayer, "suspensionLowerLimit", -0.01)
		timer = setTimer(function()
			triggerServerEvent("s:air", localPlayer, "suspensionLowerLimit", -0.01)
		end, 20, 0)
	elseif source == liftDown then
		killAirTime()
		rootSound(files.sounds.air)
		triggerServerEvent("s:air", localPlayer, "suspensionLowerLimit", 0.01)
		timer = setTimer(function()
			triggerServerEvent("s:air", localPlayer, "suspensionLowerLimit", 0.01)
		end, 20, 0)
	end
end)

addEventHandler("onClientGUIMouseUp", resourceRoot, function()
	killAirTime()
end)

function killAirTime()
	if isTimer(timer) then
		killTimer(timer)
	end
	timer = false
end

local sound = false
addEvent("c:playSoundAir", true)
addEventHandler("c:playSoundAir", root, function(file, element)
	if isElement(sound) then
		destroyElement(sound)
	end
	if isElement(element) then
		local x, y, z = getElementPosition(element)
		sound = playSound3D(file, x, y, z)
		setSoundVolume(sound, 0.5)
		setSoundMaxDistance(sound, 15)
	end
end)

function rootSound(file)
	triggerServerEvent("s:rootSoundAir", localPlayer, file)
end
    local region = createColSphere ( 2916.2890625, -1903.376953125, 11.115623474121, 10)
	addCommandHandler("air", function()
	if not isElementWithinColShape(localPlayer,region) then outputChatBox('[!]#ffffff Air kompresoruna yakın değilsin.',44,44,44,true) return end
	local state = guiGetVisible(airPanel)
	guiSetVisible(airPanel, not state)
	showCursor(not state)
end)
