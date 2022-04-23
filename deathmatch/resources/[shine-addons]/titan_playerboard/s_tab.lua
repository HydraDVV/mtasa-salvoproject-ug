
local scoreboardDummy


addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function ()
	scoreboardDummy = createElement ( "scoreboard" )
	setElementData ( scoreboardDummy, "serverName", "Salvo Roleplay | Salvo:world | www.Salvo-mta.net" )
	setElementData ( scoreboardDummy, "maxPlayers", getMaxPlayers () )
	setElementData ( scoreboardDummy, "allow", true )
	
end, false )


addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), function ()
	if scoreboardDummy then
		destroyElement ( scoreboardDummy )
	end
end, false )
