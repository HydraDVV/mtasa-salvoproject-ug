﻿-- the office guy
local ped = createPed(240, 2142.4794921875, -1424.8388671875, 293.73016357422)
setElementInterior(ped, 2)
setElementDimension(ped, 25)
setPedRotation(ped, 3.0185241699219)
--setPedAnimation( ped, "FOOD", "FF_Sit_Look", -1, true, false, false )
setElementData( ped, "talk", 1, false )
setElementData( ped, "name", "Ahmet Kar", false )
addEventHandler("onClientPedDamage", ped, cancelEvent)
setElementFrozen(ped, true)
local vehElements = {}
car, wImpound, bClose, bRelease, gCars, lCost, IDcolumn = nil

function showImpoundUI(vehElementsret)
	if not wImpound then
		local width, height = 400, 200
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth - width
		local y = scrHeight/10
		
		wImpound = guiCreateWindow(x, y, width, height, "Aracınızı Serbest Bırakın", false)
		guiWindowSetSizable(wImpound, false)
		
		bClose = guiCreateButton(0.6, 0.85, 0.2, 0.1, "Kapat", true, wImpound)
		bRelease = guiCreateButton(0.825, 0.85, 0.2, 0.1, "Serbest Birak", true, wImpound)
		addEventHandler("onClientGUIClick", bClose, hideImpoundUI, false)
		addEventHandler("onClientGUIClick", bRelease, releaseCar, false)
		

		gCars = guiCreateGridList(0.05, 0.1, 0.9, 0.65, true, wImpound)
		addEventHandler("onClientGUIClick", gCars, updateCar, false)
		local col = guiGridListAddColumn(gCars, "Cekilen Araclariniz", 0.7)
		IDcolumn = guiGridListAddColumn(gCars, "ID", 0.2)
		vehElements = vehElementsret
		for key, value in ipairs(vehElements) do
			local dbid = getElementData(value, "dbid")
			local row = guiGridListAddRow(gCars)
			guiGridListSetItemText(gCars, row, col, getVehicleName(value), false, false)
			guiGridListSetItemText(gCars, row, IDcolumn, tostring(dbid), false, false)
		end
		guiGridListSetSelectedItem(gCars, 0, 1)
		
		lCost = guiCreateLabel(0.3, 0.85, 0.2, 0.1, "Fiyat: 25000 TL", true, wImpound)
		guiSetFont(lCost, "default-bold-small")
		
		updateCar()
			

		guiSetInputEnabled(true)
		
		outputChatBox("#FF0000[!]#FFFFFFİstanbul Araç Çekim Tamirat'a Hos Geldiniz!.", 0, 0, 0, true)
	end
end

function updateCar()
	local row, col = guiGridListGetSelectedItem(gCars)
	
	if (row~=-1) and (col~=-1) then
		guiSetText(lCost, "Fiyat : 25000 TL")
		
		if not exports.global:hasMoney(getLocalPlayer(), 25000) and exports.global:hasItem(getLocalPlayer(), 3, guiGridListGetItemText(gCars, row, IDcolumn)) then
			guiLabelSetColor(lCost, 255, 0, 0)
			guiSetEnabled(bRelease, false)
		else
			guiLabelSetColor(lCost, 0, 255, 0)
			guiSetEnabled(bRelease, true)
		end
	else
		guiSetEnabled(bRelease, false)
	end
end


function hideImpoundUI()
	destroyElement(bClose)
	bClose = nil
	
	destroyElement(bRelease)
	bRelease = nil

	
	destroyElement(wImpound)
	wImpound = nil
	
	setCameraTarget(getLocalPlayer())
	guiSetInputEnabled(false)
end

function releaseCar(button)
	if (button=="left") then
		local row = guiGridListGetSelectedItem(gCars)
		hideImpoundUI()
		triggerServerEvent("releaseCar", getLocalPlayer(), vehElements[row+1])
	end
end
addEvent("ShowImpound", true)
addEventHandler("ShowImpound", getRootElement(), showImpoundUI)
