-- Türkçe Kaliteli Scriptin Adresi : https://sparrow-mta.blogspot.com
-- Her gün yeni script için sitemizi takip edin.
-- SparroW MTA İyi Oyunlar Diler...
-- Facebook : https://www.facebook.com/sparrowgta

-- Variables				--
------------------------------
local subTrackOnSoundDown = 0.1	-- The volume that goes down, when the player clicks "Volume -"
local subTrackOnSoundUp = 0.1	-- The volume that goes up, when the player clicks "Volume +"


function print ( message, r, g, b )
	exports.AGHud:dm ( message, r, g, b )
end

------------------------------
-- The GUI					--
------------------------------

local sx, sy = guiGetScreenSize ( )
local pg, pu = 450,360
local x,y = (sx-pg)/2, (sy-pu)/2
button = { }
window = guiCreateWindow(x,y,pg,pu, " Ses Sistemi ", false)
guiSetVisible ( window, false )

CurrentSpeaker = guiCreateLabel(175, 135, 254, 17, "Ses Varmı: Hayır", false, window)
guiSetFont(CurrentSpeaker, "default-bold-small")
volume = guiCreateLabel(195, 325, 254, 17, "Ses: 100%", false, window)
guiSetFont(volume, "default-bold-small")
volume2 = guiCreateLabel(185, 36, 251, 15, "URL YAPIŞTIR", false, window)
guiSetFont(volume2, "default-bold-small")
url = guiCreateEdit(100, 56, pg-200, 35, "", false, window)  
button["place"] = guiCreateButton(100, 100, pg-330, 30, "Hoparlörü Kur", false, window)
button["remove"] = guiCreateButton(230, 100, pg-330, 30, "Hoparlörü Kaldır", false, window)
guiCreateLabel (10, 140, 600, 30, "_______________________________________________________________", false, window)
guiCreateLabel (10, 300, 600, 30, "_______________________________________________________________", false, window)
button["v-"] = guiCreateButton(130, 319, 50, 30, "-", false, window)
button["v+"] = guiCreateButton(pg-180, 319, 50, 30, "+", false, window)
button["kapat"] = guiCreateButton(390, 30, pg-400, 25, "X", false, window)
		--Edit 1
		url1 = guiCreateLabel(185, 160, 221, 15, "1.SİTE LİNK", false, window)
        link1 = guiCreateEdit(120, 178, pg-250, 25, "https://youtubemp3.biz/tr1/", false, window) 
        guiEditSetReadOnly(link1,false)		
		--Edit 2
		url2 = guiCreateLabel(185, 230, 251, 15, "2.SİTE LİNK", false, window)
        link2 = guiCreateEdit(120, 248, pg-250, 25, "https://notube.net/convert-tr/tr", false, window)  
		guiEditSetReadOnly(link2,false)

--------------------------
-- My sweet codes		--
--------------------------

local isSound = false
addEvent ( "onPlayerViewSpeakerManagment", true )
addEventHandler ( "onPlayerViewSpeakerManagment", root, function ( current )
	local toState = not guiGetVisible ( window ) 
	guiSetVisible ( window, toState )
	showCursor ( toState )	
	if ( toState == true ) then
		guiSetInputMode ( "no_binds_when_editing" )
		local x, y, z = getElementPosition ( localPlayer )
		if ( current ) then guiSetText ( CurrentSpeaker, "Ses Varmı: Evet" ) isSound = true
		else guiSetText ( CurrentSpeaker, "Ses Varmı: Hayır" ) end
	end
end )

addEventHandler ( "onClientGUIClick", root, function ( )
	if ( source == button["place"] ) then
		if ( isURL ( ) ) then
			triggerServerEvent ( "onPlayerPlaceSpeakerBox", localPlayer, guiGetText ( url ), isPedInVehicle ( localPlayer ) )
			guiSetText ( CurrentSpeaker, "Ses Varmı: Evet" )
			isSound = true
			guiSetText ( volume, "Ses: 100%" )
		else
			 print ( "bir URL girin", 255, 0, 0 )
		end
	elseif ( source == button["remove"] ) then
		triggerServerEvent ( "onPlayerDestroySpeakerBox", localPlayer )
		guiSetText ( CurrentSpeaker, "Ses Varmı: Hayır" )
		isSound = false
		guiSetText ( volume, "Ses: 100%" )
	elseif ( source == button["v-"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) - subTrackOnSoundDown, 2 )
			if ( toVol > 0.0 ) then
				 print ( "Ses seviyesi düşürüldü "..math.floor ( toVol * 100 ).."%!", 0, 255, 0 )
				triggerServerEvent ( "onPlayerChangeSpeakerBoxVolume", localPlayer, toVol )
				guiSetText ( volume, "Ses: "..math.floor ( toVol * 100 ).."%" )
			else
				 print ( "Daha fazla sesini kısamazsın", 255, 0, 0 )
			end
		end
	elseif ( source == button["v+"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) + subTrackOnSoundUp, 2 )
			if ( toVol < 1.1 ) then
				 print ( "Ses seviyesi arttırıldı "..math.floor ( toVol * 100 ).."%!", 0, 255, 0 )
				triggerServerEvent ( "onPlayerChangeSpeakerBoxVolume", localPlayer, toVol )
				guiSetText ( volume, "Ses: "..math.floor ( toVol * 100 ).."%" )
			else
				 print ( "Daha fazla sesini yükseltemezsin", 255, 0, 0 )
			end
		end
		elseif ( source == button["kapat"] ) then
		guiSetVisible ( window, false )
		showCursor(false)
	end
end )

-- addEventHandler ( "onClientClick", getRootElement(),function( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, tiklanan )
	-- if ( tiklanan ) then
		-- local elementType = getElementType ( tiklanan )
		-- if elementType == "object" and getElementModel(tiklanan) == 2229 then
			-- triggerServerEvent ( "onPlayerDestroySpeakerBox", getElementData(tiklanan, "Sahibi") )
		-- end
	-- end
-- end)

speakerSound = { }
addEvent ( "onPlayerStartSpeakerBoxSound", true )
addEventHandler ( "onPlayerStartSpeakerBoxSound", root, function (  who, url, isCar )
	if ( isElement ( speakerSound [ who ] ) ) then destroyElement ( speakerSound [ who ] ) end
	local x, y, z = getElementPosition ( who )
	speakerSound [ who ] = playSound3D ( ""..url, x, y, z, true )
	setElementData(speakerSound [ who ], "Sahibi", who)
	setSoundVolume ( speakerSound [ who ], 1 )
	setSoundMinDistance ( speakerSound [ who ], 15 )
	setSoundMaxDistance ( speakerSound [ who ], 20 )
	setElementDimension(speakerSound [ who ], getElementDimension(getLocalPlayer()))
	if ( isCar ) then
		local car = getPedOccupiedVehicle ( who )
		attachElements ( speakerSound [ who ], car, 0, 5, 1 )
		end
end )

addEvent ( "onPlayerDestroySpeakerBox", true )
addEventHandler ( "onPlayerDestroySpeakerBox", root, function ( who ) 
	if ( isElement ( speakerSound [ who ] ) ) then 
		destroyElement ( speakerSound [ who ] ) 
	end
end )

--------------------------
-- Volume				--
--------------------------
addEvent ( "onPlayerChangeSpeakerBoxVolumeC", true )
addEventHandler ( "onPlayerChangeSpeakerBoxVolumeC", root, function ( who, vol ) 
	if ( isElement ( speakerSound [ who ] ) ) then
		setSoundVolume ( speakerSound [ who ], tonumber ( vol ) )
	end
end )

function isURL ( )
	if ( guiGetText ( url ) ~= "" ) then
		return true
	else
		return false
	end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end



function saveLinks ()
	if source == saveLinksButton or source == linkUseButton1 or source == linkUseButton2 or source == linkUseButton3 or source == linkUseButton4 or source == linkUseButton5 or source == linkUseButton6 or source == linkUseButton7 or source == linkUseButton8 or source == linkUseButton9 or source == linkUseButton10 then
		linkTable = {{}, {}, {}, {}, {}, {}, {}, {}, {}, {}}
		linkTable[1]["name"] = guiGetText (linkname1)
		linkTable[1]["link"] = guiGetText (linkedit1)
		
		linkTable[2]["name"] = guiGetText (linkname2)
		linkTable[2]["link"] = guiGetText (linkedit2)
		
		linkTable[3]["name"] = guiGetText (linkname3)
		linkTable[3]["link"] = guiGetText (linkedit3)
		
		linkTable[4]["name"] = guiGetText (linkname4)
		linkTable[4]["link"] = guiGetText (linkedit4)
		
		linkTable[5]["name"] = guiGetText (linkname5)
		linkTable[5]["link"] = guiGetText (linkedit5)
		
		linkTable[6]["name"] = guiGetText (linkname6)
		linkTable[6]["link"] = guiGetText (linkedit6)
		
		linkTable[7]["name"] = guiGetText (linkname7)
		linkTable[7]["link"] = guiGetText (linkedit7)
		
		linkTable[8]["name"] = guiGetText (linkname8)
		linkTable[8]["link"] = guiGetText (linkedit8)
		
		linkTable[9]["name"] = guiGetText (linkname9)
		linkTable[9]["link"] = guiGetText (linkedit9)
		
		linkTable[10]["name"] = guiGetText (linkname10)
		linkTable[10]["link"] = guiGetText (linkedit10)
		
		local player = localPlayer
		triggerServerEvent ("saveLinks", getRootElement(), player, linkTable)
		guiSetVisible (linkWindow, false)
	end
end
addEventHandler ("onClientGUIClick", getRootElement(), saveLinks)


function onMyLinkUse ()
	if source == linkUseButton1 then
		guiSetText (urlEdit, guiGetText (linkedit1))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname1)
	elseif source == linkUseButton2 then
		guiSetText (urlEdit, guiGetText (linkedit2))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname2)
	elseif source == linkUseButton3 then
		guiSetText (urlEdit, guiGetText (linkedit3))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname3)
	elseif source == linkUseButton4 then
		guiSetText (urlEdit, guiGetText (linkedit4))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname4)
	elseif source == linkUseButton5 then
		guiSetText (urlEdit, guiGetText (linkedit5))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname5)
	elseif source == linkUseButton6 then
		guiSetText (urlEdit, guiGetText (linkedit6))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname6)
	elseif source == linkUseButton7 then
		guiSetText (urlEdit, guiGetText (linkedit7))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname7)
	elseif source == linkUseButton8 then
		guiSetText (urlEdit, guiGetText (linkedit8))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname8)
	elseif source == linkUseButton9 then
		guiSetText (urlEdit, guiGetText (linkedit9))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname9)
	elseif source == linkUseButton10 then
		guiSetText (urlEdit, guiGetText (linkedit10))
		guiSetVisible (linkWindow, false)
		selectedURLName = guiGetText (linkname10)
	end
end
addEventHandler ("onClientGUIClick", getRootElement(), onMyLinkUse)


function onMyLinkRemoveButtonClick ()
	if source == removeButton1 then
		guiSetText (linkname1, "")
		guiSetText (linkedit1, "")
	elseif source == removeButton2 then
		guiSetText (linkname2, "")
		guiSetText (linkedit2, "")
	elseif source == removeButton3 then
		guiSetText (linkname3, "")
		guiSetText (linkedit3, "")
	elseif source == removeButton4 then
		guiSetText (linkname4, "")
		guiSetText (linkedit4, "")
	elseif source == removeButton5 then
		guiSetText (linkname5, "")
		guiSetText (linkedit5, "")
	elseif source == removeButton6 then
		guiSetText (linkname6, "")
		guiSetText (linkedit6, "")
	elseif source == removeButton7 then
		guiSetText (linkname7, "")
		guiSetText (linkedit7, "")
	elseif source == removeButton8 then
		guiSetText (linkname8, "")
		guiSetText (linkedit8, "")
	elseif source == removeButton9 then
		guiSetText (linkname9, "")
		guiSetText (linkedit9, "")
	elseif source == removeButton10 then
		guiSetText (linkname10, "")
		guiSetText (linkedit10, "")
	end
end
addEventHandler ("onClientGUIClick", getRootElement(), onMyLinkRemoveButtonClick)
