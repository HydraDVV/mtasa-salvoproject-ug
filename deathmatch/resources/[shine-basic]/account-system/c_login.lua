--Globals
local lUsername, tUsername, lPassword, tPassword, chkRememberLogin, bLogin, bRegister, defaultingTimer = nil
local newsTitle, newsText, newsAuthor
local loginTitleText = ""
--------------------------------------------
addEventHandler("accounts:login:request", getRootElement(), 
	function ()
		setPlayerHudComponentVisible("radar", false )
		setElementDimension ( getLocalPlayer(), 0 )
		setElementInterior( getLocalPlayer(), 0 )
		setElementPosition( getLocalPlayer(), -1619.0537109375, 766.33984375, 79.6875 )
		arkaplan = guiCreateStaticImage( 0, 0, sw, sh, "login-panel/background.png", false )
camera = {
	[1] = { 1515.1220703125, -885.1259765625, 70.603370666504, 1515.1220703125, -885.1259765625, 70.603370666504 },
	[2] = { 2174.9399414063, -1064.8714599609, 79.458114624023, 2085.4343261719, -1109.4544677734, 78.4111328125 },
	[3] = { 2088.4868164063, -1751.0032958984, 13.419298171997, 1991.2004394531, -1772.8931884766, 20.915758132935 },
	[4] = { 1393.1622314453, -1568.7086181641, 88.128997802734, 1456.677734375, -1637.5545654297, 53.114582061768 },
	[5] = { 46.309753417969, -1698.5400390625, 51.138675689697, 118.90101623535, -1766.6478271484, 41.555904388428 },
}
function rand_kamera()
	local rand = math.random(0, #camera)
	if rand ~= old then
		old_screen = rand
		return camera[ rand ]
	else
		return rand_kamera( old )
	end
end
local iCamera = 1
local dx = 0.0
setTimer(function()
    iCamera = math.random(0, #camera)
end, 800, 0)
function interpolateCam()
	dx = 1
	local ix, iy, iz = interpolateBetween(camera[iCamera][1], camera[iCamera][2], camera[iCamera][3], camera[iCamera][4], camera[iCamera][5], camera[iCamera][6], dx, "Linear")
	setCameraMatrix(ix, iy, iz, camera[iCamera][7], camera[iCamera][8], camera[iCamera][9] )
	removeEventHandler("onClientRender", root, interpolateCam)
end
addEventHandler("onClientRender", root, interpolateCam)
		
		
		
		--setCameraMatrix(1324.1245117188, -718.6396484375, 110.76223754883, 1341.3719482422, -817.13720703125, 109.88974761963)
		
		fadeCamera(true)
		guiSetInputEnabled(true)
		clearChat()
		triggerServerEvent("onJoin", getLocalPlayer())
		--LoginScreen_openLoginScreen()
	end
);
local sw, sh = guiGetScreenSize()
local fade = { }
local logoScale = 0.5
local logoSize = { sw*logoScale, sw*455/1920*logoScale }
local uFont
-- safakArkaPlan = guiCreateStaticImage( (sw-logoSize[1])/2, (sh-logoSize[2])/2-(logoSize[2]-50) , logoSize[1], logoSize[2], "login-panel/logo.png", false )	
-- guiSetAlpha (safakArkaPlan,0)
hareket = true 
logo = 0 
function logohareket()
	-- exports.prBlur:createBlur();
	-- if hareket == true then	
		-- logo = logo + 0.05
		-- if logo >= 1 then
			-- hareket = false
		-- end
	-- elseif hareket == false then
		-- logo = logo - 0.05
		-- if logo <= 0 then
		-- hareket = true
		-- end
	-- end
	if getElementData(getLocalPlayer(), "loggedin") == 1 then
		-- guiSetAlpha (safakArkaPlan,0)
	else
		local sign = dxCreateFont("fonts/sign.ttf", 11)
		-- guiSetAlpha (safakArkaPlan,255)
		--kullanici adi
		dxDrawImage(0, 0, sw, sh, "login-panel/background.png" )
		dxDrawRectangle(sw/2-88, sh/2+3, 218,5, tocolor(255, 255, 255, 255), true)--üst
		dxDrawRectangle(sw/2-88, sh/2+3, 5,27, tocolor(255, 255, 255, 255), true)--sol
		dxDrawRectangle(sw/2-88+213, sh/2+3, 5,27, tocolor(255, 255, 255, 255), true)--sağ
		dxDrawRectangle(sw/2-88, sh/2+29, 218,5, tocolor(255, 255, 255, 255), true)--alt
		
		--sifre
		dxDrawRectangle(sw/2-88, sh/2+52, 218,6, tocolor(255, 255, 255, 255), true)--üst
		dxDrawRectangle(sw/2-88, sh/2+52, 5,27, tocolor(255, 255, 255, 255), true)--sol
		dxDrawRectangle(sw/2-88+213, sh/2+52, 5,27, tocolor(255, 255, 255, 255), true)--sağ
		dxDrawRectangle(sw/2-88, sh/2+78, 218,5, tocolor(255, 255, 255, 255), true)--alt
		
		drawButton("Giriş Yap  ", sw/2-133, sh/2+154, 267, 30,"#2E2E2E", false, true, true, nil, true);
		drawButton("Kayıt Ol  ", sw/2-133, sh/2+194, 267, 30,"#2E2E2E", false, true, true, nil, true);
	end
end
--[[ LoginScreen_openLoginScreen( ) - Open the login screen ]]--
local wLogin, lUsername, tUsername, lPassword, tPassword, chkRememberLogin, bLogin, bRegister--[[, updateTimer]] = nil
local sx, sy = guiGetScreenSize()
local lx, ly = sx/2, sy/2
local black = tocolor(0,0,0,150)
local logoX, logoY ,logoW, logoH, logoSrc, logoA = lx-114/2, ly-62/2, 114, 62, "login-panel/logo.png", 0
local introX, introY, introW, introH, introC = lx-250/2, logoY + 60, 250, 20, tocolor(134,4,216,255)
local introV = 0
local logoScale = 0.5
local logoSize = { sx*logoScale, sx*455/1920*logoScale }
local gui = {}
function on_ekran()
 	dxDrawRectangle(introX, introY, introW, introH, black,true) 
   	dxDrawImage((sx-logoSize[1])/2, (sy-logoSize[2])/2-(logoSize[2]/2), logoSize[1], logoSize[2], logoSrc,0,0,0,tocolor(255,255,255,255), true)
   	duracak_durum = introW-2
   	if introV < 248 then
	   introV = introV+1
	end
   	dxDrawRectangle(introX+1, introY+1, introV, introH-2, introC, true)
end
local sifre_durum = 0
function LoginScreen_openLoginScreen(title)
	-- addEventHandler("onClientRender", getRootElement(), on_ekran)
	-- guiSetAlpha (safakArkaPlan,0)
	-- setTimer(function()
		-- removeEventHandler("onClientRender", getRootElement(), on_ekran)
		addEventHandler("onClientRender",root,logohareket)
		font = guiCreateFont("fonts/sign.ttf",12)
		guiSetInputEnabled(true)
		showChat(false)
		showCursor(true)
		if not title then
			local width, height = guiGetScreenSize()
			local logoW, logoH = 257, 120
			local logoPosX = width/2 - 130
			local logoPosY = height/2- 170
			
			x,y = guiGetScreenSize()
			local sWidths,sHeights = guiGetScreenSize() 
			local Width,Height = 271,60
			local X = (sw/2) - (Width/2)
			local Y = (sh/2) - (Height/2)
			

			--safakArkaPlan = guiCreateStaticImage(0.4450, 0.2900, 0.1100, 0.1900, "login-panel/logo.png", true)
			--guiSetEnabled (safakArkaPlan, false)
				
			login_main = guiCreateStaticImage( sw/2-133, sh/2, 267, 85, "login-panel/login_window.png", false )
			guiSetEnabled (login_main, false)
			tUsername = guiCreateEdit(sw/2-87, sh/2+4, 216,27, "", false)
			guiSetProperty(tUsername, "ActiveSelectionColour", "FF- ")
				guiSetFont(tUsername, font)
				guiEditSetMaxLength(tUsername, 32)
				addEventHandler("onClientGUIAccepted", tUsername, checkCredentials, false)
			tPassword = guiCreateEdit(sw/2-87, sh/2+54, 216,27, "", false)
			guiSetProperty(tPassword, "ActiveSelectionColour", "FF- ")
				guiSetFont(tPassword, font)
				guiEditSetMasked(tPassword, true)
				guiEditSetMaxLength(tPassword, 64)
				addEventHandler("onClientGUIAccepted", tPassword, checkCredentials, false)
			chkRememberLogin = guiCreateCheckBox(sw/2-133, sh/2+104, 140, 27, "Beni Hatırla", false, false)
			guiSetFont(chkRememberLogin, font)
			guiSetProperty (chkRememberLogin, "HoverTextColour", "FF000000")
			sifremiUnuttum= guiCreateLabel(sw/2+20, sh/2+104, 265,27,"Şifremi Unuttum",false,false)
			guiSetFont(sifremiUnuttum, font)
			--guiLabelSetHorizontalAlign( sifremiUnuttum, "right", true )
			addEventHandler( "onClientMouseEnter", sifremiUnuttum, 
				function(aX, aY)
					if source == sifremiUnuttum then
						guiLabelSetColor (sifremiUnuttum, 0, 0, 0)
					end
				end
			)
			addEventHandler( "onClientMouseLeave", sifremiUnuttum, 
				function(aX, aY)
					if source == sifremiUnuttum then
						guiLabelSetColor (sifremiUnuttum, 255, 255, 255)
					end
				end
			)
			addEventHandler("onClientGUIClick", sifremiUnuttum, 
			function() 
				if (source == sifremiUnuttum) then
					if sifre_durum == 0 then
						sifre_durum = 1
						local screenWidth, screenHeight = guiGetScreenSize()
						local windowWidth, windowHeight = 323, 133
						local left = screenWidth/2 - windowWidth/2
						local top = screenHeight/2 - windowHeight/2
						gui["_root"] = guiCreateWindow(15, top, windowWidth, windowHeight, "Şifremi Unuttum", false)
						guiWindowSetSizable(gui["_root"], false)
						gui["label"] = guiCreateLabel(9, 25, 121, 16, "Mail adresiniz:", false, gui["_root"])
						guiLabelSetHorizontalAlign(gui["label"], "left", false)
						guiLabelSetVerticalAlign(gui["label"], "center")
						gui["lineEdit"] = guiCreateEdit(9, 45, 300, 20, "", false, gui["_root"])
						guiEditSetMaxLength(gui["lineEdit"], 32767)
						gui["pushButton"] = guiCreateButton(10, 75, 145, 41, "Tamam", false, gui["_root"])
						gui["pushButton2"] = guiCreateButton(161, 75, 145, 41, "İptal", false, gui["_root"])
						addEventHandler("onClientGUIClick", getRootElement(), function() if (source == gui["pushButton2"]) then sifre_durum = 0 destroyElement(gui["_root"]) end end)
						addEventHandler("onClientGUIClick", getRootElement(), function() 
							if (source == gui["pushButton"]) then 
								local validEmail, reason = isEmail(guiGetText(gui["lineEdit"]))
								if not validEmail then
									guiSetText(gui["_root"], reason)
									playSoundFrontEnd ( 4 )
									return
								end
								kod_ekrani(guiGetText(gui["lineEdit"]))
							end 
						end)
					end
				end
			end)
			bLogin = guiCreateStaticImage(sw/2-133, sh/2+154, 267, 38, "login-panel/login.png", false)
			guiSetAlpha (bLogin,0)
				addEventHandler("onClientGUIClick", bLogin, checkCredentials, false)
				--addEventHandler("onClientMouseEnter", bLogin,checkLoginGiris)
				--addEventHandler("onClientMouseLeave", bLogin,checkLoginCikis)
			bRegister = guiCreateStaticImage(sw/2-133, sh/2+194, 267, 38, "login-panel/register.png", false)
			guiSetAlpha (bRegister,0)
				--addEventHandler("onClientMouseEnter", bRegister,checkUyeGiris)
				--addEventHandler("onClientMouseLeave", bRegister,checkUyeCikis)
				
				sound = playSound("srp.mp3", true)
				setSoundVolume(sound, 1)
				addEventHandler("onClientGUIClick", bRegister, LoginScreen_Register, false)
				guiSetText(tUsername, tostring( loadSavedData("username", "") ))
				local tHash = tostring( loadSavedData("hashcode", "") )
				guiSetText(tPassword,  tHash)
				if #tHash > 1 then
					guiCheckBoxSetSelected(chkRememberLogin, true)
				end
			newsTitle = getElementData(getResourceRootElement(), "news:title")
			newsText = getElementData(getResourceRootElement(), "news:text")
			newsAuthor = getElementData(getResourceRootElement(), "news:sub")
			addEventHandler("onClientRender", getRootElement(), showLoginTitle)
			triggerEvent("accounts:options:settings:updated", getLocalPlayer())
		else
			loginTitleText = title
			addEventHandler("onClientRender", getRootElement(), showLoginTitle)
		end
	-- end, 5500, 1)
end
addEvent("beginLogin", true)
addEventHandler("beginLogin", getRootElement(), LoginScreen_openLoginScreen)

function kod_ekrani(mail)
	destroyElement(gui["_root"]) 
	local kod = math.random (0, 9) .. "" .. math.random (0, 9) .. "" .. math.random (0, 9) .. "" .. math.random (0, 9) .. "" .. math.random (0, 9) .. "" .. math.random (0, 9)
	triggerServerEvent("account:mail_call", getLocalPlayer(), mail, kod)
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 323, 133
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root"] = guiCreateWindow(15, top, windowWidth, windowHeight, "Şifremi Unuttum", false)
	guiWindowSetSizable(gui["_root"], false)
	gui["label"] = guiCreateLabel(9, 25, 250, 16, "Mail adresinize gelen 6 haneli kodu girin.", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["label"], "left", false)
	guiLabelSetVerticalAlign(gui["label"], "center")
	gui["lineEdit"] = guiCreateEdit(9, 45, 300, 20, "", false, gui["_root"])
	guiEditSetMaxLength(gui["lineEdit"], 32767)
	gui["pushButton"] = guiCreateButton(10, 75, 145, 41, "Tamam", false, gui["_root"])
	gui["pushButton2"] = guiCreateButton(161, 75, 145, 41, "İptal", false, gui["_root"])
	addEventHandler("onClientGUIClick", getRootElement(), function() if (source == gui["pushButton2"]) then sifre_durum = 0 destroyElement(gui["_root"]) end end)
	addEventHandler("onClientGUIClick", getRootElement(), function() 
		if (source == gui["pushButton"]) then 
			if guiGetText(gui["lineEdit"]) == kod then
				sifre_degistir(mail)
			else
				guiSetText(gui["_root"], "Yanlış kod girdiniz.")
			end
		end 
	end)
end

function sifre_degistir(mail)
	destroyElement(gui["_root"])
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 323, 202
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root"] = guiCreateWindow(15, top, windowWidth, windowHeight, "Şifrenizi Yenileyin", false)
	guiWindowSetSizable(gui["_root"], false)
	gui["label"] = guiCreateLabel(10, 25, 121, 16, "Şifre:", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["label"], "left", false)
	guiLabelSetVerticalAlign(gui["label"], "center")
	
	gui["lineEdit_2"] = guiCreateEdit(9, 45, 300, 20, "", false, gui["_root"])
	guiEditSetMaxLength(gui["lineEdit_2"], 32767)
	gui["lineEdit_3"] = guiCreateEdit(10, 95, 300, 20, "", false, gui["_root"])
	guiEditSetMaxLength(gui["lineEdit_3"], 32767)
	gui["label_2"] = guiCreateLabel(10, 75, 121, 16, "Şifre Tekrar:", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["label_2"], "left", false)
	guiLabelSetVerticalAlign(gui["label_2"], "center")
	gui["pushButton3"] = guiCreateButton(10, 145, 145, 41, "Tamam", false, gui["_root"])
	gui["pushButton4"] = guiCreateButton(161, 145, 145, 41, "İptal", false, gui["_root"])
	addEventHandler("onClientGUIClick", getRootElement(), function() if (source == gui["pushButton4"]) then sifre_durum = 0 destroyElement(gui["_root"]) end end)
	addEventHandler("onClientGUIClick", getRootElement(), function() 
		if (source == gui["pushButton3"]) then 
			if not (guiGetText(gui["lineEdit_2"]) == guiGetText(gui["lineEdit_3"])) then guiSetText(gui["_root"], "Şifreler eşleşmiyor.") return end
			if (string.len(guiGetText(gui["lineEdit_3"]))<6) then
				guiSetText(gui["_root"], "Şifreniz minimum 6 karakter olmalıdır.")
				return
			elseif (string.len(guiGetText(gui["lineEdit_3"]))>=30) then
				guiSetText(gui["_root"], "Şifreniz maksimum 30 karakter olmalıdır.")
				return
			elseif (string.find(guiGetText(gui["lineEdit_3"]), ";", 0)) or (string.find(guiGetText(gui["lineEdit_3"]), "'", 0)) or (string.find(guiGetText(gui["lineEdit_3"]), "@", 0)) or (string.find(guiGetText(gui["lineEdit_3"]), ",", 0)) then
				guiSetText(gui["_root"], "Şifrenizde ;,@' karakterleri bulunmamalı")
				return
			end
			sifre_durum = 0
			triggerServerEvent("account:sifre_guncelle", getLocalPlayer(), mail, guiGetText(gui["lineEdit_3"]))
			guiSetText(gui["_root"], "Şifreniz güncelleniyor..")
			destroyElement(gui["_root"])
		end 
	end)
end
function mail_ekle()
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 310, 152
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root_mail"] = guiCreateWindow(left, top, windowWidth, windowHeight, "Mail adresinizi girin", false)
	guiWindowSetSizable(gui["_root_mail"], false)
	
	gui["label"] = guiCreateLabel(10, 25, 290, 35, "Lütfen aktif olarak kullandığınız bir mail adresi girin, \naksi takdirde şifre değişimlerinde sorun yaşarsınız.", false, gui["_root_mail"])
	guiLabelSetHorizontalAlign(gui["label"], "left", false)
	gui["TXTMail"] = guiCreateEdit(10, 60, 290, 31, "", false, gui["_root_mail"])
	gui["pushButton"] = guiCreateButton(10, 100, 290, 41, "Tamamla", false, gui["_root_mail"])
	addEventHandler("onClientGUIClick", getRootElement(), function() 
		if (source == gui["pushButton"]) then 
			local mail, reason = isEmail(guiGetText(gui["TXTMail"]))
			if not mail then
				guiSetText(gui["_root_mail"], reason)
				playSoundFrontEnd ( 4 )
				return
			end
			triggerServerEvent("account:mail_guncelle", getLocalPlayer(), getLocalPlayer(), guiGetText(gui["TXTMail"]))
			showCursor(false)
			destroyElement(gui["_root_mail"])
		end
	end)
end
addCommandHandler("mailguncelle", mail_ekle)
addEvent("account:mailekrani", true)
addEventHandler("account:mailekrani", getRootElement(), mail_ekle)
function isEmail(str)
	if not str or str == "" or string.len(str) < 1 then
		return false, "Mail adresini boş girmeyiniz."
	end

	local _,nAt = str:gsub('@','@') -- Counts the number of '@' symbol
	
	if nAt ~=1 then 
		return false, "Mail adresiniz @ karakteri içermeli."
	end

	if str:len() > 100 then
		return false, "Mail adresiniz 100 karakterden uzun olmamalı."
	end

	--[[local text = exports.global:explode('@', str) 
	local localPart = text[1]
	local domainPart = text[2]
	if not localPart or not domainPart then 
		return false, "Mail adresinizin yerel veya alan adı parçası eksik." 
	end

	if hasSpecialChars(localPart) then
		return false, "Mail adresinizin yerel kısmı geçersiz." 
	end

	if hasSpecialChars(domainPart) then
		return false, "Mail adresinizin alan adı kısmı geçersiz." 
	end]]

	return true, "Mail adresi geçerli."
end
function dxDrawRectangleBordered(startX, startY, width, height, bgColor, slotColor, index)
	dxDrawRectangle(startX, startY, width, height, slotColor,index)
	dxDrawRectangle(startX - 1, startY + 1, 1, height - 2, bgColor,index)
	dxDrawRectangle(startX + width, startY + 1, 1, height - 2, bgColor,index)
	dxDrawRectangle(startX + 1, startY - 1, width - 2, 1, bgColor,index)
	dxDrawRectangle(startX + 1, startY + height, width - 2, 1, bgColor,index)
end

function checkLoginGiris ()
	guiSetAlpha(bLogin, 0.75)
end

function checkLoginCikis ()
	guiSetAlpha(bLogin, 1)
end

function checkUyeGiris ()
	guiSetAlpha(bRegister, 0.75)
end

function checkUyeCikis ()
	guiSetAlpha(bRegister, 1)
end

function showLoginTitle()
	local screenX, screenY = guiGetScreenSize()
	local alphaAction = 3
	local alphaStep = 50
	local alphaAction = 3
	local alphaStep = 50
	local sWidth,sHeight = guiGetScreenSize()
	if loginTitleText == "Banlandın." then
		dxDrawText(loginTitleText,(700/1600)*sWidth, (350/900)*sHeight, (900/1600)*sWidth, (450/900)*sHeight, tocolor(255,0,0,255), (sWidth/1600)*2, "default-bold","center","center",false,false,false)
	else
		dxDrawText(loginTitleText,(700/1600)*sWidth, (350/900)*sHeight, (900/1600)*sWidth, (450/900)*sHeight, tocolor(255,255,255,255), (sWidth/1600)*2, "default-bold","center","center",false,false,false)
	end
	alphaStep = alphaStep + alphaAction
	if (alphaStep > 200) or (alphaStep < 50) then
		alphaAction = alphaAction - alphaAction - alphaAction
	end
	--dxDrawRectangle( (10/1600)*sWidth, (17/900)*sHeight, (400/1600)*sWidth, (600/900)*sHeight, tocolor(0, 0, 0, 150))
	--dxDrawText( newsTitle, (35/1600)*sWidth, (30/900)*sHeight, (375/1600)*sWidth, (550/900)*sHeight, tocolor ( 255, 255, 255, 255 ), 1.5, "default-bold" )
	--dxDrawText( "     " .. newsAuthor, (80/1600)*sWidth, (60/900)*sHeight, sWidth, sHeight, tocolor ( 255, 255, 255, 255 ), 1.2, "default-bold", "left", "top", true, false )
	--dxDrawText( newsText, (35/1600)*sWidth, (92/900)*sHeight, (375/1600)*sWidth, sHeight,  tocolor ( 255, 255, 255, 255 ), 1, "default-bold", "left", "top", true, true )
end

function LoginScreen_Register()
	local username = guiGetText(tUsername)
	local password = guiGetText(tPassword)
	if (string.len(username)<3) then
		LoginScreen_showWarningMessage( "Kullanıcı Adınız Çok Kısa. Minimum 3 Karakter Girmelisiniz." )
	elseif (string.find(username, ";", 0)) or (string.find(username, "'", 0)) or (string.find(username, "@", 0)) or (string.find(username, ",", 0)) or (string.find(username, " ", 0)) then
		LoginScreen_showWarningMessage("Kullanıcı Adınızda ;,@.' veya boşluk Bulunamaz!")
	elseif (string.len(password)<6) then
	    LoginScreen_showWarningMessage("Şifreniz Çok Kısa. \n 6 veya Daha Fazla Karakter Girmelisiniz.", 255, 0, 0)
    elseif (string.len(password)>=30) then
        LoginScreen_showWarningMessage("Şifreniz Çok Uzun. \n 30 Karakterden Fazla Yazamazsınız.", 255, 0, 0)
    elseif (string.find(password, ";", 0)) or (string.find(password, "'", 0)) or (string.find(password, "@", 0)) or (string.find(password, ",", 0)) then
        LoginScreen_showWarningMessage("Şifrenizde ;,@.' Karakterleri Bulunamaz!", 255, 0, 0)
	else
		showChat(true)
		triggerServerEvent("accounts:register:attempt", getLocalPlayer(), username, password)
	end
end

function LoginScreen_RefreshIMG()
	currentslide =  currentslide + 1
	if currentslide > totalslides then
		currentslide = 1
	end
end

--[[ LoginScreen_closeLoginScreen() - Close the loginscreen ]]
function LoginScreen_closeLoginScreen()
	destroyElement(login_main)
	destroyElement(tUsername)
	destroyElement(tPassword)
	destroyElement(sifremiUnuttum)
	destroyElement(chkRememberLogin)
	destroyElement(bLogin)
	destroyElement(bRegister)
	destroyElement(iLogo)
	-- destroyElement(safakArkaPlan)
	showChat(true)
	removeEventHandler("onClientRender", root, interpolateCam)
	removeEventHandler("onClientRender", root, logohareket)
		stopSound( sound )
	--destroyElement(wLogin)
	--killTimer(updateTimer)
	removeEventHandler( "onClientRender", getRootElement(), showLoginTitle )
end

--[[ checkCredentials() - Used to validate and send the contents of the login screen  ]]--
function checkCredentials()
	local username = guiGetText(tUsername)
	local password = guiGetText(tPassword)
	guiSetText(tPassword, "")
	appendSavedData("hashcode", "")
	if (string.len(username)<3) then
		outputChatBox("Kullanıcı Adınız Çok Kısa. Minimum 3 Karakter Girmelisiniz.", 255, 0, 0)
	else
		local saveInfo = guiCheckBoxGetSelected(chkRememberLogin)
		triggerServerEvent("accounts:login:attempt", getLocalPlayer(), username, password, saveInfo) 
		--playSound("lioneffect.mp3")
					
		if (saveInfo) then
			appendSavedData("username", tostring(username))
		else
			appendSavedData("username", "")
		end
	end
end

local warningBox, warningMessage, warningOk = nil
function LoginScreen_showWarningMessage( message )

	if (isElement(warningBox)) then
		destroyElement(warningBox)
	end
	
	local x, y = guiGetScreenSize()
	warningBox = guiCreateWindow( x*.5-150, y*.5+120, 300, 120, "Dikkat!", false )
	guiWindowSetSizable( warningBox, false )
	warningMessage = guiCreateLabel( 40, 30, 220, 60, message, false, warningBox )
	guiLabelSetHorizontalAlign( warningMessage, "center", true )
	guiLabelSetVerticalAlign( warningMessage, "center" )
	warningOk = guiCreateButton( 130, 90, 70, 20, "Tamam", false, warningBox )
	addEventHandler( "onClientGUIClick", warningOk, function() destroyElement(warningBox) end )
	guiBringToFront( warningBox )
end
addEventHandler("accounts:error:window", getRootElement(), LoginScreen_showWarningMessage)

function defaultLoginText()
	loginTitleText = ""
end

addEventHandler("accounts:login:attempt", getRootElement(), 
	function (statusCode, additionalData)
		
		if (statusCode == 0) then
			LoginScreen_closeLoginScreen()
			
			if (isElement(warningBox)) then
				destroyElement(warningBox)
			end
			
			-- Succesful login
			for _, theValue in ipairs(additionalData) do
				setElementData(getLocalPlayer(), theValue[1], theValue[2], false)
			end
			
			local newAccountHash = getElementData(getLocalPlayer(), "account:newAccountHash")
			appendSavedData("hashcode", newAccountHash or "")
			
			local characterList = getElementData(getLocalPlayer(), "account:characters")
			
			if #characterList == 0 then
				newCharacter_init()
			else
				Characters_showSelection()
			end
			
		elseif (statusCode > 0) and (statusCode < 5) then
			LoginScreen_showWarningMessage( additionalData )
		elseif (statusCode == 5) then
			LoginScreen_showWarningMessage( additionalData )
			-- TODO: show make app screen?
		end
	end
)