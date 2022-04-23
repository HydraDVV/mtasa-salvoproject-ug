local bolge = createColSphere(1579.8662109375, -1635.640625, 13.560392379761,5)

addEvent("kamera:izle", true)
addEventHandler("kamera:izle", root, function()
	if isElement(main) then return end
	showCursor(true)
	main = guiCreateWindow(0,0,450,350,"Salvo Roleplay - Mobese Sistemi",false)
	guiWindowSetSizable(main, false)
	list = guiCreateGridList(5, 20, 440, 260, false,main)
	guiGridListAddColumn(list, "Bölge", 0.7)
	guiGridListAddColumn(list, "Detay", 0)
	guiGridListAddColumn(list, " ", 0)
	guiGridListAddColumn(list, " ", 0)
	guiGridListAddColumn(list, "", 0)
		    local objects = getElementsByType("object", getResourceRootElement())
		    for k, v in ipairs(objects) do
				local row = guiGridListAddRow ( list )
					guiGridListSetItemText ( list, row, 1, "Bölge: "..getElementData(v, "id"), false, false )
					guiGridListSetItemText ( list, row, 2, getElementData(v, "x"), false, false )
					guiGridListSetItemText ( list, row, 3, getElementData(v, "y"), false, false )
					guiGridListSetItemText ( list, row, 4, getElementData(v, "z"), false, false )
					guiGridListSetItemText ( list, row, 5, getElementData(v, "rot"), false, false )
		end
	onay = guiCreateButton(10,285,450,25,"Mobese İzle",false,main)
	iptal = guiCreateButton(10,315,450,25,"Arayüzü Kapat",false,main)
	addEventHandler("onClientGUIClick", guiRoot, 
		function() 
			if source == onay then
				local row, col = guiGridListGetSelectedItem(list)
				if row and col and row ~= -1 and col ~= -1 then
				local id = guiGridListGetItemText(list, row, 1)
				local x = guiGridListGetItemText(list, row, 2)
				local y = guiGridListGetItemText(list, row, 3)
				local z = guiGridListGetItemText(list, row, 4)
				local r= guiGridListGetItemText(list, row, 5)
				triggerServerEvent("mobese:izle", localPlayer, id, x, y, z, r)
				else
					outputChatBox("[!] #f0f0f0Lütfen listeden bir mobese seçin.", 255, 0, 0, true)
				end				
			elseif source == iptal then
				destroyElement(main)
				guiSetInputEnabled(false)
				setCameraTarget (localPlayer)
				showCursor(false)
				setElementPosition(localPlayer, 1579.8662109375, -1635.640625, 13.560392379761)
			end
	end)	
end)