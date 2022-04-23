--SlamyShop
local santvPed = createPed(91, 359.6962890625, 173.91796875, 1008.3893432617)
setPedRotation( santvPed, 266.33737182617)
setElementDimension(santvPed, 68)
setElementInterior(santvPed, 3)
setElementData(santvPed, "talk", 1)
setElementData(santvPed, "name", "Melike Hanim")
setPedAnimation (santvPed, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, false, false, false)
setElementFrozen(santvPed, true)

local reklamGonderebilir = true
function reklamGUI()
	guiSetInputMode("no_binds_when_editing")
	local screenW, screenH = guiGetScreenSize()
	reklamWindow = guiCreateWindow((screenW - 484) / 2, (screenH - 183) / 2, 484, 183, "İlan - Reklam Verme Paneli", false)
	guiWindowSetSizable(reklamWindow, false)

	reklamLbl = guiCreateLabel(10, 24, 464, 26, "Reklamınız:", false, reklamWindow)
	guiLabelSetVerticalAlign(reklamLbl, "center")
	reklamEdit = guiCreateEdit(10, 50, 464, 29, "", false, reklamWindow)
	gonderBtn = guiCreateButton(10, 89, 464, 34, "Reklamı Gönder (15000 TL)", false, reklamWindow)
	guiSetProperty(gonderBtn, "NormalTextColour", "FFAAAAAA")
	kapatBtn = guiCreateButton(10, 133, 464, 34, "Pencereyi Kapat", false, reklamWindow)
	guiSetProperty(kapatBtn, "NormalTextColour", "FFAAAAAA")
	addEventHandler("onClientGUIClick", guiRoot, btnFunctions)
end
addEvent("reklamGUI", true)
addEventHandler("reklamGUI", root, reklamGUI)

function btnFunctions()
	if source == kapatBtn then
		destroyElement(reklamWindow)
	elseif source == gonderBtn then
		if reklamGonderebilir then
			if exports.global:hasMoney(getLocalPlayer(), 15000) then
				--outputChatBox("[!] #ffffffReklamınız birazdan yayınlanacak.", 0, 255, 0, true)
                triggerServerEvent("reklamGonder", getLocalPlayer(), getLocalPlayer(), guiGetText(reklamEdit))
				reklamGonderebilir = false
				setTimer(function() reklamGonderebilir = true end, 300000, 1)
			else
				outputChatBox("[!] #f0f0f0Reklam vermek için yeterli paranız yok.", 255, 0, 0, true)
			end
		else
			outputChatBox("[!] #f0f0f0Her 5 dakikada bir reklam gönderebilirsiniz.", 255, 0, 0, true)
		end
		destroyElement(reklamWindow)
	end
end