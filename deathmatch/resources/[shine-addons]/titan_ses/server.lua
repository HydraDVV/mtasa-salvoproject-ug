-- Türkçe Kaliteli Scriptin Adresi : https://sparrow-mta.blogspot.com
-- Her gün yeni script için sitemizi takip edin.
-- SparroW MTA İyi Oyunlar Diler...
-- Facebook : https://www.facebook.com/sparrowgta

local isSpeaker = false

function print ( player, message, r, g, b )
	outputChatBox ( message, player, r, g, b )
end

speakerBox = { }
textYazi = { }


addCommandHandler ( "ses", function ( thePlayer  )

	if ( isElement ( speakerBox [ thePlayer] ) ) then isSpeaker = true end
	triggerClientEvent ( thePlayer, "onPlayerViewSpeakerManagment", thePlayer, isSpeaker )
end )

addEvent ( "onPlayerPlaceSpeakerBox", true )
addEventHandler ( "onPlayerPlaceSpeakerBox", root, function ( url, isCar ) 
	if ( url ) then
		if ( isElement ( speakerBox [ source ] ) ) then
			local x, y, z = getElementPosition ( speakerBox [ source ] ) 
			destroyElement ( speakerBox [ source ] )
			removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		end
		if ( isElement ( textYazi [ source ] ) ) then
			local x, y, z = getElementPosition ( textYazi [ source ] ) 
			destroyElement ( textYazi [ source ] )
			removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		end
		local x, y, z = getElementPosition ( source )
		local rx, ry, rz = getElementRotation ( source )
		speakerBox [ source ] = createObject ( 2229, x-0.5, y+0.5, z - 1, 0, 0, rx )
				local xx, yy, zz = getElementPosition ( speakerBox [ source ] )
			 textYazi [source] = createElement("text")
			setElementPosition(textYazi [ source ], xx-0.3, yy-0.2, zz+1.6)
			setElementData(textYazi [ source ], "scale", 1.2)
			setElementData(textYazi [ source ], "text", "#0066ff[Müzik Kutusu]\n Sahip: #FFFFFF"..getPlayerName(source).."\n#0066ffKomut: #FFFFFF''/ses''")
		setElementData(speakerBox [ source ], "Sahibi", source)
		setElementDimension(speakerBox [ source ], getElementDimension(source))
		outputChatBox("#0066ff[✘] #ffffff Müzik kutusu kuruldu.", source	, 255, 0, 0, true)
		addEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		triggerClientEvent ( root, "onPlayerStartSpeakerBoxSound", root, source, url, isCar )
		if ( isCar ) then
			local car = getPedOccupiedVehicle ( source )
			attachElements ( speakerBox [ source ], car, -0.7, -1.5, -0.5, 0, 90, 0 )
			destroyElement ( textYazi [ source ] )
		end
	end
	
end )

addEvent ( "onPlayerDestroySpeakerBox", true )
addEventHandler ( "onPlayerDestroySpeakerBox", root, function ( )
	if ( isElement ( speakerBox [ source ] ) ) then
		destroyElement ( speakerBox [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
		removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		outputChatBox("#0066ff[✘] #ffffff Müzik kutusu kaldırıldı.", source, 255, 0, 0, true)
	else
		outputChatBox("#0066ff[✘] #ffffff Müzik kutusu zaten kaldırıldı.", source, 255, 0, 0, true)
	end	
	if ( isElement ( textYazi [ source ] ) ) then
		destroyElement ( textYazi [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
		removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		--outputChatBox("#0066ff[✘] #ffffff Müzik kutusu kaldırıldı.", source, 255, 0, 0, true)
	else
		outputChatBox("#0066ff[✘] #ffffff Müzik kutusu zaten kaldırıldı.", source, 255, 0, 0, true)
	end
end )

addEvent ( "onPlayerChangeSpeakerBoxVolume", true ) 
addEventHandler ( "onPlayerChangeSpeakerBoxVolume", root, function ( to )
	triggerClientEvent ( root, "onPlayerChangeSpeakerBoxVolumeC", root, source, to )
end )

function destroySpeakersOnPlayerQuit ( )
	if ( isElement ( speakerBox [ source ] ) ) then
		destroyElement ( speakerBox [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
	end
	if ( isElement ( textYazi [ source ] ) ) then
		destroyElement ( textYazi [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
	end
end


function getLinks (player)
	local account = getPlayerAccount (player)
	if getAccountData (account, "urlLinks") then
		linkJSONTable = getAccountData (account, "urlLinks")
		linkTable = fromJSON (linkJSONTable)
	else
		linkTable = {{}, {}, {}, {}, {}, {}, {}, {}, {}, {}}
		linkTable[1]["name"] = ""
		linkTable[1]["link"] = ""
		
		linkTable[2]["name"] = ""
		linkTable[2]["link"] = ""
		
		linkTable[3]["name"] = ""
		linkTable[3]["link"] = ""
		
		linkTable[4]["name"] = ""
		linkTable[4]["link"] = ""
		
		linkTable[5]["name"] = ""
		linkTable[5]["link"] = ""
		
		linkTable[6]["name"] = ""
		linkTable[6]["link"] = ""
		
		linkTable[7]["name"] = ""
		linkTable[7]["link"] = ""
		
		linkTable[8]["name"] = ""
		linkTable[8]["link"] = ""
		
		linkTable[9]["name"] = ""
		linkTable[9]["link"] = ""
		
		linkTable[10]["name"] = ""
		linkTable[10]["link"] = ""
	end
	local tableoflinks = linkTable
	triggerClientEvent (player, "createMyLinksGUI", getRootElement(), tableoflinks)
end

function saveLinks (player, linkTable)
	local account = getPlayerAccount (player)
	local linkTable = toJSON (linkTable)
	setAccountData (account, "urlLinks", linkTable)
end