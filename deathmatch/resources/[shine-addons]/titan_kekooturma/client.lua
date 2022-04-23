local ifp = engineLoadIFP( "otur.ifp", "keko" )

addEvent( "keko", true )
addEventHandler( "keko", root,
	function(enable)
		if (enable) then setPedAnimation(source, "keko", "WEAPON_crouch", -1, true, false)
		else setPedAnimation(source)
		end		
	end
)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        triggerServerEvent("onClientSync", resourceRoot)
	end
)

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		if ifp then
			for _,player in ipairs(getElementsByType("player")) do
				local _, otur = getPedAnimation(player)
				if (otur == "WEAPON_crouch") then
					setPedAnimation(player)
				end
			end
			destroyElement(ifp)
		end
	end
)


-- SparroW MTA : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İnstagram : https://www.instagram.com/sparrowmta/
-- Discord : https://discord.gg/DzgEcvy