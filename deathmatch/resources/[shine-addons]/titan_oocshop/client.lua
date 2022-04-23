local screenWidth, screenHeight = guiGetScreenSize()
local gui = {}
gui._placeHolders = {}
gui["_root"] = nil
kisisel_ozellikler = {
	[1] = {"İsim Değişikliği", 5},
	[2] = {"Kullanıcı Adı Değişikliği", 10},
	[3] = {"Vip 1", 20},
	[4] = {"Vip 2", 40},
	[5] = {"Vip 3", 50},
	[6] = {"Karakter Limiti Ekleme", 10},
	[7] = {"Araç Limiti Ekleme", 5},
	[8] = {"Özel Telefon Numarası", 10},
	[9] = {"Maske Kullanım Hakkı", 10},
}

araclar_ozellikler = {
		 --AracListeAdi, Hiz, Fiyat, AracID, AracAdi, Vergi
    [1] = {"BMW M4", "360", 150, 412, "BMW M4", 100},
    [2] = {"Bugatti ", "320", 100, 451, "Bugatti Veyron", 110},
    [3] = {"Lamborghini Huracan", "280", 90, 434, "Lamborghini", 40},
    [4] = {"Ferrari Berlinetta", "280", 80, 436, "Ferrari Berlinetta", 100},
    [5] = {"Mclaren P1(Hot 2)", "280", 60, 503, "Mclaren P1", 120},
    [6] = {"Mercedes G500 6x6", "220", 60, 470, "Mercedes G500 6x6", 100},
    [7] = {"Corvette(Windsor)", "270", 45, 555, "Corvette", 80},
    [8] = {"Mustang GT(Hot)", "270", 45, 494, "Mustang GT", 90},
    [9] = {"Nissan GTR(Bloodring)", "275", 40, 504, "Nissan GTR35", 100},
    [10] = {"Nissan R34", "265", 40, 527, "Nissan R34", 100},
    [11] = {"Maserati", "280", 35, 495, "Maserati", 100},
    [12] = {"Dodge Challanger(Hot 3)", "265", 35, 502, "Dodge Challanger", 85},
    [13] = {"Porsche", "260", 30, 602, "Porsche", 100},
    [14] = {"Mazda MX5", "250", 25, 533, "Mazda MX5", 120},
    [15] = {"Helikopter", "220", 150, 487, "Helikopter", 100},
		 

	

}


skin_ozellikler = {
	[1] = {"Sport Siyahi", 10, 306},
	[2] = {"Takım Elbiseli", 10, 300},
	[3] = {"Kahverengi Hırkalı", 10, 308},
	[4] = {"Siyah Ceketli", 10, 15},
	[5] = {"Siyah Takımlı Vito", 10, 310},
	[6] = {"Kahverengi Kabanlı", 10, 311},
	[7] = {"Gri Takımlı Vito", 10, 312},
	[8] = {"Kolu Dövmeli Kolyeli Genç", 10, 14},
	[9] = {"Takım Elbiseli Yakışıklı", 10, 98},
	[10] = {"Kız Donate", 10, 169},
    [11] = {"Damatlık Skini", 10, 297},
	[12] = {"Kırmızı Takım Elbiseli", 10, 307},
	[13] = {"Beyaz Takım Elbiseli", 10, 309},
	[14] = {"Gözlüklü Takım Elbiseli", 10, 301},
	[15] = {"Lacivert Takım Elbiseli", 10, 302},
	[16] = {"Gri Takım Elbiseli", 10, 305},
	[17] = {"Maskeli Gömlekli", 15, 299},
	[18] = {"Maskeli Ceketli", 15, 296},
	[19] = {"Lacivert Şapkalı Skin", 15, 295},
	[20] = {"Gözlüklü Yakışıklı", 15, 291},
}

silah_ozellikler = {
	[1] = {"Colt-45", "colt45" , 22, 20},
	[2] = {"Uzi", "uzi", 28, 40},
	[3] = {"Shotgun", "shotgun", 25, 40},
	[4] = {"Rifle", "rifle", 33, 80},
	[5] = {"AK-47", "ak47", 30, 120},
	[6] = {"MP5", "mp5", 29, 50},
	[7] = {"Silenced", "silenced", 23, 30},
	[8] = {"Tec-9", "tec-9", 32, 35},
	[9] = {"M4", "m4", 31, 160},
}

function build_MainWindow()
	if getElementData(getLocalPlayer(), "loggedin") == 1 then
		if gui["_root"] == nil then
			setElementData(getLocalPlayer(), "donate:durum", true)
			local windowWidth, windowHeight = 634, 416
			local left = screenWidth/2 - windowWidth/2
			local top = screenHeight/2 - windowHeight/2
			local bakiye = getElementData(getLocalPlayer(), "account:bakiye") or 0
			gui["_root"] = guiCreateWindow(left, top, windowWidth, windowHeight, "Salvo Roleplay - Bağış Sistemi © Salvo", false)
			guiWindowSetSizable(gui["_root"], false)
			gui["LBLBakiye"] = guiCreateLabel(550, 25, 100, 100, "Bakiye: ".. bakiye .. "TL", false, gui["_root"])
			gui["tabWidget"] = guiCreateTabPanel(0, 25, 631, 340, false, gui["_root"])
			gui["tab"] = guiCreateTab("Kişisel Özellikler", gui["tabWidget"])
			gui["tab_2"] = guiCreateTab("Araçlar", gui["tabWidget"])
			gui["tab_4"] = guiCreateTab("Kıyafetler", gui["tabWidget"])
			gui["tab_5"] = guiCreateTab("Silahlar", gui["tabWidget"])
			gui["GRDKisisel"] = guiCreateGridList ( 10, 10, 595, 257, false, gui["tab"])
			guiGridListAddColumn ( gui["GRDKisisel"], "İsim", 0.7 )
			guiGridListAddColumn ( gui["GRDKisisel"], "Fiyat", 0.25 )
			for key, ozellik in pairs(kisisel_ozellikler) do
				local satir = guiGridListAddRow ( gui["GRDKisisel"] )
				guiGridListSetItemText ( gui["GRDKisisel"], satir, 1, ozellik[1], false, false )
				guiGridListSetItemText ( gui["GRDKisisel"], satir, 2, ozellik[2], false, false )
			end
			gui["BTNSatinAlKisisel"] = guiCreateButton(10, 275, 595, 30, "Satın Al", false, gui["tab"])
			addEventHandler("onClientGUIClick", gui["BTNSatinAlKisisel"], function ()
				if source == gui["BTNSatinAlKisisel"] then
					if bakiye_cek() < tonumber(guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 2 )) then
						outputChatBox("#cc0000[!] #FFFFFFYeterli bakiyeniz bulunmamakta!", 0, 255, 0, true)
						return
					end
					if guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[1][1] then
						build_MainWindow_IsimDegistir()
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[2][1] then
						build_MainWindow_KullaniciAdi()
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[3][1] then
						--triggerServerEvent("donate:vipEkle", getLocalPlayer(), getLocalPlayer(), 1, tonumber(guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 2 )))
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[4][1] then
						--triggerServerEvent("donate:vipEkle", getLocalPlayer(), getLocalPlayer(), 2, tonumber(guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 2 )))
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[5][1] then
						--triggerServerEvent("donate:vipEkle", getLocalPlayer(), getLocalPlayer(), 3, tonumber(guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 2 )))
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[6][1] then
						triggerServerEvent("donate:karakterLimitiEkle", getLocalPlayer(), getLocalPlayer())
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[7][1] then
						triggerServerEvent("donate:aracLimitiEkle", getLocalPlayer(), getLocalPlayer())
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[8][1] then
						build_MainWindow_TelNo(guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 2 ))
					elseif guiGridListGetItemText ( gui["GRDKisisel"], guiGridListGetSelectedItem ( gui["GRDKisisel"] ), 1 ) == kisisel_ozellikler[9][1] then	
						triggerServerEvent("donate:maskehak", getLocalPlayer(), getLocalPlayer())			
					end
				end
			end)
			gui["GRDAraclar"] = guiCreateGridList ( 10, 10, 350, 257, false, gui["tab_2"])
			guiGridListAddColumn ( gui["GRDAraclar"], "İsim", 0.6 )
			guiGridListAddColumn ( gui["GRDAraclar"], "Hız", 0.15 )
			guiGridListAddColumn ( gui["GRDAraclar"], "Fiyat", 0.25 )
			for key, ozellik in pairs(araclar_ozellikler) do
				local satir = guiGridListAddRow ( gui["GRDAraclar"] )
				guiGridListSetItemText ( gui["GRDAraclar"], satir, 1, ozellik[1], false, false )
				guiGridListSetItemText ( gui["GRDAraclar"], satir, 2, ozellik[2], false, false )
				guiGridListSetItemText ( gui["GRDAraclar"], satir, 3, ozellik[3], false, false )
			end
			gui["IMGArac"] = guiCreateStaticImage( 370, 65, 235, 150, "/assets/vehicles/none.png", false, gui["tab_2"] )
			gui["BTNSatinAlArac"] = guiCreateButton(10, 275, 595, 30, "Satın Al", false, gui["tab_2"])
			addEventHandler("onClientGUIClick", gui["GRDAraclar"], function ()
				if not source == gui["GRDAraclar"] then return end
				if guiGridListGetSelectedItem ( gui["GRDAraclar"] ) then
					for key, ozellik in pairs(araclar_ozellikler) do
						if ozellik[1] == guiGridListGetItemText ( gui["GRDAraclar"], guiGridListGetSelectedItem ( gui["GRDAraclar"] ), 1 ) then
							--destroyElement(gui["IMGArac"])
							guiStaticImageLoadImage(gui["IMGArac"], "/assets/vehicles/".. ozellik[4] ..".png")
							--gui["IMGArac"] = guiCreateStaticImage( 370, 65, 235, 150, "/assets/vehicles/".. ozellik[4] ..".png", false, gui["tab_2"] )
						end
					end
				end
			end)
			
			addEventHandler("onClientGUIClick", gui["BTNSatinAlArac"], function ()
				if source == gui["BTNSatinAlArac"] then
					if not getElementData(getLocalPlayer(), "donate:durum") then outputChatBox("#cc0000[!] #FFFFFFAraç indikten sonra bakiyeniz varsa tekrar alabilirsiniz.", 0, 255, 0, true) return end
					if bakiye_cek() < tonumber(guiGridListGetItemText ( gui["GRDAraclar"], guiGridListGetSelectedItem ( gui["GRDAraclar"] ), 3 )) then
						outputChatBox("#cc0000[!] #FFFFFFYeterli bakiyeniz bulunmamakta!", 0, 255, 0, true)
						return
					end
					if guiGridListGetSelectedItem ( gui["GRDAraclar"] ) then
						for key, ozellik in pairs(araclar_ozellikler) do
							if ozellik[1] == guiGridListGetItemText ( gui["GRDAraclar"], guiGridListGetSelectedItem ( gui["GRDAraclar"] ), 1 ) then
								setElementData(getLocalPlayer(), "donate:durum", false)
								triggerServerEvent("donate:aracAl", getLocalPlayer(), getLocalPlayer(), ozellik[4], ozellik[3], ozellik[5], ozellik[6]) 
							end
						end
					end
				end
			end)

			
			gui["GRDKiyafetler"] = guiCreateGridList ( 10, 10, 350, 257, false, gui["tab_4"])
			guiGridListAddColumn ( gui["GRDKiyafetler"], "Kıyafet", 0.7 )
			guiGridListAddColumn ( gui["GRDKiyafetler"], "Fiyat", 0.25 )
			for key, ozellik in pairs(skin_ozellikler) do
				local satir = guiGridListAddRow ( gui["GRDKiyafetler"] )
				guiGridListSetItemText ( gui["GRDKiyafetler"], satir, 1, ozellik[1], false, false )
				guiGridListSetItemText ( gui["GRDKiyafetler"], satir, 2, ozellik[2], false, false )
			end
			gui["IMGKiyafet"] = guiCreateStaticImage( 400, 14, 150, 250, "/assets/skins/none.png", false, gui["tab_4"] )
			gui["BTNSatinAlKiyafet"] = guiCreateButton(10, 275, 595, 30, "Satın Al", false, gui["tab_4"])
			addEventHandler("onClientGUIClick", gui["GRDKiyafetler"], function ()
				if not source == gui["GRDKiyafetler"] then return end
				if guiGridListGetSelectedItem ( gui["GRDKiyafetler"] ) then
					for key, ozellik in pairs(skin_ozellikler) do
						if ozellik[1] == guiGridListGetItemText ( gui["GRDKiyafetler"], guiGridListGetSelectedItem ( gui["GRDKiyafetler"] ), 1 ) then
							--destroyElement(gui["IMGKiyafet"])
							guiStaticImageLoadImage(gui["IMGKiyafet"], "/assets/skins/".. ozellik[3] ..".png")
							--gui["IMGKiyafet"] = guiCreateStaticImage( 400, 14, 150, 250, "/assets/skins/".. ozellik[3] ..".png", false, gui["tab_4"] )
						end
					end
				end
			end)
			addEventHandler("onClientGUIClick", gui["BTNSatinAlKiyafet"], function ()
				if source == gui["BTNSatinAlKiyafet"] then
					if bakiye_cek() < tonumber(guiGridListGetItemText ( gui["GRDKiyafetler"], guiGridListGetSelectedItem ( gui["GRDKiyafetler"] ), 2 )) then
						outputChatBox("#cc0000[!] #FFFFFFYeterli bakiyeniz bulunmamakta!", 0, 255, 0, true)
						return
					end
					if guiGridListGetSelectedItem ( gui["GRDKiyafetler"] ) then
						for key, ozellik in pairs(skin_ozellikler) do
							if ozellik[1] == guiGridListGetItemText ( gui["GRDKiyafetler"], guiGridListGetSelectedItem ( gui["GRDKiyafetler"] ), 1 ) then
								triggerServerEvent("donate:kiyafetAl", getLocalPlayer(), getLocalPlayer(), ozellik[3], ozellik[2]) 
							end
						end
					end
				end
			end)
			gui["LBLBilgi"] = guiCreateLabel(10, 10, 350, 257,"BİLGİ: Buradan sadece illegal karakterler silah satın alabilirler.", false, gui["tab_5"])
			gui["GRDSilahlar"] = guiCreateGridList ( 10, 35, 350, 232, false, gui["tab_5"])
			guiGridListAddColumn ( gui["GRDSilahlar"], "İçerik", 0.7 )
			guiGridListAddColumn ( gui["GRDSilahlar"], "Fiyat", 0.25 )
			for key, ozellik in pairs(silah_ozellikler) do
				local satir = guiGridListAddRow ( gui["GRDSilahlar"] )
				guiGridListSetItemText ( gui["GRDSilahlar"], satir, 1, ozellik[1], false, false )
				guiGridListSetItemText ( gui["GRDSilahlar"], satir, 2, ozellik[4], false, false )
			end
			gui["IMGSilah"] = guiCreateStaticImage( 400, 55, 150, 150, "/assets/weapons/none.png", false, gui["tab_5"] )
			addEventHandler("onClientGUIClick", gui["GRDSilahlar"], function ()
				if not source == gui["GRDSilahlar"] then return end
				if guiGridListGetSelectedItem ( gui["GRDSilahlar"] ) then
					for key, ozellik in pairs(silah_ozellikler) do
						if ozellik[1] == guiGridListGetItemText ( gui["GRDSilahlar"], guiGridListGetSelectedItem ( gui["GRDSilahlar"] ), 1 ) then
							--destroyElement(gui["IMGSilah"])
							guiStaticImageLoadImage(gui["IMGSilah"], "/assets/weapons/".. ozellik[3] ..".png")
							--gui["IMGSilah"] = guiCreateStaticImage( 400, 55, 150, 150, "/assets/weapons/".. ozellik[3] ..".png", false, gui["tab_5"] )
						end
					end
				end
			end)
			gui["BTNSatinAlSilah"] = guiCreateButton(10, 275, 595, 30, "Satın Al", false, gui["tab_5"])
			addEventHandler("onClientGUIClick", gui["BTNSatinAlSilah"], function ()
				if source == gui["BTNSatinAlSilah"] then
					if not getElementData(getLocalPlayer(), "donate:durum") then outputChatBox("#cc0000[!] #FFFFFFİşlem için bekleyin.", 0, 255, 0, true) return end
					if getElementData(getLocalPlayer(), "karakter_tip") == 0 then outputChatBox("#cc0000[!]#ffffff Buradan sadece illegal karakterler silah satın alabilir.", 255, 0, 0, true ) return end
					if bakiye_cek() < tonumber(guiGridListGetItemText ( gui["GRDSilahlar"], guiGridListGetSelectedItem ( gui["GRDSilahlar"] ), 2 )) then
						outputChatBox("#cc0000[!] #FFFFFFYeterli bakiyeniz bulunmamakta!", 0, 255, 0, true)
						return
					end
					if guiGridListGetSelectedItem ( gui["GRDSilahlar"] ) then
						for key, ozellik in pairs(silah_ozellikler) do
							if ozellik[1] == guiGridListGetItemText ( gui["GRDSilahlar"], guiGridListGetSelectedItem ( gui["GRDSilahlar"] ), 1 ) then
								local vip = tonumber(getElementData(getLocalPlayer(), "vipver")) or 0
								if ozellik[3] == 300 or ozellik[3] == 330 then
									if vip < 3 then
										outputChatBox("#cc0000[!] #FFFFFFBu silahı kullanmak için VIP 3 olmanız gerekmekte.", 0, 255, 0, true)
										return
									end
								end
								if ozellik[3] == 250 then
									if vip < 2 then
										outputChatBox("#cc0000[!] #FFFFFFBu silahı kullanmak için VIP 2 veya üstü olmanız gerekmekte.", 0, 255, 0, true)
										return
									end
								end
								setElementData(getLocalPlayer(), "donate:durum", false)
								triggerServerEvent("donate:silahAl", getLocalPlayer(), getLocalPlayer(), ozellik[3], ozellik[1], ozellik[4]) 
							end
						end
					end
				end
			end)
			
			gui["BTNKapat"] = guiCreateButton(10, 375, 631, 30, "Kapat", false, gui["_root"])
			addEventHandler("onClientGUIClick", gui["BTNKapat"], function () if source == gui["BTNKapat"] then  guiSetVisible(gui["_root"], false) destroyElement(gui["_root"]) gui["_root"] = nil guiSetInputEnabled(false) showCursor(false) end end )
			guiSetInputEnabled(true)
			showCursor(true)
			triggerEvent("hud:convertUI", getLocalPlayer(), gui["_root"])
		else
			guiSetVisible(gui["_root"], false)
			destroyElement(gui["_root"])
			gui["_root"] = nil
			guiSetInputEnabled(false)
			showCursor(false)
		end
	end
end
addCommandHandler("market", build_MainWindow)

function bakiye_cek()
	return tonumber(getElementData(getLocalPlayer(), "account:bakiye"))
end

gui["_root_isim_degis"] = nil
function build_MainWindow_IsimDegistir()
	if getElementData(getLocalPlayer(), "loggedin") == 1 then
		if gui["_root_isim_degis"] == nil then			
			gui._placeHolders = {}
			local windowWidth, windowHeight = 422, 182
			local left = screenWidth/2 - windowWidth/2
			local top = screenHeight/2 - windowHeight/2
			guiSetEnabled(gui["_root"], false)
			gui["_root_isim_degis"] = guiCreateWindow(left, top, windowWidth, windowHeight, "Salvo Roleplay - İsim Değiştirme Sistemi @ Salvo", false)
			guiWindowSetSizable(gui["_root_isim_degis"], false)
			
			gui["TXTName"] = guiCreateEdit(6, 34, 407, 27, "", false, gui["_root_isim_degis"])
			guiEditSetMaxLength(gui["TXTName"], 32767)
			gui["LBLNot"] = guiCreateLabel(10, 65, 161, 25, "Örnek: Alp Tosun", false, gui["_root_isim_degis"])
			gui["BTNGuncelle"] = guiCreateButton(10, 95, 400, 30, "Tamam", false, gui["_root_isim_degis"])
			gui["BTNIptal"] = guiCreateButton(10, 135, 400, 30, "Vazgeç", false, gui["_root_isim_degis"])
			addEventHandler("onClientGUIClick", gui["BTNIptal"], function () if source == gui["BTNIptal"] then  guiSetVisible(gui["_root_isim_degis"], false) destroyElement(gui["_root_isim_degis"]) gui["_root_isim_degis"] = nil guiSetEnabled(gui["_root"], true) end end )
			addEventHandler("onClientGUIClick", gui["BTNGuncelle"], function ()
				if source == gui["BTNGuncelle"] then
					if string.len(guiGetText(gui["TXTName"])) < 6 then
						outputChatBox("#cc0000[!] #FFFFFFGirilen isim en az 6 karakterden oluşmalıdır!", 0, 255, 0, true)
						return
					elseif string.len(guiGetText(gui["TXTName"])) > 20 then
						outputChatBox("#cc0000[!] #FFFFFFGirilen isim en fazla 20 karakterden oluşmalıdır!", 0, 255, 0, true)
						return
					end
  					triggerServerEvent("donate:isimDegistir", getLocalPlayer(), getLocalPlayer(), guiGetText(gui["TXTName"]))
  					guiSetVisible(gui["_root_isim_degis"], false) 
  					destroyElement(gui["_root_isim_degis"]) 
  					gui["_root_isim_degis"] = nil 
					guiSetEnabled(gui["_root"], true)
				end
			end)
			guiSetEnabled()
			guiSetInputEnabled(true)
			guiDurumu = 1	
		elseif (gui["_root_isim_degis"]~=nil) then
			guiSetVisible(gui["_root_isim_degis"], false)
			destroyElement(gui["_root_isim_degis"])
			gui["_root_isim_degis"] = nil
			guiSetEnabled(gui["_root"], true)
		end
	end
end

function build_MainWindow_KullaniciAdi()
	gui._placeHolders = {}
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 266, 130
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	guiSetEnabled(gui["_root"], false)
	gui["_root_kullanici_adi"] = guiCreateWindow(left, top, windowWidth, windowHeight, "Kullanıcı Adı Değişimi @ Salvo", false)
	guiWindowSetSizable(gui["_root_kullanici_adi"], false)
	gui["label"] = guiCreateLabel(10, 25, 100, 16, "Yeni Kullanıcı Adı:", false, gui["_root_kullanici_adi"])
	guiLabelSetHorizontalAlign(gui["label"], "left", false)
	guiLabelSetVerticalAlign(gui["label"], "center")
	gui["TXTUsername"] = guiCreateEdit(10, 45, 241, 27, "", false, gui["_root_kullanici_adi"])
	gui["BTNIptal"] = guiCreateButton(10, 85, 110, 30, "Vazgeç", false, gui["_root_kullanici_adi"])	
	addEventHandler("onClientGUIClick", gui["BTNIptal"], function () if source == gui["BTNIptal"] then  guiSetVisible(gui["_root_kullanici_adi"], false) destroyElement(gui["_root_kullanici_adi"]) gui["_root_kullanici_adi"] = nil guiSetEnabled(gui["_root"], true) end end )
	gui["BTNOnayla"] = guiCreateButton(140, 85, 110, 30, "Tamam", false, gui["_root_kullanici_adi"])
	addEventHandler("onClientGUIClick", gui["BTNOnayla"], function ()
		local username = guiGetText(gui["TXTUsername"])
		if (string.len(username)<3) then
			outputChatBox("#cc0000[!] #FFFFFFGirilen kullanıcı adı en az 3 karakter olmalı.", 0, 255, 0, true)
		elseif (string.find(username, ";", 0)) or (string.find(username, "'", 0)) or (string.find(username, "@", 0)) or (string.find(username, ",", 0)) or (string.find(username, " ", 0)) then
			outputChatBox("#cc0000[!] #FFFFFFKullanıcı adında ;,@.' veya boşluk bulunamaz.", 0, 255, 0, true)
		else
			triggerServerEvent("donate:kullaniciAdiGuncelle", getLocalPlayer(), getLocalPlayer(), guiGetText(gui["TXTUsername"]))
			guiSetVisible(gui["_root_kullanici_adi"], false) 
			destroyElement(gui["_root_kullanici_adi"]) 
			gui["_root_kullanici_adi"] = nil 
			guiSetEnabled(gui["_root"], true)
		end
	end)
end



function build_MainWindow_TelNo(fiyat)
	guiSetInputMode("no_binds_when_editing")
	guiSetEnabled(gui["_root"], false)
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 276, 127
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root_telno"] = guiCreateWindow(left, top, windowWidth, windowHeight, "Özel Telefon Numarası © Salvo", false)
	guiWindowSetSizable(gui["_root_telno"], false)
	
	gui["LBLBaslik"] = guiCreateLabel(10, 25, 131, 16, "Numara Girin(10 haneli, başında 0 olmadan):", false, gui["_root_telno"])
	guiLabelSetHorizontalAlign(gui["LBLBaslik"], "left", false)
	guiLabelSetVerticalAlign(gui["LBLBaslik"], "center")
	
	gui["textEdit"] =	guiCreateEdit(10, 45, 250, 30, "", false, gui["_root_telno"])	
	gui["BTNVazgec"] = guiCreateButton(10, 85, 120, 30, "Vazgeç", false, gui["_root_telno"])
	addEventHandler("onClientGUIClick", gui["BTNVazgec"], function() 
		if source == gui["BTNVazgec"] then
			destroyElement(gui["_root_telno"]) 
			guiSetEnabled(gui["_root"], true)
		end
	end)
	gui["BTNTamam"] = guiCreateButton(140, 85, 120, 30, "Tamam", false, gui["_root_telno"])
	addEventHandler("onClientGUIClick", gui["BTNTamam"], function() 
		if source == gui["BTNTamam"] then
			if not (tonumber(string.len(guiGetText(gui["textEdit"]))) == 10) then 
				outputChatBox("[!] #ffffffLütfen başında 0 olmadan 10 haneli bir numara girin.",255,0,0, true) 
				return
			end
			if not (type(tonumber(guiGetText(gui["textEdit"]))) == "number" ) then 
				outputChatBox("[!] #ffffffLütfen telefon numarasını harfsiz girin.",255,0,0, true)
				return
			end
			triggerServerEvent("donate:telNoAl", getLocalPlayer(), getLocalPlayer(), guiGetText(gui["textEdit"]), fiyat) 
		    destroyElement(gui["_root_telno"]) 
			guiSetEnabled(gui["_root"], true)
		end
	end)
end
