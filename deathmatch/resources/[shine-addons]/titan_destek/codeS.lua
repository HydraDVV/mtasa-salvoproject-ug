function destekac(thePlayer, myBlip)
if getElementData(thePlayer, "faction")==1 then 
if getElementData(thePlayer,"destekbind")==0 or getElementData(thePlayer,"destekbind")==false then
      setElementData(thePlayer, "destek", 1 )
      setElementData(thePlayer, "destekbind", 1 )
local myBlip = createBlipAttachedTo (thePlayer, 12 )
 setElementVisibleTo (myBlip, root, false)
for k, v in ipairs(getPlayersInTeam(getTeamFromName ("İstanbul İl Emniyet Mudurlugu"))) do 
setElementVisibleTo (myBlip, v, true)
local username = getPlayerName(thePlayer)
local rank = getElementData(thePlayer, "factionrank")
if getElementData(thePlayer, "faction")==1 then 
if rank == 1 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC İzinli " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 2 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur I " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 3 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur II " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 4 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 5 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III+I  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 6 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif I  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 7 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif II  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 8 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif III  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 9 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş I  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 10 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş II  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 11 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen I  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 12 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen II  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 13 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen III  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 14 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı I " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 15 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı II  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 16 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı III  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 17 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Komtan  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 18 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Asistanı " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 19 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Yardımcısı  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
else
if rank == 20 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Polis Şefi  " .. username:gsub("_", " ") .. " destek talebi açtı!", v, 50, 125, 200, true)
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
else
      setElementData(thePlayer, "destek", 0 )
      setElementData(thePlayer, "destekbind", 0 ) 
	 for k, v in ipairs(getPlayersInTeam(getTeamFromName ("İstanbul İl Emniyet Mudurlugu"))) do
	 local username = getPlayerName(thePlayer)
local rank = getElementData(thePlayer, "factionrank")
if rank == 1 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC İzinli " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 2 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur I " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 3 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur II " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 4 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 5 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III+I  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 6 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif I  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 7 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif II  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 8 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif III  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 9 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş I  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 10 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş II  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 11 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen I  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 12 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen II  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 13 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen III  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 14 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı I " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 15 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı II  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 16 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı III  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 17 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Komtan  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 18 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Asistanı " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 19 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Yardımcısı  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
else
if rank == 20 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Polis Şefi  " .. username:gsub("_", " ") .. " destek talebini kaldırdı!", v, 50, 125, 200, true)
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
    local attachedElements = getAttachedElements(thePlayer) 
    if attachedElements then 
        for i, attachedElement in ipairs(attachedElements) do 
            if getElementType(attachedElement) == "blip" then 
                destroyElement(attachedElement) 
            end 
        end 
    end 
end 
end
end
addCommandHandler("destek", destekac)

function takipac(thePlayer, myBlip)
if getElementData(thePlayer, "faction")==1 then 
if getElementData(thePlayer,"takip")==0 or getElementData(thePlayer,"takip")==false then
      setElementData(thePlayer, "takip", 1 )
      setElementData(thePlayer, "takipbind", 1 )
local myBlip = createBlipAttachedTo (thePlayer, 16 )
 setElementVisibleTo (myBlip, root, false)
for k, v in ipairs(getPlayersInTeam(getTeamFromName ("İstanbul İl Emniyet Mudurlugu"))) do 
setElementVisibleTo (myBlip, v, true)
local username = getPlayerName(thePlayer)
local rank = getElementData(thePlayer, "factionrank")
if getElementData(thePlayer, "faction")==1 then 
if rank == 1 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC İzinli " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 2 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur I " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 3 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur II " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 4 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 5 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III+I  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 6 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif I  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 7 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif II  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 8 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif III  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 9 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş I  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 10 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş II  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 11 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen I  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 12 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen II  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 13 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen III  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 14 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı I " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 15 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı II  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 16 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı III  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 17 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Komtan  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 18 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Asistanı " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 19 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Yardımcısı  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
else
if rank == 20 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Polis Şefi  " .. username:gsub("_", " ") .. " takip ettiğini belirtti!", v, 50, 125, 200, true)
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
else
      setElementData(thePlayer, "takip", 0 )
      setElementData(thePlayer, "takipbind", 0 ) 
     for k, v in ipairs(getPlayersInTeam(getTeamFromName ("Los Santos Police Department"))) do 
	 local username = getPlayerName(thePlayer)
local rank = getElementData(thePlayer, "factionrank")
if rank == 1 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC İzinli " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 2 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur I " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 3 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur II " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 4 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 5 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Memur III+I  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 6 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif I  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 7 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif II  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 8 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Dedektif III  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 9 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş I  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 10 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Çavuş II  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 11 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen I  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 12 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen II  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 13 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Teğmen III  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 14 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı I " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 15 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı II  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 16 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Yüzbaşı III  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 17 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Komtan  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 18 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Asistanı " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 19 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Şef Yardımcısı  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
else
if rank == 20 then
outputChatBox("#FF0000[#FFFFFFOPERATOR#FF0000]#6699CC Polis Şefi  " .. username:gsub("_", " ") .. " takip etmeyi bıraktı!", v, 50, 125, 200, true)
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
    local attachedElements = getAttachedElements(thePlayer) 
    if attachedElements then 
        for i, attachedElement in ipairs(attachedElements) do 
            if getElementType(attachedElement) == "blip" then 
                destroyElement(attachedElement) 
            end 
        end 
    end 
end 
end
end
addCommandHandler("takip", takipac)




function telsizChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
 if(logged==1) and getElementData(thePlayer, "faction")==1   then
		if not (...) then
			outputChatBox("KOMUT: /telsiz [Mesaj]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local username = getPlayerName(thePlayer)
for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("İstanbul İl Emniyet Mudurlugu"))) do 
				if getElementData(thePlayer, "faction")==1 then
					table.insert(affectedElements, arrayPlayer)
					local rank = getElementData(thePlayer, "factionrank")
					if rank == 1 then
					outputChatBox("[TELSIZ] İzinli " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 2 then
					outputChatBox("[TELSIZ] Memur I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 3 then
					outputChatBox("[TELSIZ] Memur II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 4 then
					outputChatBox("[TELSIZ] Memur III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 5 then
					outputChatBox("[TELSIZ] Memur III+I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 6 then
					outputChatBox("[TELSIZ] Dedektif I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 7 then
					outputChatBox("[TELSIZ] Dedektif II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 8 then
					outputChatBox("[TELSIZ] Dedektif III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 9 then
					outputChatBox("[TELSIZ] Çavuş I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 10 then
					outputChatBox("[TELSIZ] Çavuş II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 11 then
					outputChatBox("[TELSIZ] Teğmen I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 12 then
					outputChatBox("[TELSIZ] Teğmen II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 13 then
					outputChatBox("[TELSIZ] Teğmen III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 14 then
					outputChatBox("[TELSIZ] Yüzbaşı I" .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 15 then
					outputChatBox("[TELSIZ] Yüzbaşı II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 16 then
					outputChatBox("[TELSIZ] Yüzbaşı III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 17 then
					outputChatBox("[TELSIZ] Komtan " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 18 then
					outputChatBox("[TELSIZ] Şef Asistanı " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 19 then
					outputChatBox("[TELSIZ] Şef Yardımcısı " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 20 then
					outputChatBox("[TELSIZ] Polis Şefi " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
				end
			end
			exports.logs:dbLog(thePlayer, 3, affectedElements, message)
		end
	end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
addCommandHandler("telsiz", telsizChat, false, false)

function yakatelsizChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
 if(logged==1) and getElementData(thePlayer, "faction")==1   then
		if not (...) then
			outputChatBox("KOMUT: /telsiz [Mesaj]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local username = getPlayerName(thePlayer)
for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("İstanbul İl Emniyet Mudurlugu"))) do 
				if getElementData(thePlayer, "faction")==1 then
					table.insert(affectedElements, arrayPlayer)
					local rank = getElementData(thePlayer, "factionrank")
					if rank == 1 then
					outputChatBox("[YAKA TELSIZ] İzinli " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 2 then
					outputChatBox("[YAKA TELSIZ] Memur I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 3 then
					outputChatBox("[YAKA TELSIZ] Memur II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 4 then
					outputChatBox("[YAKA TELSIZ] Memur III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 5 then
					outputChatBox("[YAKA TELSIZ] Memur III+I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 6 then
					outputChatBox("[YAKA TELSIZ] Dedektif I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 7 then
					outputChatBox("[YAKA TELSIZ] Dedektif II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 8 then
					outputChatBox("[YAKA TELSIZ] Dedektif III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 9 then
					outputChatBox("[YAKA TELSIZ] Çavuş I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 10 then
					outputChatBox("[YAKA TELSIZ] Çavuş II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 11 then
					outputChatBox("[YAKA TELSIZ] Teğmen I " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 12 then
					outputChatBox("[YAKA TELSIZ] Teğmen II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 13 then
					outputChatBox("[YAKA TELSIZ] Teğmen III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 14 then
					outputChatBox("[YAKA TELSIZ] Yüzbaşı I" .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 15 then
					outputChatBox("[YAKA TELSIZ] Yüzbaşı II " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 16 then
					outputChatBox("[YAKA TELSIZ] Yüzbaşı III " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 17 then
					outputChatBox("[YAKA TELSIZ] Komtan " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 18 then
					outputChatBox("[YAKA TELSIZ] Şef Asistanı " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 19 then
					outputChatBox("[YAKA TELSIZ] Şef Yardımcısı " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					else
					if rank == 20 then
					outputChatBox("[YAKA TELSIZ] Polis Şefi " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
				end
			end
			exports.logs:dbLog(thePlayer, 3, affectedElements, message)
		end
	end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
addCommandHandler("yk", yakatelsizChat, false, false)