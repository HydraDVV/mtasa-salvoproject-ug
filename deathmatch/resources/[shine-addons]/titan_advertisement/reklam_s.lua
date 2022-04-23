addEvent("reklamGonder", true)
addEventHandler("reklamGonder", root,
function(thePlayer, text)
	outputChatBox("[!]#ffffffReklamınız başarılı bir şekilde yayınlandı.", thePlayer, 0, 255, 0, true)

	exports.global:takeMoney(thePlayer, 15000)
				local playerTel = "Bilgi Yok"
				local telItems = exports["item-system"]:getItems(thePlayer)
				for i, val in ipairs(telItems) do
					if val[1] == 2 then
						playerTel = val[2]
					end
				end
	local advertOwnerName = getPlayerName(thePlayer)
	for i, k in pairs( getElementsByType( 'player' ) ) do
		if exports.global:isPlayerAdmin( k ) then
			outputChatBox( "[A Haber - REKLAM] "..text..".", k, 0, 255, 0 )
			outputChatBox( "#D2B48C[İLETİŞİM] #ffffff" .. getPlayerName(thePlayer):gsub("_", " ") .. " | Tel: " .. playerTel .. "", k, 0, 0, 0, true)
			outputChatBox( "[!]#B22222 Son reklamın sahibi: ".. getPlayerName(thePlayer) .." ("..getElementData( thePlayer, 'account:username' )..") ID:"..getElementData(thePlayer, "playerid")..".", k, 255, 255, 0, true )
		else
			outputChatBox( "#00FFFF[A Haber - REKLAM]#00FFFF"..text..".", k, 0, 0, 0, true )
			outputChatBox( "#D2B48C[İLETİŞİM] #ffffff" .. getPlayerName(thePlayer):gsub("_", " ") .. " | Tel: " .. playerTel .. "", k, 0, 0, 0, true )
		end
	end
end
)