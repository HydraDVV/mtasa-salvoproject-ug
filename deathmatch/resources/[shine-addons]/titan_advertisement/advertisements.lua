--[[
--	Copyright (C) LettuceBoi Development - All Rights Reserved
--	Unauthorized copying of this file, via any medium is strictly prohibited
--	Proprietary and confidential
--	Written by Daniel Lett <me@lettuceboi.org>, May 2013
]]--

local SERVICES_SECTION = 1		--Places to offer services such as house cleaning or mechanics and whatnot
local CARS_VEHICLES_SECTION = 2	--Offer to buy or sell a vehicle in this section
local REAL_ESTATE_SECTION = 3	--Houses for sale go in this section
local COMMUNITY_SECTION = 4		--Advertisements about communities can go here, for example, palomino creek.
local JOBS_SECTION = 5 			--Advertisements about hiring people or looking for work will go in this section
local PERSONALS_SECTION = 6		--People looking for other people go in this section
local resourceName = getResourceName( getThisResource( ) )

--[[
	Small function to shorten the escaping of strings.
]]
function escape( value )
	return exports.mysql:escape_string( value )
end
--[[
	Triggered when a user completes the form to create an advertisement.
]]
addEvent( resourceName .. ":create_advertisement", true )
addEventHandler( resourceName .. ":create_advertisement", root, 
	function( phone, name, address, advertisement, expires, section )
		--Check if all fields have been entered by the user.
		
		if not ( phone == nil or name == nil or address == nil or advertisement == nil ) then
			--Make sure these are SQL safe
			phone = escape( phone )
			name = escape( name )
			address = escape( address )
			advertisement = escape( advertisement )
			
			--Fetch the created by 
			local createdBy = tostring( getElementData( source, "dbid" ) )
			
			--Get the current server time to store as our start time
			local start = getRealTime().timestamp
			--Add the time until expiry to the start time to get the actual time it will expire.
			local expiry = start + expires
			
			--Create the query we will send to the database to create our advertisement.
			local queryStr = "INSERT INTO advertisements (`phone`, `name`,`address`,`advertisement`, `start`, `expiry`,`created_by`, `section`) "
			queryStr = queryStr .. " VALUES ( '"..phone.."','"..name.."','"..address.."','"..advertisement.."','"..start.."','"..expiry.."','"..createdBy.."','"..tostring( section ).."')"
			local query = exports.mysql:query_insert_free( queryStr )
			
			--Check if our query went into the database successfully.
			if query then
				--We'll send something to the client side so they can close the add form and reopen the main advertisements form.
				openAdvertisements( source, nil )
			else
				--If the database query was unsucessful, alert the end user.
				outputChatBox( "SQL Error.", source )
				triggerClientEvent( source, resourceName .. ":ad_create_fail", root )
			end
		else
			--If all fields were not entered, alert the user.
			outputChatBox( "Field Error.", source )
			triggerClientEvent( source, resourceName .. ":ad_create_fail", root )
		end
	end
)

--[[
	Called when the delete button on the view advertisement page is clicked
]]

function deleteAdvertisement( id )
	local query = exports.mysql:query_free( "DELETE FROM `advertisements` WHERE `id` = '"..escape( id ).."'" )
	if query then
		return true
	else
		return false
	end
end

addEvent( resourceName .. ":delete_advertisement", true )
addEventHandler( resourceName .. ":delete_advertisement", root, 
	function( id )
		if deleteAdvertisement( id ) then
			openAdvertisements( source )
		else
			outputChatBox( "#FF0000[!]#FFFFFFGönderinin silinmesiyle ilgili bir hata oluştu.", source, 0, 0, 0 )
		end
	end
)

--[[
	The main function to open the entire advertisements system.
]]
function openAdvertisements( player, command )
	local advertisements = { } --These will hold our advertisements to send to the client and populate our advertisement tables.
	
	if not player then player = source end
	
	--Fetch all of the advertisements from the database
	local query = exports.mysql:query("SELECT * FROM advertisements")
	if ( query ) then --Check if there are any advertisements to fetch.
		local count = 1 --Create a counter to input the values into our array.
		while true do --Loop through each advertisement.
			local ad = exports.mysql:fetch_assoc( query )
			if not ad then break end
			if tonumber(  ad.expiry ) >= getRealTime().timestamp then --Check if the advertisement has expired, delete it if so.
				advertisements[count] = { }
				advertisements[ count ] = ad
				--[[advertisements[count][ 1 ] = ad.id --Add each advertisement to our advertisements array.
				advertisements[count][ 2 ] = ad.phone
				advertisements[count][ 3 ] = ad.name
				advertisements[count][ 4 ] = ad.address
				advertisements[count][ 5 ] = ad.advertisement
				advertisements[count][ 6 ] = ad.start
				advertisements[count][ 7 ] = ad.expiry
				advertisements[count][ 8 ] = ad.created_by
				advertisements[count][ 9 ] = ad.section]]
				count = count + 1
			else
				deleteAdvertisement( ad.id )
			end
			
		end
		exports.mysql:free_result( query )
	end
	
	triggerClientEvent( player, resourceName .. ":display_all", root, advertisements ) --Send the advertisements to the client to create the GUI.
end
addCommandHandler( "reklamlistesi", openAdvertisements, false, false )
addCommandHandler( "reklamlar", openAdvertisements, false, false )
addEvent( resourceName .. ":open_ads", true )
addEventHandler( resourceName .. ":open_ads", root, openAdvertisements )