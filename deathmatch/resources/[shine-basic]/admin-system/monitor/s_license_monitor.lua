addCommandHandler( "licensemonitor",
	function( player )
		if exports.global:isPlayerSuperAdmin(player) then
			local result = mysql:query( "SELECT charactername, gun_license, gun2_license, lastlogin FROM characters WHERE gun_license='1' OR gun2_license='1' ORDER BY lastlogin DESC, charactername ASC" )
			if result then
				local t = { }
				while true do
					local row = mysql:fetch_assoc( result )
					if row then
						table.insert(t, { row.charactername, row.gun_license, row.gun2_license, row.lastlogin })
					else
						break
					end
				end
				mysql:free_result( result )
				triggerClientEvent( player, "admin:licenses", player, t )
			end
		end
	end
)