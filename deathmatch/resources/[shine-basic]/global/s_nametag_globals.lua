function updateNametagColor(thePlayer)
	if getElementData(thePlayer, "loggedin") ~= 1 then -- Not logged in
		setPlayerNametagColor(thePlayer, 127, 127, 127)
	elseif isPlayerAdmin(thePlayer) and getElementData(thePlayer, "adminduty") == 1 and getElementData(thePlayer, "hiddenadmin") == 0 then -- Admin duty
		setPlayerNametagColor(thePlayer, 200, 15, 15) -- old admin yellow
		-- if isPlayerHeadAdmin(thePlayer) then
			-- setPlayerNametagColor(thePlayer, 138, 8, 8)
		-- elseif isPlayerLeadAdmin(thePlayer) then
			-- setPlayerNametagColor(thePlayer, 180, 4, 4)
		-- elseif isPlayerSuperAdmin(thePlayer) then
			-- setPlayerNametagColor(thePlayer, 223, 1, 1)
		-- elseif isPlayerFullAdmin(thePlayer) then
			-- setPlayerNametagColor(thePlayer, 255, 0, 0)
		-- else
			-- setPlayerNametagColor(thePlayer, 254, 46, 46)
	elseif isPlayerAdmin(thePlayer) and getElementData(thePlayer, "adminduty") == 1 and getElementData(thePlayer, "hiddenadmin") == 0 then -- Admin duty
		setPlayerNametagColor(thePlayer, 32, 178, 170) -- old admin yellow
		setPlayerNametagColor(thePlayer, 150,150,255)
	elseif birlikTip == 8 then
		setPlayerNametagColor(thePlayer, 255,255,0)	
		-- end
	elseif isPlayerGameMaster(thePlayer) and getElementData(thePlayer, "account:gmduty") then 
		setPlayerNametagColor(thePlayer, 70, 200, 30)
	elseif exports.donators:hasPlayerPerk(thePlayer, 11) then -- Donator
		setPlayerNametagColor(thePlayer, 167, 133, 63)
	else
		setPlayerNametagColor(thePlayer, 255, 255, 255)
	end
end

for key, value in ipairs( getElementsByType( "player" ) ) do
	updateNametagColor( value )
end	