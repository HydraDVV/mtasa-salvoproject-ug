﻿function surprizkutudagit(thePlayer) 
local adminLevel = tonumber(getElementData(thePlayer, "adminlevel"))
    if (adminLevel>=6) then
        for _, oyuncu in ipairs(exports.pool:getPoolElementsByType("player")) do
	     local itemid = 5001 
             gitemid = tonumber(itemid)
            exports.global:giveItem(oyuncu, itemid , 1)
            outputChatBox("#FF0000[!]#ffffff Salvo Roleplay tarafindan sana 1 tane süpriz kutu verildi, /kutuac yazarak ne kazandigina bakabilirsin!.", oyuncu, 255, 0, 0, true) 
        end
	
    else
        outputChatBox("[!]#ffffff Bu islemi yapmak için yetkiniz yok.", thePlayer, 255, 0, 0, true)
    end
end
addCommandHandler("kutudagit", surprizkutudagit)