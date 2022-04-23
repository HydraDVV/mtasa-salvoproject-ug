local sx,sy = guiGetScreenSize()
local pg,pu = 450,400
local x,y = (sx-pg)/2, (sy-pu)/2
gui = {dynamics = {},dynamics2 = {}, statics = {},statics2 = {}, cizgiler = {} }

guiSetInputMode("no_binds_when_editing")

local aracSatmaPanel = guiCreateWindow(x,y,pg,pu, "Salvo Roleplay - Araç Pazarı Sistemi", false,_,"000000","000000")
guiSetVisible(aracSatmaPanel, false)
guiWindowSetSizable(aracSatmaPanel, false)


local ortaCizgi = guiCreateStaticImage((pg-3)/2,pu/2+50,1,pu, resimOlustur("test"), false, aracSatmaPanel)

gui.statics2.sahip = guiCreateLabel((pg-1)/2+3,pu/2+60,100,20,"Arac Sahibi: ", false, aracSatmaPanel)
gui.statics2.marka = guiCreateLabel((pg-1)/2+3,pu/2+75,100,20,"Arac Markası: ", false, aracSatmaPanel)
gui.statics2.fiyat = guiCreateLabel((pg-1)/2+3,pu/2+90,100,20,"Arac Fiyatı: ", false, aracSatmaPanel)
gui.statics2.vergi = guiCreateLabel((pg-1)/2+3,pu/2+105,100,20,"Arac Vergisi: ", false, aracSatmaPanel)
gui.statics2.km = guiCreateLabel((pg-1)/2+3,pu/2+120,100,20,"Kilometre: ", false, aracSatmaPanel)

gui.dynamics2.sahip = guiCreateLabel((pg-1)/2+75,pu/2+61,100,20,"Sahip İsim", false, aracSatmaPanel)
gui.dynamics2.marka = guiCreateLabel((pg-1)/2+85,pu/2+76,100,20,"Marka İsim", false, aracSatmaPanel)
gui.dynamics2.fiyat = guiCreateLabel((pg-1)/2+77,pu/2+91,100,20,"123456789TL", false, aracSatmaPanel)
gui.dynamics2.vergi = guiCreateLabel((pg-1)/2+70,pu/2+106,100,20,"", false, aracSatmaPanel)
gui.dynamics2.km = guiCreateLabel((pg-1)/2+75,pu/2+121,100,20,"100 km", false, aracSatmaPanel)

gui.cizgiler.cizgi16 = guiCreateLabel((pg)/2,pu/2+48,pg,20, string.rep ( "_", 100 ), false, aracSatmaPanel)
gui.cizgiler.cizgi9 = guiCreateLabel((pg)/2,pu/2+65,pg,20, string.rep ( "_", 100 ), false, aracSatmaPanel)
gui.cizgiler.cizgi10 = guiCreateLabel((pg)/2,pu/2+80,pg,20, string.rep ( "_", 100 ), false, aracSatmaPanel)
gui.cizgiler.cizgi11 = guiCreateLabel((pg)/2,pu/2+95,pg,20, string.rep ( "_", 100 ), false, aracSatmaPanel)
gui.cizgiler.cizgi12 = guiCreateLabel((pg)/2,pu/2+110,pg,20, string.rep ( "_", 100 ), false, aracSatmaPanel)
gui.cizgiler.cizgi13 = guiCreateLabel((pg)/2,pu/2+125,pg,20, string.rep ( "_", 100 ), false, aracSatmaPanel)

local fiyatArkaLabel = guiCreateLabel(10,pu-60,140,30, "", false, aracSatmaPanel)
local fiyatArka = guiCreateLabel(0,0,140,50, "", false, fiyatArkaLabel)

local araclarListe = guiCreateGridList(0,25,pg,pu/2+25, false, aracSatmaPanel)
local aracIdCol = guiGridListAddColumn(araclarListe, "Arac ID", 0.2)
local aracMarkaCol = guiGridListAddColumn(araclarListe, "Arac Marka", 0.75)
guiGridListSetSortingEnabled(araclarListe, false)

local aracFiyat = guiCreateEdit(40, 5, 100,20, "", false,fiyatArka)
guiEditSetMaxLength ( aracFiyat, 9 )
guiSetProperty(aracFiyat, "ValidationString", "[0-9]*")

gui.statics.fiyatlabel = guiCreateLabel(0,5,37,20,"Fiyat:", false, fiyatArka)
gui.dynamics.fiyatguncel = guiCreateLabel(40,28,100,20,"123,456,789TL", false, fiyatArka)

local yazivar
addEventHandler("onClientGUIChanged", resourceRoot, function() 
	if source == aracFiyat then
		local fiyat = guiGetText(aracFiyat)
		guiSetText(gui.dynamics.fiyatguncel, ""..convertNumber(fiyat).. "TL")
		if fiyat ~= "" and not yazivar then -- yukarı çıkma
			if baslangic then return end
			if bitis then return end
			fx,fy = guiGetPosition(fiyatArkaLabel, false)
			fg,fu = guiGetSize(fiyatArkaLabel, false)
			yazivar = true
			baslangic = getTickCount()
			addEventHandler("onClientRender", root, render)
		elseif fiyat ==	"" then
			if baslangic then return end
			if bitis then return end
			fx,fy = guiGetPosition(fiyatArkaLabel, false)
			fg,fu = guiGetSize(fiyatArkaLabel, false)
			yazivar = false
			bitis = getTickCount()
			addEventHandler("onClientRender", root, render)
		end
	end	
end)

function render()
	local suan = getTickCount()
	if baslangic then
		local FY,FU = interpolateBetween(fy,fu,0,fy-25,fu+20,0,(suan-baslangic)/1000,"Linear")
		guiSetPosition(fiyatArkaLabel, fx,FY, false)
		guiSetSize(fiyatArkaLabel, fg,FU, false)
		if FY == fy-25 then
			baslangic = nil
			removeEventHandler("onClientRender", root, render)
		end
	elseif bitis then
		local FY,FU = interpolateBetween(fy,fu,0,fy+25,fu-20,0,(suan-bitis)/1000,"Linear")
		guiSetPosition(fiyatArkaLabel, fx,FY, false)
		guiSetSize(fiyatArkaLabel, fg,FU, false)
		if FY == fy+25 then
			bitis = nil
			removeEventHandler("onClientRender", root, render)
		end
	end
end

local aracsat = guiCreateButton(10, pu-25, 140,40, "Aracı Sat", false, aracSatmaPanel)
local kapatBT = guiCreateButton(300, pu-25, 140,40, "Kapat", false, aracSatmaPanel)

local pg,pu = 330,180
local x,y = (sx-pg)/2, (sy-pu)/2
local lx = 25
local aracBilgileri = guiCreateWindow(x,y,pg,pu,"Arac Bilgileri", false,_,"000000","000000")
guiSetVisible(aracBilgileri, false)
guiWindowSetSizable(aracBilgileri, false)

gui.statics.sahip = guiCreateLabel(10,25,100,20,"Arac Sahibi: ", false, aracBilgileri)
gui.statics.marka = guiCreateLabel(10,40,100,20,"Arac Markası: ", false, aracBilgileri)
gui.statics.model = guiCreateLabel(10,55,100,20,"Arac Modeli: ", false, aracBilgileri)
gui.statics.fiyat = guiCreateLabel(10,70,100,20,"Arac Fiyatı: ", false, aracBilgileri)
gui.statics.vergi = guiCreateLabel(10,87,100,20,"Arac Vergisi: ", false, aracBilgileri)
gui.statics.km = guiCreateLabel(10,103,100,20,"Kilometre: ", false, aracBilgileri)

gui.dynamics.sahip = guiCreateLabel(80,26,200,20,"Sahip İsim", false, aracBilgileri)
gui.dynamics.marka = guiCreateLabel(90,41,200,20,"Marka İsim", false, aracBilgileri)
gui.dynamics.model = guiCreateLabel(81,55,200,20,"Model İsim", false, aracBilgileri)
gui.dynamics.fiyat = guiCreateLabel(80,71,200,20,"123456789TL", false, aracBilgileri)
gui.dynamics.vergi = guiCreateLabel(82,88,200,20,"", false, aracBilgileri)
gui.dynamics.km = guiCreateLabel(70,104,200,20,"100 km", false, aracBilgileri)

gui.cizgiler.cizgi1 = guiCreateLabel(0,12,pg,20, string.rep ( "_", 100 ), false, aracBilgileri)
gui.cizgiler.cizgi2 = guiCreateLabel(0,29,pg,20, string.rep ( "_", 100 ), false, aracBilgileri)
gui.cizgiler.cizgi3 = guiCreateLabel(0,44,pg,20, string.rep ( "_", 100 ), false, aracBilgileri)
gui.cizgiler.cizgi4 = guiCreateLabel(0,59,pg,20, string.rep ( "_", 100 ), false, aracBilgileri)
gui.cizgiler.cizgi5 = guiCreateLabel(0,74,pg,20, string.rep ( "_", 100 ), false, aracBilgileri)
gui.cizgiler.cizgi6 = guiCreateLabel(0,92,pg,20, string.rep ( "_", 100 ), false, aracBilgileri)
gui.cizgiler.cizgi7 = guiCreateLabel(0,108,pg,20, string.rep ( "_", 100 ), false, aracBilgileri)

for i,labeller in pairs(gui.statics) do
	guiSetFont(labeller, "default-bold-small")
	guiLabelSetHorizontalAlign(labeller, "left")
	guiSetAlpha(labeller, 0.7)
end	

for i,labeller in pairs(gui.statics2) do
	guiSetFont(labeller, "default-bold-small")
	guiLabelSetHorizontalAlign(labeller, "left")
	guiSetAlpha(labeller, 0.7)
end	

for i,labeller in pairs(gui.dynamics) do
	guiSetFont(labeller, "default-bold-small")
	guiLabelSetHorizontalAlign(labeller, "left")
end

for i,labeller in pairs(gui.dynamics2) do
	guiSetFont(labeller, "default-bold-small")
	guiLabelSetHorizontalAlign(labeller, "left")
end		

for i,cizgiler in pairs(gui.cizgiler) do
	guiSetFont(cizgiler, "default-bold-small")
	guiSetAlpha(cizgiler, 0.2)
end	

--local bilgiLabel = guiCreateLabel(0, pu-90, pg,80, "123,456TL Ödeyerek \n'Örnek isim' \nisimli aracı  satın almak istediğine emin misin ?", false, aracBilgileri)
--guiLabelSetHorizontalAlign(bilgiLabel, "center")
--guiSetFont(bilgiLabel, "default-bold-small")

local satinal = guiCreateButton(10, 128, 155,40, "Satın Al", false, aracBilgileri)
local iptal = guiCreateButton(175, 128, 155,40, "İptal", false, aracBilgileri)


addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == aracsat then
		if aracSecilimi(araclarListe) then
			local fiyat = tonumber(guiGetText(aracFiyat))
 			local aracId,satilikmi = aracSecilimi(araclarListe)
			
			if not satilikmi then	
			
				if fiyat == "" then return outputChatBox("Lütfen aracını satmak istediğin fiyatı gir", 255,0,0) end
				if type(fiyat) ~= "number" then outputChatBox("Lütfen geçerli bir fiyat gir", 255,0,0) return end
			
				triggerServerEvent("AracSat:SatiligaCikar", localPlayer, aracId,fiyat,true)
				triggerServerEvent("AracSatma:AraclariCekServer", localPlayer)
				
			else
				triggerServerEvent("AracSat:SatiligtanCikar", localPlayer, aracId)
				triggerServerEvent("AracSatma:AraclariCekServer", localPlayer)	
			end	
		end
	elseif source == araclarListe then
		if aracSecilimi(araclarListe) then
			local aracId,satilikmi,arac = aracSecilimi(araclarListe)
			if satilikmi then
				guiSetText(aracsat, "Satılıktan Çıkar")
			else
				guiSetText(aracsat, "Aracı Sat")
			end
			local fiyat = getElementData(arac, "Satilik") or 0
			local sahipisim = exports.cache:getCharacterNameFromID(getElementData(arac, "owner")) or " Belirlenmemiş"
			local marka = getElementData(arac, "brand") or getVehicleNameFromModel( getElementModel( arac ) )
			local yil = getElementData(arac, "year") or "2015"
			local fiyat = exports.global:formatMoney(fiyat) or " Belirlenmemiş" 
			local km = exports.global:formatMoney(getElementData(arac, 'odometer')) or 0
			local mtamodel = getVehicleNameFromModel( getElementModel( arac )  )
			guiSetText(gui.dynamics2.sahip, sahipisim)
			guiSetText(gui.dynamics2.marka, marka)
			guiSetText(gui.dynamics2.fiyat, ""..fiyat.. "TL")
			guiSetText(gui.dynamics2.vergi, "Belirlenmemiş")
			guiSetText(gui.dynamics2.km, km.." km")
		else
			for i,v in pairs(gui.dynamics2) do guiSetText(v, "") end
		end
	elseif source == iptal then
		showCursor(false)
		guiSetVisible(aracBilgileri, false)
	elseif source == satinal then
		triggerServerEvent("AracSatma:AracSatinAl",localPlayer)
	elseif source == kapatBT then
				-- destroyElement(aracSatmaPanel)
				showCursor(false)
		guiSetVisible(aracSatmaPanel, false)
	end	
end)

addEvent("AracSatma:AraclariGonderClient", true)
addEventHandler("AracSatma:AraclariGonderClient", root, function(araclar)
	guiGridListClear(araclarListe)
	for i,v in pairs(gui.dynamics2) do guiSetText(v, "") end
	for i,v in pairs(araclar) do
		local row = guiGridListAddRow(araclarListe)
		local satilikmi = v.satilikmi
		guiGridListSetItemText(araclarListe, row, aracIdCol, v.id, false, false)
		guiGridListSetItemText(araclarListe, row, aracMarkaCol, v.model, false, false)
		guiGridListSetItemData(araclarListe, row, aracMarkaCol, v.arac)
		if satilikmi == 1 then
			for i=1,2 do
				guiGridListSetItemColor(araclarListe, row, i, 0,255,0)
			end	
			guiGridListSetItemData(araclarListe, row, aracIdCol, true)
		end	
	end
end)

function aracSecilimi(gridList)
	local row = guiGridListGetSelectedItem(gridList)
	if row ~= -1 then
		local seciliAracId = guiGridListGetItemText(gridList, row, aracIdCol)
		local satilikmi = guiGridListGetItemData(gridList, row, aracIdCol)
		local arac = guiGridListGetItemData(gridList, row, aracMarkaCol)
		return tonumber(seciliAracId),satilikmi,arac
	else
		return false
	end
end

addEvent("AracSatma:BilgiKapat", true)
addEventHandler("AracSatma:BilgiKapat", root, function()
	guiSetVisible(aracBilgileri, false)
	showCursor(false)
end)

addEvent("AracSatma:BilgiGöster", true)
addEventHandler("AracSatma:BilgiGöster", root, function(arac, fiyat)
	guiSetVisible(aracBilgileri, true)
	showCursor(true)
	local vergi = getElementData(arac, "toplamvergi") or 0
	local sahip = getElementData(arac, "owner")
	local sahipisim = exports.cache:getCharacterNameFromID(sahip) or "Bilinmiyor"
	local marka = getElementData(arac, "brand") or getVehicleNameFromModel( getElementModel( arac ) )
	local model = getElementData(arac, "maximemodel") or getVehicleNameFromModel( getElementModel( arac ) )
	local yil = getElementData(arac, "year") or "2015"
	local fiyat = exports.global:formatMoney(fiyat) 
	local vergi = exports.global:formatMoney(vergi)  
	local km = exports.global:formatMoney(getElementData(arac, 'odometer')) or 0
	local mtamodel = getVehicleNameFromModel( getElementModel( arac )  )
	local bilgiyazi = ""..fiyat.."TL Ödeyerek \n'"..model.."' \nisimli aracı satın almak istediğine emin misin ?"
	guiSetText(gui.dynamics.sahip, sahipisim)
	guiSetText(gui.dynamics.marka, marka)
	guiSetText(gui.dynamics.model, model)
	guiSetText(gui.dynamics.fiyat, ""..fiyat.."TL")
	guiSetText(gui.dynamics.vergi, ""..vergi)
	guiSetText(gui.dynamics.km, km.." km")
	--guiSetText(bilgiLabel, bilgiyazi)
end)

-- bindKey("3", "down", function()
	-- guiSetVisible(aracSatmaPanel, not guiGetVisible(aracSatmaPanel))
	-- showCursor(guiGetVisible(aracSatmaPanel))
	-- if guiGetVisible(aracSatmaPanel) then
		-- for i,v in pairs(gui.dynamics2) do guiSetText(v, "") end
		-- guiSetInputMode("no_binds_when_editing")
		-- triggerServerEvent("AracSatma:AraclariCekServer", localPlayer)
	-- end	
-- end)

addEvent("AracSatma:PanelAc", true)
addEventHandler("AracSatma:PanelAc", root, function()
	guiSetVisible(aracSatmaPanel, not guiGetVisible(aracSatmaPanel))
	showCursor(guiGetVisible(aracSatmaPanel))
	if guiGetVisible(aracSatmaPanel) then
		for i,v in pairs(gui.dynamics2) do guiSetText(v, "") end
		guiSetInputMode("no_binds_when_editing")
		triggerServerEvent("AracSatma:AraclariCekServer", localPlayer)
	end	
end)

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end













-- kopyalancak = ""
-- bindKey(",", "down", function()
	-- local x,y,z = getElementPosition(localPlayer)
	-- local rx,ry,rz = getElementRotation(localPlayer)
	-- kopyalancak = kopyalancak.."{"..x..","..y..","..z..","..rz.."},"
	-- setClipboard(kopyalancak)
	-- outputDebugString(kopyalancak)
-- end)