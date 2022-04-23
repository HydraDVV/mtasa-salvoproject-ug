addEvent ( "headbob:sync", true )

function headbob_sync ( plr )
	if getPlayerFromName ( getPlayerName ( plr ) ) then
		local _, _, _, targetx, targety, targetz = getCameraMatrix ( getPlayerFromName ( plr ) )
		
		outputDebugString ( targetx .. targety .. targetz )
		
		triggerClientEvent ( client, "headbob:clientSync", client, plr, { targetx, targety, targetz } )
	end
end

addEventHandler ( "headbob:sync", root, headbob_sync )