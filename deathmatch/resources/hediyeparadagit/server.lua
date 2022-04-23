function paradagit(player, amount, oyuncu) -- Player, amount,
    if getElementData(player, "account:username") == "REMAJOR" or getElementData(player, "account:username") == "" or getElementData(player, "account:username") == "" or getElementData(player, "account:username") == "REMAJOR" then
        for _, oyuncu in ipairs(exports.pool:getPoolElementsByType("player")) do
	     local para = 10000
            exports.global:giveMoney(oyuncu, para)
      --     outputChatBox("#00FF00[!]#ffffff Salvo Roleplay'den tüm oyuncularına "..para.."TL hediye! İyi Oyunlar Dileriz.", oyuncu, 255, 0, 0, true)
           exports["titan_infobox"]:showInfobox(oyuncu,"error","Geceye özel tüm herkese " .. para .. "₺ Para verilmiştir. ")
			--exports["titan_infobox"]:showInfobox(thePlayer,"error","Salvo Roleplay'den tüm oyuncularına " .. para .. "₺ hediye verilmiştir! İyi Oyunlar Dileriz. ",oyuncu,255,255,255,true)	
		end
	
    else
        outputChatBox("[!]#CC0000 Bu işlemi yapmak için yetkiniz yetmiyor.", thePlayer, 255, 0, 0, true)
    end
end
addCommandHandler("paradagit", paradagit)