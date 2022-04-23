local hfont = exports.titan_fonts:getFont("FontAwesome",15)
local pedTable = { }
local characterSelected, characterElementSelected, yenikarakter = nil
function Characters_showSelection()
	triggerEvent("onSapphireXMBShow", getLocalPlayer())	
	setPlayerHudComponentVisible("radar", false)
	guiSetInputEnabled(false)
	if not isCursorShowing ( ) then
		showCursor(true)
	end
	setElementDimension ( getLocalPlayer(), 1 )
	setElementInterior( getLocalPlayer(), 0 )
	local x = -2315.2763671875 
	local y = 1537.572265625 
	local z = 18.7734375
	
	--local x = 1271.666015625        -2315.2763671875 1537.572265625 18.7734375
	--local y = -800.4423828125
	--local z = 88.315116882324
	local characterList = getElementData(getLocalPlayer(), "account:characters")
	if (characterList) then
		-- Prepare the peds
		for _, v in ipairs(characterList) do
			local thePed = createPed( tonumber( v[9]), x, y, z)
			setPedRotation(thePed, 270)
			setElementDimension(thePed, 1)
			setElementInterior(thePed, 0)
			setElementData(thePed,"account:charselect:id", v[1], false)
			setElementData(thePed,"account:charselect:name", v[2]:gsub("_", " "), false)
			setElementData(thePed,"account:charselect:cked", v[3], false)
			setElementData(thePed,"account:charselect:lastarea", v[4], false)
			setElementData(thePed,"account:charselect:lastseen", v[10], false)
			setElementData(thePed,"account:charselect:age", v[5], false)
			setElementData(thePed,"account:charselect:weight", v[11], false)
			setElementData(thePed,"account:charselect:height", v[12], false)
			setElementData(thePed,"account:charselect:desc", v[13], false)
			setElementData(thePed,"account:charselect:age", v[5], false)
			setElementData(thePed,"account:charselect:gender", v[6], false)
			setElementData(thePed,"account:charselect:faction", v[7] or "", false)
			setElementData(thePed,"account:charselect:factionrank", v[8] or "", false)
			setElementData(thePed,"sehir", v[13] or "", false)
			setElementData(thePed,"karakter_tip", v[14] or "", false)
			
			
			local randomAnimation = getRandomAnim( v[3] == 1 and 4 or 2 )
			setPedAnimation ( thePed , randomAnimation[1], randomAnimation[2], -1, true, false, false, false )
			
			x = x + 3
			if x > -2100.2763671875 then
				x = -2315.2763671875
				y = y - 3
			end
			
			table.insert(pedTable, thePed)
		end
		-- Done!
		addEventHandler("onClientPreRender", getRootElement(), Characters_updateSelectionCamera)
		addEventHandler("onClientRender", getRootElement(), renderNametags)
	end
end

function Characters_characterSelectionVisisble()
	local sWidths,sHeights = guiGetScreenSize()
	local Widths,Heights = 300,250
	local X = (sWidths-210) - (Widths/2)
	local Y = (sHeights/2) - (Heights/2)
	
	addEventHandler("onClientClick", getRootElement(), Characters_onClientClick)
	local limit = tonumber(getElementData(getLocalPlayer(), "karakterlimit") or 3)--Yanlışıkla yaptım aq elleme
	if not (#getElementData(getLocalPlayer(), "account:characters") >= limit) then
		yenikarakter = guiCreateStaticImage(X, 25, 300, 50, "login-panel/newchar.png", false)
		addEventHandler("onClientGUIClick", yenikarakter, Characters_newCharacter)
		addEventHandler("onClientMouseEnter", yenikarakter,checkYeniKarakter)
		addEventHandler("onClientMouseLeave", yenikarakter,checkYeniKarakter2)
	end
	--newCharacterButton = guiCreateButton(0.4, 0.02, 0.2, 0.1, "Yeni Karakter Kur!", true, nil)
	--addEventHandler("onClientGUIClick", newCharacterButton, Characters_newCharacter)
	
end

function checkYeniKarakter()
	guiSetAlpha(yenikarakter, 0.50)
end

function checkYeniKarakter2()
	guiSetAlpha(yenikarakter, 1)
end

local currposs = -10000
function Characters_updateSelectionCamera ()
	removeEventHandler("onClientPreRender",getRootElement(),Characters_updateSelectionCamera)
	Characters_characterSelectionVisisble()
	setCameraMatrix (-2295.5654296875, 1544.9951171875, 22.2171459198, -599999, -3333, 9999)
	--setCameraMatrix (862.8214, -2021.8142, 27.1838, 0, currposs, 0)
end

function renderNametags()
	for key, player in ipairs(getElementsByType("ped")) do
		if (isElement(player))then
			if (getElementData(player,"account:charselect:id")) then
				local lx, ly, lz = getElementPosition( getLocalPlayer() )
				local rx, ry, rz = getElementPosition(player)
				local distance = getDistanceBetweenPoints3D(lx, ly, lz, rx, ry, rz)
				if  (isElementOnScreen(player)) then
					local lx, ly, lz = getCameraMatrix()
					local collision, cx, cy, cz, element = processLineOfSight(lx, ly, lz, rx, ry, rz+1, true, true, true, true, false, false, true, false, nil)
					if not (collision) then	
						local x, y, z = getElementPosition(player)
						local sx, sy = getScreenFromWorldPosition(x, y, z+0.45, 100, false)
						if (sx) and (sy) then
							if (distance<=2) then
								sy = math.ceil( sy - ( 2 - distance ) * 40 )
							end
							sy = sy - 20
							if (sx) and (sy) then
								distance = 1.5 
								local offset = 75 / distance
								dxDrawText("\n"..getElementData(player,"account:charselect:name"), sx-offset+2, sy+2, (sx-offset)+150 / distance, sy-10 / distance, tocolor(0, 0, 0, 220), 1 / distance, hfont, "center", "center", false, false, false)
								dxDrawText("\n"..getElementData(player,"account:charselect:name"), sx-offset, sy, (sx-offset)+150 / distance, sy-10 / distance, tocolor(255, 255, 255, 220), 1 / distance, hfont, "center", "center", false, false, false)	
							end
						end
					end
				end
			end
		end
	end
end

function Characters_onClientClick(mouseButton, buttonState, alsoluteX, alsoluteY, worldX, worldY, worldZ, theElement)
	if (theElement) and (buttonState == "down") then
		if (getElementData(theElement,"account:charselect:id")) then
			characterSelected = getElementData(theElement,"account:charselect:id")			
			characterElementSelected = theElement			
			
			Characters_updateDetailScreen(theElement)
			
			local randomAnimation = nil
			for _, thePed in ipairs(pedTable) do
				local deceased = getElementData(thePed,"account:charselect:cked")
				if deceased ~= 1 then
					if thePed == theElement then
						randomAnimation = getRandomAnim( 1 )
					else
						randomAnimation = getRandomAnim( 2 )
					end
				else
					randomAnimation = getRandomAnim( 4 )
				end
				if randomAnimation then
					local anim1, anim2 = getPedAnimation(thePed)
					if randomAnimation[1] ~= anim1 or randomAnimation[2] ~= anim2 then
						setPedAnimation ( thePed , randomAnimation[1], randomAnimation[2], -1, true, false, false, false )
					end
				end
			end
		end
	end
end

--- Character detail screen
local wDetailScreen, lDetailScreen, iCharacterImage, bPlayAs,cFadeOutTime = nil
function Characters_createDetailScreen()
	if wDetailScreen  then
		return true
	end
	
	local width, height = guiGetScreenSize()
	
	local sWidths,sHeights = guiGetScreenSize()
	local Widths,Heights = 300,250
	local X = (sWidths-210) - (Widths/2)
	local Y = (sHeights/2) - (Heights/2)
	
	
	wDetailScreen = guiCreateStaticImage( X, 75, 300, 250, "login-panel/charinfo.png", false )
	guiSetEnabled (wDetailScreen, false)
	--wDetailScreen = guiCreateWindow(width/1.5, 0, math.min(width / 1.5, 300),400, "", false)
	--guiWindowSetSizable(wDetailScreen, false)
	
	lDetailScreen = {
		guiCreateLabel(0.038,0.20,0.96,0.0887,"N/A",true,wDetailScreen),
		guiCreateLabel(0.038,0.28,0.96,0.0887,"N/A.",true,wDetailScreen),
		guiCreateLabel(0.038,0.35,0.96,0.0887,"N/A.",true,wDetailScreen),
		guiCreateLabel(0.038,0.48,0.96,0.0887,"N/A.",true,wDetailScreen),
		guiCreateLabel(0.038,0.42,0.96,0.0887,"N/A.",true,wDetailScreen),
		guiCreateLabel(0.038,0.55,0.96,0.0887,"N/A.",true,wDetailScreen),
		guiCreateLabel(0.038,0.64,0.96,0.0887,"N/A.",true,wDetailScreen),
		guiCreateLabel(0.038,0.73,0.96,0.0887,"N/A.",true,wDetailScreen),
		guiCreateLabel(0.038,0.82,0.96,0.0887,"N/A.",true,wDetailScreen),
	}
	guiSetFont(lDetailScreen[1], "default-bold-small")
	guiSetFont(lDetailScreen[2], "default-bold-small")
	guiSetFont(lDetailScreen[3], "default-bold-small")
	guiSetFont(lDetailScreen[4], "default-bold-small")
	guiSetFont(lDetailScreen[5], "default-bold-small")
	guiSetFont(lDetailScreen[6], "default-bold-small")
	guiSetFont(lDetailScreen[7], "default-bold-small")
	guiSetFont(lDetailScreen[8], "default-bold-small")
	guiSetFont(lDetailScreen[9], "default-bold-small")
	bPlayAs = guiCreateStaticImage(X, 325, 300, 50, "login-panel/start.png", false)
		addEventHandler("onClientGUIClick", bPlayAs, Characters_selectCharacter, false)
		addEventHandler("onClientMouseEnter", bPlayAs,Play1)
		addEventHandler("onClientMouseLeave", bPlayAs,Play2)
	--bPlayAs = guiCreateButton(80, 322, 220, 78, "", false, wDetailScreen)
	--addEventHandler("onClientGUIClick", bPlayAs, Characters_selectCharacter, false)
	return true
end

function Play1()
	guiSetAlpha(bPlayAs, 0.75)
end

function Play2()
	guiSetAlpha(bPlayAs, 1)
end

function Characters_updateDetailScreen(thePed)
	if Characters_createDetailScreen() then
		if (iCharacterImage ~= nil) then
			destroyElement(iCharacterImage)
		end
		local skin = getElementModel(thePed)
		--iCharacterImage = guiCreateStaticImage ( 10, 322, 64, 78, "img/" .. ("%03d"):format(skin) .. ".png", false, wDetailScreen)
		
		guiSetText ( lDetailScreen[1], "İsim Soyisim: " .. getElementData(thePed,"account:charselect:name") )
		guiLabelSetHorizontalAlign( lDetailScreen[1], "center")
		local characterGender = getElementData(thePed, "account:charselect:gender")
		local characterGenderStr = "Kadın"
		if (characterGender == 0) then
			characterGenderStr = "Erkek"
		end
		guiSetText ( lDetailScreen[2], "Cinsiyet: " .. characterGenderStr )
		guiLabelSetHorizontalAlign( lDetailScreen[2], "center")
		
		local characterStatus = getElementData(thePed, "account:charselect:cked")
		local characterStatusStr = "Ölü"
		if (characterStatus ~= 1) then
			characterStatusStr = "Yaşıyor"
		end
		
		guiSetText ( lDetailScreen[3], "Durum: " .. characterStatusStr )
		guiLabelSetHorizontalAlign( lDetailScreen[3], "center")
		guiSetText ( lDetailScreen[4], "Yaş: " .. tostring(getElementData(thePed, "account:charselect:age")) )
		guiLabelSetHorizontalAlign( lDetailScreen[4], "center")
		guiSetText ( lDetailScreen[5],"Birlik: " ..getElementData(thePed, "account:charselect:faction") )
		guiLabelSetHorizontalAlign( lDetailScreen[5], "center")
		guiSetText ( lDetailScreen[6],"Birlik Rank: " ..getElementData(thePed, "account:charselect:factionrank") )
		guiLabelSetHorizontalAlign( lDetailScreen[6], "center")
		guiSetText ( lDetailScreen[7],"Son Görülme: "..getElementData(thePed, "account:charselect:lastarea") )			
		guiLabelSetHorizontalAlign( lDetailScreen[7], "center")
		guiSetText ( lDetailScreen[8],"Doğduğu Şehir: "..getElementData(thePed, "sehir") )			
		guiLabelSetHorizontalAlign( lDetailScreen[8], "center")
		local karakter_tip = "Legal"
		if getElementData(thePed, "karakter_tip") == "0" then
			karakter_tip = "Legal"
		elseif getElementData(thePed, "karakter_tip")  == "1" then
			karakter_tip = "İllegal"
		end
		guiSetText ( lDetailScreen[9],"Karakter Tipi: ".. karakter_tip )			
		guiLabelSetHorizontalAlign( lDetailScreen[9], "center")
		if getElementData(thePed, "account:charselect:cked") == 1 then
			guiSetEnabled(bPlayAs, false)
		else
			guiSetEnabled(bPlayAs, true)
		end
	end
end

function Characters_deactivateGUI()
	if isElement(bPlayAs) then
		guiSetEnabled(bPlayAs, false)
		guiSetEnabled(wDetailScreen, false)
		guiSetEnabled( yenikarakter, false )
	end
	removeEventHandler("onClientRender", getRootElement(), renderNametags)
	removeEventHandler("onClientClick", getRootElement(), Characters_onClientClick)
end

function Characters_selectCharacter()
	if (characterSelected ~= nil) then
		Characters_deactivateGUI()
		local randomAnimation = getRandomAnim(3)
		setPedAnimation ( characterElementSelected, randomAnimation[1], randomAnimation[2], -1, true, false, false, false )
		cFadeOutTime = 254
		addEventHandler("onClientRender", getRootElement(), Characters_FadeOut)
		triggerServerEvent("accounts:characters:spawn", getLocalPlayer(), characterSelected)
	end 
end

function Characters_FadeOut()
	cFadeOutTime = cFadeOutTime -3
	if (cFadeOutTime <= 0) then
		removeEventHandler("onClientRender", getRootElement(), Characters_FadeOut)
	else
		for _, thePed in ipairs(pedTable) do
			if thePed ~= characterElementSelected then
				setElementAlpha(thePed, cFadeOutTime)
			end
		end
	end
end

function characters_destroyDetailScreen()
	lDetailScreen = { }
	if isElement(wDetailScreen) then
		destroyElement(iCharacterImage)
		destroyElement(bPlayAs)
		destroyElement(wDetailScreen)
		iCharacterImage = nil
		iPlayAs = nil
		wDetailScreen = nil
	end
	for _, thePed in ipairs(pedTable) do
		destroyElement(thePed)
	end
	pedTable = { }
	cFadeOutTime = 0
	destroyElement( yenikarakter )
end
--- End character detail screen

function characters_onSpawn(fixedName, adminLevel, gmLevel, factionID, factionRank)
	clearChat()
	showCursor(false)
	outputChatBox("", 0, 241, 241)
	outputChatBox("", 0, 255, 0)
	outputChatBox("", 255, 194, 14)
	outputChatBox("", 255, 194, 15)
	outputChatBox("")
	
	characters_destroyDetailScreen()
	setElementData(getLocalPlayer(), "adminlevel", adminLevel, false)
	setElementData(getLocalPlayer(), "account:gmlevel", gmLevel, false)
	setElementData(getLocalPlayer(), "faction", factionID, false)
	setElementData(getLocalPlayer(), "factionrank", factionrank, false)
	
	options_enable()
	setPlayerHudComponentVisible("radar", false )
end
addEventHandler("accounts:characters:spawn", getRootElement(), characters_onSpawn)

function Characters_newCharacter()
	Characters_deactivateGUI()
	characters_destroyDetailScreen()
	newCharacter_init()
end