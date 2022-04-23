rFontColorVehWhite, rFontColorProWhite = nil

function options_enable()
	toggleControl("change_camera", false)
	
	keys = getBoundKeys("change_camera")
	for name, state in pairs(keys) do
		if ( name ~= "home" ) then
			bindKey(name, "down", options_cameraWorkAround)
		else
			unbindKey(name)
		end
	end
	
	addCommandHandler("home", options_showmenu)
	bindKey("F10", "down", "home")
end
addEventHandler("accounts:options",getRootElement(),options_enable)

function options_disable()
	removeCommandHandler("home", options_showmenu)
	unbindKey("home", "down", "home")
	unbindKey("F10", "down", "home")
end

local wOptions,bChangeCharacter,bStreamerSettings,bGraphicsSettings,bAccountSettings,bLogout = nil
local wGraphicsMenu,cLogsEnabled,cMotionBlur,cSkyClouds,cStreamingAudio,bGraphicsMenuClose,sVehicleStreamer,sPickupStreamer,lVehicleStreamer,lPickupStreamer,gameMenuLoaded = nil

function isCameraOnPlayer()
	local vehicle = getPedOccupiedVehicle(getLocalPlayer())
	if vehicle then
		return getCameraTarget( ) == vehicle
	else
		return getCameraTarget( ) == getLocalPlayer()
	end
end

function options_showmenu()
	if wOptions then
		options_closemenu()
		return
	end
	
	if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
		return
	end
	setElementData(getLocalPlayer(), "exclusiveGUI", true, false)
	triggerEvent("onSapphireXMBShow", getLocalPlayer())
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 254, 173
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	
	showCursor(true)
	
	wOptions = guiCreateWindow(left, top, windowWidth, windowHeight, "Ayarlar - F10", false)
	guiWindowSetSizable(wOptions, false)
	
	bChangeCharacter = guiCreateButton(10, 30, 231, 23, "Karakter Değiştir", false, wOptions)
	guiSetFont(bChangeCharacter, "default-bold-small")
	addEventHandler("onClientGUIClick", bChangeCharacter,
		function ()
			if not isPedDead ( getLocalPlayer() ) and isCameraOnPlayer() then
				triggerServerEvent()
				options_logOut( )
			end
			options_closemenu()
		end, false)
	
	bGraphicsSettings = guiCreateButton(10, 65, 231, 23, "Oyun Ayarları", false, wOptions)
	guiSetFont(bGraphicsSettings, "default-bold-small")
	addEventHandler("onClientGUIClick", bGraphicsSettings, options_opengraphicsmenu, false)
	--bAccountSettings = guiCreateButton(10, 105, 231, 23, "Account settings", false, wOptions)
	--bLogout = guiCreateButton(10, 145, 231, 23, "Çıkış Yap", false, wOptions)
	--guiSetFont(bLogout, "default-bold-small")
	marketBTN = guiCreateButton(10, 100, 231, 23, "Market", false, wOptions)
	bClose = guiCreateButton(10, 135, 231, 23, "Kapat", false, wOptions)
	guiSetFont(bClose, "default-bold-small")
	addEventHandler("onClientGUIClick", marketBTN, function()
		destroyElement(wOptions)
		executeCommandHandler ( "market", thePlayer )
	end, false)
	addEventHandler("onClientGUIClick", bClose, options_closemenu, false)
	triggerEvent("hud:convertUI", getLocalPlayer(), wOptions)
end

function options_closemenu()
	if (wGraphicsMenu) then
		options_closegraphicsmenu()
	end
	
	showCursor(false)
	if wOptions then
		destroyElement(wOptions)
		wOptions = nil
	end
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end

function options_cameraWorkAround()
	--setControlState("change_camera", true)
end


--MAXIME
function options_opengraphicsmenu()
	gameMenuLoaded = false
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 200, 350+17
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	local enable = 1
	
	guiSetEnabled(wOptions, false)
	
	wGraphicsMenu = guiCreateWindow(left, top, windowWidth, windowHeight, "Oyun Secenekleri", false)
	guiWindowSetSizable(wGraphicsMenu, false)
	----------
	
	cMotionBlur = guiCreateCheckBox(10, 25, 180, 17, "Motion Blur'u Aktifleştir", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cMotionBlur, options_updateGameConfig)
	-----------
	cSkyClouds = guiCreateCheckBox(10, 45, 180, 17, "Blutları Göster", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cSkyClouds, options_updateGameConfig)
	------------
	cStreamingAudio = guiCreateCheckBox(10, 65, 180, 17, "Çevre Seslerini Etkinleştir", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cStreamingAudio, options_updateGameConfig)
	
	bOverlayDescription = guiCreateButton ( 10, 85, 180, 17*2, "Ek Açıklama Seçenekleri", false, wGraphicsMenu )
	addEventHandler("onClientGUIClick", bOverlayDescription, overlayDescSettings)
	
	--[[lVehicleStreamer = guiCreateCheckBox ( 10, 95, 180, 17, "Vehicle streamer: Disabled", false, false, wGraphicsMenu )
	addEventHandler("onClientGUIClick", lVehicleStreamer, options_updateGameConfig)
	
	sVehicleStreamer = guiCreateScrollBar(10, 110, 180, 17, true, false, wGraphicsMenu)
	addEventHandler("onClientGUIScroll", sVehicleStreamer, options_GameConfig_updateScrollbars)
	
	lPickupStreamer = guiCreateCheckBox ( 10, 125, 180, 17, "Interior streamer: Disabled", false, false, wGraphicsMenu )
	addEventHandler("onClientGUIClick", lPickupStreamer, options_updateGameConfig)
	
	sPickupStreamer = guiCreateScrollBar(10, 140, 180, 17, true, false, wGraphicsMenu)
	addEventHandler("onClientGUIScroll", sPickupStreamer, options_GameConfig_updateScrollbars)]]
	
	CHCGuiGorunum = guiCreateCheckBox(10, 140, 180, 17, "Yeni GUI Görünümü", false, false, wGraphicsMenu)
	if getResourceFromName("safakroleplay-interface-sistemi") then
		local durum = getElementData(getLocalPlayer(), "guigorunum") or "1"
		if durum == "1" then
			guiCheckBoxSetSelected(CHCGuiGorunum,true)
		else
			guiCheckBoxSetSelected(CHCGuiGorunum,false)
		end
	else
		guiSetEnabled(CHCGuiGorunum, false)
	end
	addEventHandler("onClientGUIClick", CHCGuiGorunum, options_updateGameConfig)
	cLogsEnabled = guiCreateCheckBox(10, 160, 180, 17, "Sohbet Günlüğü", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cLogsEnabled, options_updateGameConfig)
	
	cBubblesEnabled = guiCreateCheckBox(10, 180, 180, 17, "Sohbet Balonunu Göster", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cBubblesEnabled, options_updateGameConfig)
	
	cIconsEnabled = guiCreateCheckBox(10, 200, 180, 17, "Yazma İşaretleri Göster", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cIconsEnabled, options_updateGameConfig)
	
	cEnableNametags = guiCreateCheckBox(10, 220, 180, 17, "isimleri yazan etiketler etkinleştirme", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cEnableNametags, options_updateGameConfig)
	
	cEnableRShaders = guiCreateCheckBox(10, 240, 180, 17, "Radar Gölgesini Göster", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cEnableRShaders, options_updateGameConfig)
	
	cEnableWShaders = guiCreateCheckBox(10, 260, 180, 17, "Su Gölgesini Göster", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cEnableWShaders, options_updateGameConfig)
	
	cEnableVShaders = guiCreateCheckBox(10, 280, 180, 17, "Araç Gölgesini Göster", false, false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", cEnableVShaders, options_updateGameConfig)
	
	--[[
	chatbubbles
	]]

	-- Put the current settings selected/active
	
	--[[local vehicleStreamerEnabled = tonumber( loadSavedData("streamer-vehicle-enabled", "1") )
	if (vehicleStreamerEnabled) then
		guiCheckBoxSetSelected ( lVehicleStreamer, true )
	end
	
	local pickupStreamerEnabled = tonumber( loadSavedData("streamer-pickup-enabled", "1") )
	if (pickupStreamerEnabled) then
		guiCheckBoxSetSelected ( lPickupStreamer, true )
	end]]
	
	local blurEnabled = tonumber( loadSavedData("motionblur", "1") )
	if (blurEnabled == 1) then
		guiCheckBoxSetSelected ( cMotionBlur, true )
	end

	
	local skyCloudsEnabled = tonumber( loadSavedData("skyclouds", "1") )
	if (skyCloudsEnabled == 1) then
		guiCheckBoxSetSelected ( cSkyClouds, true )
	end 
	
	local streamingMediaEnabled = tonumber( loadSavedData("streamingmedia", "1") )
	if (streamingMediaEnabled == 1) then
		guiCheckBoxSetSelected ( cStreamingAudio, true )
	end
	
	local logsEnabled = tonumber( loadSavedData("logsenabled", "1") )
	if (logsEnabled == 1) then
		guiCheckBoxSetSelected ( cLogsEnabled, true )
	end
	
	--[[local vehicleStreamerStatus = tonumber( loadSavedData("streamer-vehicle", "60") )
	if (vehicleStreamerStatus) then
		guiScrollBarSetScrollPosition(sVehicleStreamer, ((vehicleStreamerStatus-40)/2))
	end
	
	local pickupStreamerStatus = tonumber( loadSavedData("streamer-pickup", "25") )
	if (pickupStreamerStatus) then
		guiScrollBarSetScrollPosition(sPickupStreamer, (pickupStreamerStatus-10))
	end]]
	
	local isBubblesEnabled = tonumber( loadSavedData("chatbubbles", "1") )
	if (isBubblesEnabled == 1) then
		guiCheckBoxSetSelected ( cBubblesEnabled, true )
	end 
	
	local isChatIconsEnabled = tonumber( loadSavedData("chaticons", "1") )
	if (isChatIconsEnabled == 1) then
		guiCheckBoxSetSelected ( cIconsEnabled, true )
	end 
	
	local isNameTagsEnabled = tonumber( loadSavedData("shownametags", "1") )
	if (isNameTagsEnabled == 1) then
		guiCheckBoxSetSelected ( cEnableNametags, true )
	end 
	
	local isRShaderEnabled = tonumber( loadSavedData( "enable_radar_shader", "1") )
	if isRShaderEnabled == 1 then
		guiCheckBoxSetSelected ( cEnableRShaders, true )
	end
	
	local isWShaderEnabled = tonumber( loadSavedData( "enable_water_shader", "1") )
	if isWShaderEnabled == 1 then
		guiCheckBoxSetSelected ( cEnableWShaders, true )
	end
	
	local isVShaderEnabled = tonumber( loadSavedData( "enable_vehicle_shader", "1") )
	if isVShaderEnabled == 1 then
		guiCheckBoxSetSelected ( cEnableVShaders, true )
	end

	gameMenuLoaded = true
	--options_GameConfig_updateScrollbars()
	
	bGraphicsMenuClose = guiCreateButton(10, 320, 490, 17*2, "Kapat", false, wGraphicsMenu)
	addEventHandler("onClientGUIClick", bGraphicsMenuClose, options_closegraphicsmenu, false)
end

--[[function options_GameConfig_updateScrollbars()
	if (gameMenuLoaded) then
		local vehicleStreamerStatus = guiScrollBarGetScrollPosition(sVehicleStreamer)
		vehicleStreamerStatus = ((vehicleStreamerStatus) * 2) + 40
		
		local pickupStreamerStatus = guiScrollBarGetScrollPosition(sPickupStreamer)
		pickupStreamerStatus = pickupStreamerStatus + 10
		
		guiSetText(lVehicleStreamer, "Vehicle streamer: "..vehicleStreamerStatus.." meter")
		guiSetText(lPickupStreamer, "Interior streamer: "..pickupStreamerStatus.." meter")
		
		appendSavedData("streamer-vehicle", tostring(vehicleStreamerStatus))
		appendSavedData("streamer-pickup", tostring(pickupStreamerStatus))
		
		triggerEvent("accounts:options:settings:updated", getLocalPlayer())
	end
end]]

--MAXIME
function overlayDescSettings(button, state)
	if source == bOverlayDescription then
		if wOverlayDescSettings then
			fCloseOverlayDescSettings()
		else
			
			local screenWidth, screenHeight = guiGetScreenSize()
			local windowWidth, windowHeight = 350, 40+(20*15)
			local left = screenWidth/2 - windowWidth/2
			local top = screenHeight/2 - windowHeight/2
			local enable = 1
			
			guiSetEnabled(wOptions, false)
			guiSetEnabled(wGraphicsMenu, false)
			
			wOverlayDescSettings = guiCreateWindow(left, top, windowWidth, windowHeight, "Ek Aciklama Secenekleri", false)
			guiWindowSetSizable(wOverlayDescSettings, false)
			----------
			local y = 0
			local lane1w = 270
			local lane1x = 10
			local lane2w = lane1w + lane1x
			local lane2x = lane1x*2 + lane1w
			cEnableDescription = guiCreateCheckBox(10, 25+y, lane1w, 17, "Tum Ek Aciklamalari etkinlestir", true, false, wOverlayDescSettings)
			addEventHandler("onClientGUIClick", cEnableDescription, options_updateGameConfig)
			enable = tonumber( loadSavedData("enableOverlayDescription", "1") or 1)
			guiCheckBoxSetSelected ( cEnableDescription, enable == 1 and true or false)
			guiCreateStaticImage ( 10, 25+y+23, windowWidth-20 , 1, ":admin-system/images/whitedot.jpg", false, wOverlayDescSettings )
			y = y + 30
			
			cEnableDescriptionVeh = guiCreateCheckBox(10, 25+y, lane1w, 17, "Ek Aciklamalari etkinlestir (Arac)", true, false, wOverlayDescSettings)
			addEventHandler("onClientGUIClick", cEnableDescriptionVeh, options_updateGameConfig)
			enable = tonumber( loadSavedData("enableOverlayDescriptionVeh", "1") or 1 )
			guiCheckBoxSetSelected ( cEnableDescriptionVeh, enable == 1 and true or false)
			
			cEnableDescriptionVehPin = guiCreateCheckBox(lane2x, 25+y, lane2w, 17, "Pin", false, false, wOverlayDescSettings)
			addEventHandler("onClientGUIClick", cEnableDescriptionVehPin, options_updateGameConfig)
			enable = tonumber( loadSavedData("enableOverlayDescriptionVehPin", "1") or 1 )
			guiCheckBoxSetSelected ( cEnableDescriptionVehPin, enable == 1 and true or false)
			
			y = y + 20
			
			lFontVeh = guiCreateLabel ( 10, 25+y+3, 40, 20,  "Font:", false, wOverlayDescSettings )
			cFontVeh = guiCreateComboBox ( 10+40, 25+y, lane1w, 20,  loadSavedData2("cFontVeh") or "default", false, wOverlayDescSettings )
			local count1 = 0 
			for key, font in pairs(exports["titan_description"]:getOverLayFonts()) do
				guiComboBoxAddItem(cFontVeh, type(font[1]) == "string" and font[1] or "BizNoteFont18")
				count1 = count1 + 1
			end
			guiComboBoxAdjustHeight ( cFontVeh, count1 )
			addEventHandler ( "onClientGUIComboBoxAccepted", guiRoot,
				function ( comboBox )
					if ( comboBox == cFontVeh ) then
						local item = guiComboBoxGetSelected ( cFontVeh )
						local text = tostring ( guiComboBoxGetItemText ( cFontVeh , item ) )
						if ( text ~= "" ) then
							 appendSavedData("cFontVeh", text)
						end
					end
				end
			)
			
			y = y + 20 + 5
			
			local radioLabelWidth = 150
			lFontColorVeh = guiCreateLabel ( 10, 25+y+3, radioLabelWidth, 20,  "Font Renk:", false, wOverlayDescSettings )
			rFontColorVehWhite = guiCreateCheckBox ( 10+radioLabelWidth, 25+y, radioLabelWidth, 20, "Enable White Font",true, false, wOverlayDescSettings)
			if loadSavedData("rFontColorVehWhite", "1") == "1" then
				guiCheckBoxSetSelected ( rFontColorVehWhite, true)
			end
			
			addEventHandler("onClientGUIClick", rFontColorVehWhite, options_updateGameConfig)
			
			y = y + 20
			
			bgVeh = guiCreateCheckBox ( 10, 25+y+3, 150, 17,  "Enable Background", true, false, wOverlayDescSettings )
			enable = tonumber( loadSavedData("bgVeh", "1") or 1 )
			guiCheckBoxSetSelected ( bgVeh, enable == 1 and true or false)
			
			borderVeh = guiCreateCheckBox ( 10+150, 25+y+3, 150, 17, "Enable Border", true, false, wOverlayDescSettings )
			enable = tonumber( loadSavedData("borderVeh", "1") or 1)
			guiCheckBoxSetSelected ( borderVeh, enable == 1 and true or false)
			
			addEventHandler("onClientGUIClick", bgVeh, options_updateGameConfig)
			addEventHandler("onClientGUIClick", borderVeh, options_updateGameConfig)
			
			guiCreateStaticImage ( 10, 25+y+21, windowWidth-20 , 1, ":admin-system/images/whitedot.jpg", false, wOverlayDescSettings )
			
			y = y + 40
			
			cEnableOverlayDescriptionPro = guiCreateCheckBox(10, 25+y, lane1w, 17, "Enable Overlay Description (Property)", true, false, wOverlayDescSettings)
			addEventHandler("onClientGUIClick", cEnableOverlayDescriptionPro, options_updateGameConfig)
			enable = tonumber( loadSavedData("enableOverlayDescriptionPro", "1") or 1 )
			guiCheckBoxSetSelected ( cEnableOverlayDescriptionPro, enable == 1 and true or false)
			
			cEnableOverlayDescriptionProPin = guiCreateCheckBox(lane2x, 25+y, lane2w, 17, "Pin", false, false, wOverlayDescSettings)
			addEventHandler("onClientGUIClick", cEnableOverlayDescriptionProPin, options_updateGameConfig)
			enable = tonumber( loadSavedData("enableOverlayDescriptionProPin", "1") or 1 )
			guiCheckBoxSetSelected ( cEnableOverlayDescriptionProPin, enable == 1 and true or false)
			
			y = y + 20
			
			lFontPro = guiCreateLabel ( 10, 25+y+3, 40, 20,  "Font:", false, wOverlayDescSettings )
			cFontPro = guiCreateComboBox ( 10+40, 25+y, lane1w, 20,  loadSavedData2("cFontPro") , false, wOverlayDescSettings )
			for key, font in pairs(exports["titan_description"]:getOverLayFonts()) do
				guiComboBoxAddItem(cFontPro, type(font[1]) == "string" and font[1] or "BizNoteFont18")
			end
			guiComboBoxAdjustHeight ( cFontPro, count1 )
			addEventHandler ( "onClientGUIComboBoxAccepted", guiRoot,
				function ( comboBox )
					if ( comboBox == cFontPro ) then
						local item = guiComboBoxGetSelected ( cFontPro )
						local text = tostring ( guiComboBoxGetItemText ( cFontPro , item ) )
						if ( text ~= "" ) then
							appendSavedData("cFontPro", text)
						end
					end
				end
			)
			
			y = y + 20 + 5
			
			lFontColorPro = guiCreateLabel ( 10, 25+y+3, radioLabelWidth, 20,  "Font Renk:", false, wOverlayDescSettings )
			rFontColorProWhite = guiCreateCheckBox ( 10+radioLabelWidth, 25+y, radioLabelWidth, 20, "Enable White Font", true,false, wOverlayDescSettings)
			if loadSavedData("rFontColorProWhite", "1") == "1" then
				guiCheckBoxSetSelected ( rFontColorProWhite, true)
			end
			
			addEventHandler("onClientGUIClick", rFontColorProWhite, options_updateGameConfig)
			
			y = y + 20
			
			bgPro = guiCreateCheckBox ( 10, 25+y+3, 150, 17,  "Enable Background", true, false, wOverlayDescSettings )
			enable = tonumber( loadSavedData("bgPro", "1") or 1 )
			guiCheckBoxSetSelected ( bgPro, enable == 1 and true or false)
			
			borderPro = guiCreateCheckBox ( 10+150, 25+y+3, 150, 17, "Enable Border", true,false,  wOverlayDescSettings )
			enable = tonumber( loadSavedData("borderPro", "1") or 1 )
			guiCheckBoxSetSelected ( borderPro, enable == 1 and true or false)
			
			addEventHandler("onClientGUIClick", bgPro, options_updateGameConfig)
			addEventHandler("onClientGUIClick", borderPro, options_updateGameConfig)
		
			guiCreateStaticImage ( 10, 25+y+21, windowWidth-20 , 1, ":admin-system/images/whitedot.jpg", false, wOverlayDescSettings )
			
			y = y + 40
			
			bCloseOverlayDescSettings = guiCreateButton(10, 70+y, windowWidth+34, 17*2, "Close", false, wOverlayDescSettings)
			addEventHandler("onClientGUIClick", bCloseOverlayDescSettings, fCloseOverlayDescSettings, false)
			addEventHandler("onClientGUIClick", bCloseOverlayDescSettings, options_updateGameConfig)
		end
	end
end
 
--MAXIME--
function options_updateGameConfig() 
	if source == rFontColorVehWhite then
		if guiCheckBoxGetSelected(rFontColorVehWhite) then
			appendSavedData("rFontColorVehWhite", "1")
		else
			appendSavedData("rFontColorVehWhite", "0")
		end
	end
	
	if source == rFontColorProWhite then
		if guiCheckBoxGetSelected(rFontColorProWhite) then
			appendSavedData("rFontColorProWhite", "1")
		else
			appendSavedData("rFontColorProWhite", "0")
		end
	end
	
	if source == borderVeh then
		appendSavedData("borderVeh", guiCheckBoxGetSelected(borderVeh) and "1" or "0")
	end
	
	if source == bgVeh then
		appendSavedData("bgVeh", guiCheckBoxGetSelected(bgVeh) and "1" or "0")
	end
	
	if source == borderPro then
		appendSavedData("borderPro", guiCheckBoxGetSelected(borderPro) and "1" or "0")
	end
	
	if source == bgPro then
		appendSavedData("bgPro", guiCheckBoxGetSelected(bgPro) and "1" or "0")
	end

	if source == cEnableDescription then
		appendSavedData("enableOverlayDescription", guiCheckBoxGetSelected(cEnableDescription) and "1" or "0")
	end

	if source == cEnableDescriptionVeh then
		appendSavedData("enableOverlayDescriptionVeh", guiCheckBoxGetSelected(cEnableDescriptionVeh) and "1" or "0")
	end
	
	if source == cEnableDescriptionVehPin then
		appendSavedData("enableOverlayDescriptionVehPin", guiCheckBoxGetSelected(cEnableDescriptionVehPin) and "1" or "0")
	end

	if source == cEnableOverlayDescriptionPro then
		appendSavedData("enableOverlayDescriptionPro", guiCheckBoxGetSelected(cEnableOverlayDescriptionPro) and "1" or "0")
	end
	
	if source == cEnableOverlayDescriptionProPin then
		appendSavedData("enableOverlayDescriptionProPin", guiCheckBoxGetSelected(cEnableOverlayDescriptionProPin) and "1" or "0")
	end
	
	
	if source == cMotionBlur then
		if (guiCheckBoxGetSelected(cMotionBlur)) then
			appendSavedData("motionblur", "1")
		else
			appendSavedData("motionblur", "0")
		end
	end
	if source == CHCGuiGorunum then
		if (guiCheckBoxGetSelected(CHCGuiGorunum)) then
			triggerEvent("hud:guiGuncelle", getLocalPlayer(), "1")
		else
			triggerEvent("hud:guiGuncelle", getLocalPlayer(), "0")
		end
	end
	if source == cSkyClouds then
		if (guiCheckBoxGetSelected(cSkyClouds)) then
			appendSavedData("skyclouds", "1")
		else
			appendSavedData("skyclouds", "0")
		end
	end
	
	if source == cStreamingAudio then
		if (guiCheckBoxGetSelected(cStreamingAudio)) then
			appendSavedData("streamingmedia", "1")
		else
			appendSavedData("streamingmedia", "0")
		end
	end
	
	if source == cLogsEnabled then
		if (guiCheckBoxGetSelected(cLogsEnabled)) then
			appendSavedData("logsenabled", "1")
		else
			appendSavedData("logsenabled", "0")
		end
	end
	
	--[[if (guiCheckBoxGetSelected(lPickupStreamer)) then
		appendSavedData("streamer-pickup-enabled", "1")
	else
		appendSavedData("streamer-pickup-enabled", "0")
	end
	
	if (guiCheckBoxGetSelected(lVehicleStreamer)) then
		appendSavedData("streamer-vehicle-enabled", "1")
	else                 
		appendSavedData("streamer-vehicle-enabled", "0")
	end]]
	
	if source == cBubblesEnabled then
		if (guiCheckBoxGetSelected(cBubblesEnabled)) then
			appendSavedData("chatbubbles", "1")
		else                 
			appendSavedData("chatbubbles", "0")
		end
	end
	
	if source == cIconsEnabled then
		if (guiCheckBoxGetSelected(cIconsEnabled)) then
			appendSavedData("chaticons", "1")
		else                 
			appendSavedData("chaticons", "0")
		end	
	end
	
	if source == cEnableNametags then
		if (guiCheckBoxGetSelected(cEnableNametags)) then
			appendSavedData("shownametags", "1")
		else                 
			appendSavedData("shownametags", "0")
		end
	end
	
	if source == cEnableRShaders then
		appendSavedData("enable_radar_shader", guiCheckBoxGetSelected(cEnableRShaders) and "1" or "0")
	end
	
	if source == cEnableWShaders then
		appendSavedData("enable_water_shader", guiCheckBoxGetSelected(cEnableWShaders) and "1" or "0")
	end
	
	if source == cEnableVShaders then
		appendSavedData("enable_vehicle_shader", guiCheckBoxGetSelected(cEnableVShaders) and "1" or "0")
	end
	
	triggerEvent("accounts:options:settings:updated", getLocalPlayer())
end

fonts = exports["titan_description"]:getOverLayFonts()

--MAXIME
-- function percentageToLevel(percentage)
	-- if percentage >= 0 and < 20 then
		-- return "5"
	-- elseif percentage >= 20 and < 40 then
		-- return "10"
	-- elseif percentage >= 40 and < 60 then
		-- return "20"
	-- elseif percentage >= 60 and < 80 then
		-- return "40"
	-- elseif percentage >= 80 and < 100 then
		-- return "80"
	-- else
		-- return "160"
	-- end
-- end



function guiComboBoxAdjustHeight ( combobox, itemcount )
	if getElementType ( combobox ) ~= "gui-combobox" or type ( itemcount ) ~= "number" then error ( "Invalid arguments @ 'guiComboBoxAdjustHeight'", 2 ) end
	local width = guiGetSize ( combobox, false )
	return guiSetSize ( combobox, width, ( itemcount * 20 ) + 20, false )
end

function fCloseOverlayDescSettings()
	if wOverlayDescSettings then
		destroyElement(wOverlayDescSettings)
		wOverlayDescSettings = nil
		if wGraphicsMenu then
			guiSetEnabled(wGraphicsMenu, true)
		end
	end
end

function options_closegraphicsmenu()
	if wGraphicsMenu then
		options_updateGameConfig()
		destroyElement(wGraphicsMenu)
		wGraphicsMenu = nil
	end
	fCloseOverlayDescSettings()
	if wOptions then
		guiSetEnabled(wOptions, true)
	end
end

function options_logOut( message )
	--triggerServerEvent("updateCharacters", getLocalPlayer())
	triggerEvent("materyal:bitir", getLocalPlayer(), getLocalPlayer())
	triggerServerEvent("accounts:characters:change", getLocalPlayer(), "Change Character")
	triggerEvent("onClientChangeChar", getRootElement())
	options_disable()
	Characters_showSelection()
	clearChat()
	if message then 
		LoginScreen_showWarningMessage( message )
	end
end
addEventHandler("accounts:logout", getRootElement(), options_logOut)