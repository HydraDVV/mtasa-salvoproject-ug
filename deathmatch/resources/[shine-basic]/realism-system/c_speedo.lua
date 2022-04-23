bindKey("x", "down", "cam")
bindKey("F5", "down", "seatbelt")
bindKey("c", "down", "cc")

addEvent("addWindow", true)
addEventHandler("addWindow", getRootElement(), 
	function ()
		if source == getLocalPlayer() then
			addEventHandler("onClientRender", getRootElement(), drawWindow)
		end
	end
)

addEvent("removeWindow", true)
addEventHandler("removeWindow", getRootElement(), 
	function ()
		if source == getLocalPlayer() then
			removeEventHandler("onClientRender", getRootElement(), drawWindow)
		end
	end
)