local mike = createPed(280, 238.9697265625, 112.8544921875, 1003.21875)
local lspdOptionMenu = nil
-- 251.2587890625, 68.1279296875, 1003.640625, 93.898834228516, 6, 4
setPedRotation(mike, 88)
setElementFrozen(mike, true)
setElementDimension(mike, 1158)
setElementInterior(mike, 10)
--setPedAnimation(mike, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false, false)
setElementData(mike, "talk", 1, false)
setElementData(mike, "name", "Mike Moore", false)

function popupLSPDPedMenu()
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if not lspdOptionMenu then
		local width, height = 150, 100
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		lspdOptionMenu = guiCreateWindow(x, y, width, height, "Yardýmamý Ýhtiyacýnýz Var ?", false)

		bPhotos = guiCreateButton(0.05, 0.2, 0.87, 0.2, "Ýhbar Vereceðim", true, lspdOptionMenu)
		addEventHandler("onClientGUIClick", bPhotos, helpButtonFunction, false)

		bAdvert = guiCreateButton(0.05, 0.5, 0.87, 0.2, "Suçumu Ýtiraf Edeceðim", true, lspdOptionMenu)
		addEventHandler("onClientGUIClick", bAdvert, appointmentButtonFunction, false)
		
		bSomethingElse = guiCreateButton(0.05, 0.8, 0.87, 0.2, "Her Þey Gayet Yolunda", true, lspdOptionMenu)
		addEventHandler("onClientGUIClick", bSomethingElse, otherButtonFunction, false)
		triggerServerEvent("lspd:ped:start", getLocalPlayer(), getElementData(mike, "name"))
		showCursor(true)
	end
end
addEvent("lspd:popupPedMenu", true)
addEventHandler("lspd:popupPedMenu", getRootElement(), popupLSPDPedMenu)

function closeLSPDPedMenu()
	destroyElement(lspdOptionMenu)
	lspdOptionMenu = nil
	showCursor(false)
end

function helpButtonFunction()
	closeLSPDPedMenu()
	triggerServerEvent("lspd:ped:help", getLocalPlayer(), getElementData(mike, "name"))
end

function appointmentButtonFunction()
	closeLSPDPedMenu()
	triggerServerEvent("lspd:ped:appointment", getLocalPlayer(), getElementData(mike, "name"))
end

function otherButtonFunction()
	closeLSPDPedMenu()
end