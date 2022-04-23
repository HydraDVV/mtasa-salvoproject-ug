--[[
--	Copyright (C) LettuceBoi Development - All Rights Reserved
--	Unauthorized copying of this file, via any medium is strictly prohibited
--	Proprietary and confidential
--	Written by Daniel Lett <me@lettuceboi.org>, May 2013
]]--

--Helper variables to create the GUIs.
local SCREEN_X, SCREEN_Y = guiGetScreenSize()
local resourceName = getResourceName( getThisResource( ) )

local ONE_HOUR = 3600

local SERVICES_SECTION = 1		--Places to offer services such as house cleaning or mechanics and whatnot
local CARS_VEHICLES_SECTION = 2	--Offer to buy or sell a vehicle in this section
local REAL_ESTATE_SECTION = 3	--Houses for sale go in this section
local COMMUNITY_SECTION = 4		--Advertisements about communities can go here, for example, palomino creek.
local JOBS_SECTION = 5 			--Advertisements about hiring people or looking for work will go in this section
local PERSONALS_SECTION = 6		--People looking for other people go in this section

local sections = { "Hizmetler", "Araç & Alım-Satım", "Emlak", "Topluluk", "Meslek", "Kişisel İlanlar" }

--[[
	Takes a timestamp and returns the current time in string format of however you'd like it to look.
]]
function getTime( day, month, timestamp )
	local months = {"Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"}
	local days = {"Pazar", "Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi"}
	local time = nil
	local ts = nil
	
	if timestamp then
		time = getRealTime( timestamp )
	else
		time = getRealTime( )
	end
	
	ts = ( tonumber( time.hour ) >= 12 and tostring( tonumber( time.hour ) - 12 ) or time.hour ) .. ":"..("%02d"):format(time.minute)..( tonumber( time.hour ) >= 12 and " PM" or " AM" )
	
	if month then
		ts =  months[ time.month + 1 ] .. " ".. time.monthday .. ", " .. ts
	end
	
	if day then
		ts = days[ time.weekday + 1 ].. ", " .. ts
	end
	
	return ts
end

--[[
	Creating the advertisement failed, output a message to the user.
]]
addEvent( resourceName .. ":ad_create_fail", true )
addEventHandler( resourceName .. ":ad_create_fail", root,
	function()
		local window = { } --Store all of our window elements
		local width = 230 -- The width of our window
		local height = 110 -- The height of our window
		local x = SCREEN_X / 2 - width / 2 --Where on the screen our window will be located
		local y = SCREEN_Y / 2 - height / 2
		window.window = guiCreateWindow( x, y, width, height, "Creation Error", false ) --Create the window.
		
		--Display the main message
		window.errorLabel = guiCreateLabel( 10, 30, width - 20, 20, "Girişinizde bir hata oluştu.", false, window.window )
		
		--Include a close bar to return to the main menu.
		window.closeButton = guiCreateButton( 10, 60, width - 20, 40, "Kapat", false, window.window )
		addEventHandler( "onClientGUIClick", window.closeButton, 
			function ()
				guiSetVisible( window.window, false )
				destroyElement( window.window )
				window = { }
			end
		)
	end
)

function createAdvertisement( )
	guiSetInputEnabled ( true )
	local window = { } -- Store all of our window elements
	local width = 400 -- The width of our window
	local height = 440 -- The height of our window
	local x = SCREEN_X / 2 - width / 2 --Where on the screen our window will be located
	local y = SCREEN_Y / 2 - height / 2
	
	
	window.window = guiCreateWindow( x, y, width, height, "Yeni Reklam Oluştur", false ) --Create the window.
	window.label = { } --This will hold our label elements
	
	
	local labels = { "Telefon", "İsim", "Adres", "Süre Sonu", "Bölüm", "Reklam" } --This holds all of the labels we will create here
	local y = 35 --We'll set y to 30, which is the y coordinate of where our first label will go.
	for label = 1, #labels do
		window.label[ label ] = guiCreateLabel( 10, y * label, 100, 30, labels[ label ], false, window.window )
	end
	
	window.input = { } -- Will hold all of our input elements.
	y = 30 -- We'll start y off at 25 here to stay even with the inputs.
	
	window.input[ 1 ] = guiCreateEdit( 100, y, width - 120, 30, "", false, window.window ) --Phone input
	y = y + 35
	window.input[ 2 ] = guiCreateEdit( 100, y, width - 120, 30, "", false, window.window ) --Name Input
	y = y + 35
	window.input[ 3 ] = guiCreateEdit( 100, y, width - 120, 30, "", false, window.window ) --Address input
	y = y + 40
	window.input[ 4 ] = guiCreateComboBox( 100, y, width - 120, 95, "", false, window.window ) --Expiry
	guiComboBoxAddItem( window.input[ 4 ], "Bir Saat" )
	guiComboBoxAddItem( window.input[ 4 ], "İki Saat" )
	guiComboBoxAddItem( window.input[ 4 ], "Altı Saat" )
	guiComboBoxAddItem( window.input[ 4 ], "Bir Gün" )
	
	y = y + 34
	window.input[ 5 ] = guiCreateComboBox( 100, y, width - 120, 125, "", false, window.window ) --Section
	for i = 1, #sections do --Loop through each of the 6 advertisement sections.
		guiComboBoxAddItem( window.input[ 5 ], sections[ i ] )
	end
	
	window.input[ 6 ] = guiCreateMemo( 10, y + 60, width - 20, 90, "", false, window.window ) --Advertisement
	
	--We'll need a button to send the form details to the server.
	window.postButton = guiCreateButton( 10, height - 100, width - 20, 40, "Reklam İlanı", false, window.window )
	addEventHandler( "onClientGUIClick", window.postButton, 
		function ()
			--First we'll call to the server and send all of our data there
			local phone = guiGetText( window.input[ 1 ] ) or ""
			local name = guiGetText( window.input[ 2 ] ) or ""
			local address = guiGetText( window.input[ 3 ] ) or ""
			local advertisement = guiGetText( window.input[ 6 ] )
			
			local expirySelected = guiComboBoxGetSelected( window.input[ 4 ] )
			local expires = nil
			if expirySelected == -1 or expirySelected == 0 then
				--One hour
				expires = ONE_HOUR
			elseif	expirySelected == 1 then
				--Two hours
				expires = ONE_HOUR * 2
			elseif expirySelected == 2 then
				--Six hours
				expires = ONE_HOUR * 6
			else
				--One Day
				expires = ONE_HOUR * 24
			end
			
			local section = tostring( guiComboBoxGetSelected( window.input[ 5 ] ) + 1 )
			triggerServerEvent( resourceName .. ":create_advertisement", getLocalPlayer(), phone, name, address, advertisement, expires, section )
			
			--Clear all GUI elements and remove the cursor.
			guiSetInputEnabled ( false )
			showCursor( false, false )
			guiSetVisible( window.window, false )
			destroyElement( window.window )
			window = { }
			
			
		end
	, false )
	
	--Include a close button to exit the form.
	window.closeButton = guiCreateButton( 10, height - 50, width - 20, 40, "Kapat", false, window.window )
	addEventHandler( "onClientGUIClick", window.closeButton, 
		function ()
			--Clear all GUI elements and remove the cursor.
			guiSetInputEnabled ( false )
			showCursor( false, false )
			guiSetVisible( window.window, false )
			destroyElement( window.window )
			window = { }
			
			triggerServerEvent( resourceName .. ":open_ads", localPlayer ) --Call the server to open the advertisement window again.
		end
	, false )
	
end
addCommandHandler( "reklamver", createAdvertisement, false, false )
addEvent("reklam:Ver", true)
addEventHandler("reklam:Ver", root, createAdvertisement)

function viewAdvertisement( advertisement )
	guiSetInputEnabled ( false )
	local window = { } -- Store all of our window elements
	local width = 400 -- The width of our window
	local height = 470 -- The height of our window
	local x = SCREEN_X / 2 - width / 2 --Where on the screen our window will be located
	local y = SCREEN_Y / 2 - height / 2
	
	
	window.window = guiCreateWindow( x, y, width, height, "View Advertisement", false ) --Create the window.
	window.label = { } --This will hold our label elements
	
	
	local labels = { "Telefon", "İsim", "Adres", "Başla", "Süre", "Bölüm", "Reklam" } --This holds all of the labels we will create here
	local y = 35 --We'll set y to 30, which is the y coordinate of where our first label will go.
	for label = 1, #labels do
		window.label[ label ] = guiCreateLabel( 10, y * label, 100, 30, labels[ label ], false, window.window )
	end
	
	window.input = { } -- Will hold all of our input elements.
	y = 30 -- We'll start y off at 25 here to stay even with the inputs.
	
	window.input[ 1 ] = guiCreateEdit( 100, y, width - 120, 30, advertisement.phone, false, window.window ) --Phone input
	guiEditSetReadOnly( window.input[ 1 ], true )
	y = y + 35
	window.input[ 2 ] = guiCreateEdit( 100, y, width - 120, 30, advertisement.name, false, window.window ) --Name Input
	guiEditSetReadOnly( window.input[ 2 ], true )
	y = y + 35
	window.input[ 3 ] = guiCreateEdit( 100, y, width - 120, 30, advertisement.address, false, window.window ) --Address input
	guiEditSetReadOnly( window.input[ 3 ], true )
	y = y + 35
	window.input[ 4 ] = guiCreateEdit( 100, y, width - 120, 30, getTime( true, true, advertisement.start ), false, window.window ) --Start
	guiEditSetReadOnly( window.input[ 4 ], true )
	y = y + 35
	window.input[ 5 ] = guiCreateEdit( 100, y, width - 120, 30, getTime( true, true, advertisement.expiry ), false, window.window ) --Expiry
	guiEditSetReadOnly( window.input[ 5 ], true )
	y = y + 35
	window.input[ 6 ] = guiCreateEdit( 100, y, width - 120, 30, sections[ tonumber( advertisement.section ) ], false, window.window ) --Section
	guiEditSetReadOnly( window.input[ 6 ], true )
	
	window.input[ 7 ] = guiCreateMemo( 10, y + 60, width - 20, 90, advertisement.advertisement, false, window.window ) --Advertisement
	guiMemoSetReadOnly( window.input[ 7 ], true )
	
	if tonumber( getElementData( localPlayer, "dbid" ) ) == tonumber( advertisement.created_by ) then --Only display delete if they created the advert.
		--We'll need a button to delete this if the player is the creator.
		window.deleteButton = guiCreateButton( 10, height - 100, width - 20, 40, "Reklamı Sil", false, window.window )
		addEventHandler( "onClientGUIClick", window.deleteButton, 
			function ()
				triggerServerEvent( resourceName .. ":delete_advertisement", localPlayer, advertisement.id )
				--Clear all GUI elements and remove the cursor.
				guiSetInputEnabled ( false )
				showCursor( false, false )
				guiSetVisible( window.window, false )
				destroyElement( window.window )
				window = { }
				
			end
		, false )
	elseif tonumber( getElementData( localPlayer, "dbid" ) ) ~= tonumber( advertisement.created_by ) and exports.global:isPlayerAdmin(localPlayer) then
		window.deleteButton = guiCreateButton( 10, height - 100, width - 20, 40, "((Reklamı Sil (Admin Ayarları)", false, window.window )
		addEventHandler( "onClientGUIClick", window.deleteButton, 
			function ()
				triggerServerEvent( resourceName .. ":delete_advertisement", localPlayer, advertisement.id )
				--Clear all GUI elements and remove the cursor.
				guiSetInputEnabled ( false )
				showCursor( false, false )
				guiSetVisible( window.window, false )
				destroyElement( window.window )
				window = { }
				
			end
		, false )
	end
	--Include a close button to exit the form.
	window.closeButton = guiCreateButton( 10, height - 50, width - 20, 40, "Kapat", false, window.window )
	addEventHandler( "onClientGUIClick", window.closeButton, 
		function ()
			--Clear all GUI elements and remove the cursor.
			guiSetInputEnabled ( false )
			showCursor( false, false )
			guiSetVisible( window.window, false )
			destroyElement( window.window )
			window = { }
			triggerServerEvent( resourceName .. ":open_ads", localPlayer ) --Call the server to open the advertisement window again.
		end
	, false )
end

addEvent( resourceName .. ":display_all", true )
addEventHandler( resourceName .. ":display_all", root, 
	function( advertisements )
		showCursor( true, true )
		local window = { } -- Store all of our window elements
		local width = 500 -- The width of our window
		local height = 500 -- The height of our window
		local x = SCREEN_X / 2 - width / 2 --Where on the screen our window will be located
		local y = SCREEN_Y / 2 - height / 2
		window.window = guiCreateWindow( x, y, width, height, "Reklamlar", false ) --Create the window.
		
		--First we'll include a nice big button at the top for users to create an advertisement
		window.closeButton = guiCreateButton( 10, 30, width - 20, 40, "Reklam Ver", false, window.window )
		addEventHandler( "onClientGUIClick", window.closeButton, 
			function ()
				--Clear all GUI elements and open the creation dialog.
				guiSetVisible( window.window, false )
				destroyElement( window.window )
				window = { }
				createAdvertisement( )
			end
		, false )
		
		
		window.mainPanel	= guiCreateTabPanel ( 10, 90, width - 15, height - 150, false, window.window ) --Create the panel to hold the different sections of advertisement
		
		--Variables to hold our GUI elements
		window.tab		= { }
		window.table	= { }
		window.colPhone = { }
		window.colName 	= { }
		window.colAd 	= { }
		
		for i = 1, #sections do --Loop through each of the 6 advertisement sections.
			
			window.tab[ i ]		= guiCreateTab( sections[ i ], window.mainPanel ) --Create a tab for each section
			window.table[ i ]	= guiCreateGridList ( 10, 10, width - 35, height - 190, false, window.tab[ i ] ) --In each tab include a table
			
			window.colPhone[ i ]= guiGridListAddColumn( window.table[ i ], "Telefon", 0.2 ) --We'll just display phone, name and advertisement on the main page
			window.colName[ i ]	= guiGridListAddColumn( window.table[ i ], "İsim", 0.2 )
			window.colAd[ i ]	= guiGridListAddColumn( window.table[ i ], "Reklam", 0.5 )
			if ( #advertisements > 0 ) then --Check if there is any advertisements to display.
				for ad = 1, #advertisements do --Loop through each advertisement
					if tonumber( advertisements[ ad ].section ) == i then
						local row = guiGridListAddRow ( window.table[ i ] ) --Add a row to the table.
						
						guiGridListSetItemText( window.table[ i ], row, window.colPhone[ i ], advertisements[ ad ].phone, false, false )
						guiGridListSetItemText( window.table[ i ], row, window.colName[ i ], advertisements[ ad ].name, false, false )
						guiGridListSetItemText( window.table[ i ], row, window.colAd[ i ], advertisements[ ad ].advertisement, false, false )
						
						--Include the advertisement key in the data for reference later.
						guiGridListSetItemData( window.table[ i ], row, window.colPhone[ i ], ad )
						
						--When the grid is double clicked, view the selected advertisement.
						addEventHandler( "onClientGUIDoubleClick", window.table[ i ],
							function ( )
								local selectedRow, selectedCol = guiGridListGetSelectedItem( window.table[ i ] )
								local key = guiGridListGetItemData( window.table[ i ], selectedRow, window.colPhone[ i ] )
								if advertisements[ key ] then
									viewAdvertisement( advertisements[ key ] )
									
									guiSetVisible( window.window, false )
									destroyElement( window.window )
									window = { }
								end
							end
						, false )
					end
				end
			else
				--If there are no current advertisements, leave a note for the user.
				local row = guiGridListAddRow ( window.table[ i ] )
				guiGridListSetItemText ( window.table[ i ], row, window.colPhone[ i ], "Reklam Yok", false, false )
			end
		end
		
		--Include a close button to exit the form.
		window.closeButton = guiCreateButton( 10, height - 50, width - 20, 40, "Kapat", false, window.window )
		addEventHandler( "onClientGUIClick", window.closeButton, 
			function ()
				--Clear all GUI elements and remove the cursor.
				showCursor( false, false )
				guiSetVisible( window.window, false )
				destroyElement( window.window )
				window = { }
			end
		, false )
	end
)