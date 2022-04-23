mysql = exports.mysql
-- /aclikayarla + Admin+
function setHunger(thePlayer, commandName, targetPlayerName, hunger)
	if exports.global:isPlayerAdmin(thePlayer) then
		if not targetPlayerName or not hunger then
			outputChatBox("Kullanımı: #ffffff/" .. commandName .. " [İsim/ID] [Açlık Seviyesi]", thePlayer, 255, 194, 14, true)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
			if not targetPlayer then
			elseif getElementData( targetPlayer, "loggedin" ) ~= 1 then
				outputChatBox( "[!]#D6D6D6Oyuncu karaktere giriş yapmadı!", thePlayer, 255, 0, 0, true)
			else
                mysql:query_free("UPDATE characters SET hunger = "..tonumber(hunger).." WHERE id = " .. mysql:escape_string(getElementData( targetPlayer, "dbid" )) )							
				setElementData(targetPlayer, "hunger", tonumber(hunger))
				outputChatBox("[!]#D6D6D6".. targetPlayerName .. " adlı oyuncunun açlığını " .. hunger .. " yaptın.", thePlayer, 0, 255, 0, true)
				outputChatBox("[!]#D6D6D6Açlığınız yetkili tarafından " .. hunger .. " yapılmıştır.", targetPlayer, 0, 255, 0, true)
			end
		end
	end
end
addCommandHandler("aclikayarla", setHunger)

-- /susuzlukayarla +Admin+
function setThirst(thePlayer, commandName, targetPlayerName, thirst)
	if exports.global:isPlayerAdmin(thePlayer) then
		if not targetPlayerName or not thirst then
			outputChatBox("Kullanımı: #ffffff/" .. commandName .. " [İsim/ID] [Susuzluk Seviyesi]", thePlayer, 255, 194, 14, true)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
			if not targetPlayer then
			elseif getElementData( targetPlayer, "loggedin" ) ~= 1 then
				outputChatBox( "[!]#D6D6D6Oyuncu karaktere giriş yapmadı!", thePlayer, 255, 0, 0, true)
			else
            mysql:query_free("UPDATE characters SET thirst = "..tonumber(thirst).." WHERE id = " .. mysql:escape_string(getElementData( targetPlayer, "dbid" )) )				
			setElementData(targetPlayer, "thirst", tonumber(thirst))
				outputChatBox("[!]#D6D6D6".. targetPlayerName .. " adlı oyuncunun susuzluğunu " .. thirst .. " yaptın.", thePlayer, 0, 255, 0, true)
				outputChatBox("[!]#D6D6D6Susuzluğunuz yetkili tarafından " .. thirst .. " yapılmıştır.", targetPlayer, 0, 255, 0, true)
			end
		end
	end
end
addCommandHandler("susuzlukayarla", setThirst)
