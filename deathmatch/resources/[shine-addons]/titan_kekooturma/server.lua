local animEnable = {}
local syncPlayers = {}

addCommandHandler("keko",
	function(player)
		if (not animEnable[player]) then
			animEnable[player] = true
			triggerClientEvent(syncPlayers, "keko", player, true)
			outputChatBox("[!]#FFFFFF Oturuyorsun.", player, 0, 255, 0, true)
		else
			animEnable[player] = false
			triggerClientEvent(syncPlayers, "keko", player, false)
			outputChatBox("[!]#FFFFFF Artık oturmuyorusun.", player, 255, 0, 0, true)
		end
	end
)

addEvent("onClientSync", true )
addEventHandler("onClientSync", resourceRoot,
    function()
        table.insert(syncPlayers, client)
		for player, enable in ipairs(animEnable) do
			if (enable) then
				triggerClientEvent(client, "keko", player, true)
			end
		end
    end 
)

addEventHandler("onPlayerQuit", root,
    function()
        for i, player in ipairs(syncPlayers) do
            if source == player then 
                table.remove(syncPlayers, i)
                break
            end 
        end
        if (animEnable[source] == true or animEnable[source] == false) then animEnable[source] = nil end
    end
)


-- SparroW MTA : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İnstagram : https://www.instagram.com/sparrowmta/
-- Discord : https://discord.gg/DzgEcvy