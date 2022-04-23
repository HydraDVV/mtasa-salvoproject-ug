local gui = {}
gui["_root"] = nil
function build_MainWindow()
	if getElementData(getLocalPlayer(), "loggedin") == 1 and tonumber(getElementData(getLocalPlayer(), "level")) >= 1  and getElementData(getLocalPlayer(), "faction") == -1 then
		if gui["_root"] == nil then			
			local screenWidth, screenHeight = guiGetScreenSize()
			local windowWidth, windowHeight = 309, 256
			local left = (screenWidth/2)-(windowWidth/2)
			local top = screenHeight/2 - windowHeight/2
			gui["_root"] = guiCreateWindow(left, top, windowWidth, windowHeight, "Birlik Sistemi © REMAJOR", false)
			guiWindowSetSizable(gui["_root"], false)
			gui["LBLBirlikIsmi"] = guiCreateLabel(11, 35, 50, 13, "Birlik İsmi", false, gui["_root"])
			guiLabelSetHorizontalAlign(gui["LBLBirlikIsmi"], "left", false)
			guiLabelSetVerticalAlign(gui["LBLBirlikIsmi"], "center")
			
			gui["BTNOlustur"] = guiCreateButton(10, 165, 290, 30, "Birliği Oluştur(750.000₺)", false, gui["_root"])
			
			gui["BTNIptal"] = guiCreateButton(10, 205, 290, 30, "İptal", false, gui["_root"])
			addEventHandler("onClientGUIClick", gui["BTNIptal"], function () if source == gui["BTNIptal"] then  guiSetVisible(gui["_root"], false) destroyElement(gui["_root"]) gui["_root"] = nil guiSetInputEnabled(false) showCursor(false) end end )
			
			gui["lineEdit"] = guiCreateEdit(10, 55, 290, 30, "", false, gui["_root"])
			guiEditSetMaxLength(gui["lineEdit"], 32767)
			
			gui["RDCete"] = guiCreateRadioButton(10, 95, 82, 18, "Çete", false, gui["_root"])
			
			gui["RDMafya"] = guiCreateRadioButton(10, 115, 82, 18, "Mafya", false, gui["_root"])
			
			gui["RDDiger"] = guiCreateRadioButton(10, 135, 82, 18, "Diğer", false, gui["_root"])
			guiRadioButtonSetSelected(gui["RDDiger"],true)
			addEventHandler("onClientGUIClick", gui["BTNOlustur"], 
				function() 
					if source == gui["BTNOlustur"] then
						if guiRadioButtonGetSelected(gui["RDCete"]) then
							birlikType = 0
						elseif guiRadioButtonGetSelected(gui["RDMafya"]) then
							birlikType = 1
						elseif guiRadioButtonGetSelected(gui["RDDiger"]) then
							birlikType = 5
						end
						triggerServerEvent("birlikKur", getLocalPlayer(), getLocalPlayer(), guiGetText(gui["lineEdit"]), birlikType) 
						guiSetVisible(gui["_root"], false) 
						destroyElement(gui["_root"]) 
						gui["_root"] = nil 
						guiSetInputEnabled(false) 
						showCursor(false)
			        end			
				end
			)
			guiSetEnabled()
			guiSetInputEnabled(true)
			showCursor(true)
			guiDurumu = 1	
		elseif (gui["_root"]~=nil) then
			guiSetVisible(gui["_root"], false)
			destroyElement(gui["_root"])
			gui["_root"] = nil
			guiSetInputEnabled(false)
			showCursor(false)
		end
	end
end
addEvent("birlikGUI", true)
addEventHandler("birlikGUI", getRootElement(), build_MainWindow)

function birlikSeviyeGUI(birlikIsmi, birlikLevel, sinir)
	local screenW, screenH = guiGetScreenSize()
	local birlikFiyat = 4000000 * birlikLevel
	
	seviyeWindow = guiCreateWindow((screenW - 289) / 2, (screenH - 181) / 2, 289, 230, "Nutuk Roleplay - Birlik Seviyesi © REMAJOR", false)
	guiWindowSetSizable(seviyeWindow, false)

	isimLbl = guiCreateLabel(13, 30, 267, 24, "Birlik İsmi: " .. birlikIsmi, false, seviyeWindow)
	guiLabelSetVerticalAlign(isimLbl, "center")
	seviyeLbl = guiCreateLabel(13, 54, 267, 24, "Birlik Seviyesi: " .. birlikLevel, false, seviyeWindow)
	guiLabelSetVerticalAlign(seviyeLbl, "center")

	local yeniBirlikSeviyesi = birlikLevel + 1
	yeniSeviyeLbl = guiCreateLabel(13, 78, 267, 24, "Yeni Birlik Seviyesi: " .. yeniBirlikSeviyesi, false, seviyeWindow)
	yeniOyuncuMik = guiCreateLabel(13, 102, 267, 24, "Yeni Max. Oyuncu Sayısı: " .. sinir, false, seviyeWindow)
	
	guiLabelSetVerticalAlign(yeniSeviyeLbl, "center")
	seviyeYukseltBtn = guiCreateButton(13, 132, 267, 37, "Seviye Yükselt (" .. exports.global:formatMoney(birlikFiyat) .. "₺)", false, seviyeWindow)
	addEventHandler("onClientGUIClick", seviyeYukseltBtn, function() if source == seviyeYukseltBtn then triggerServerEvent("birlikSeviye", getLocalPlayer(), getLocalPlayer(), birlikIsmi, yeniBirlikSeviyesi, birlikFiyat) destroyElement(seviyeWindow) end end)
	seviyeKapatBtn = guiCreateButton(13, 179, 267, 37, "Kapat", false, seviyeWindow)
	addEventHandler("onClientGUIClick", seviyeKapatBtn, function() if source == seviyeKapatBtn then destroyElement(seviyeWindow) end end)
end
addEvent("birlikSeviyeGUI", true)
addEventHandler("birlikSeviyeGUI", getRootElement(), birlikSeviyeGUI)