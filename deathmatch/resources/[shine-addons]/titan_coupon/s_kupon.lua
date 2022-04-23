addCommandHandler("kupon",
	function(thePlayer, cmd, hediyem)
		if not hediyem then
			outputChatBox("[?]#ffffff /kupon *kuponkodu* yazarak hediyenizi alabilirsiniz.", thePlayer, 255, 194, 0, true)
			outputChatBox("[?]#ffffff Girdiğiniz kupon kodu yanlış veya iptal edilmiş.", thePlayer, 255, 194, 0, true) --Değişken			
			return
		end
		if hediyem == "Salvorpg" and not getElementData(resourceRoot, "kupon" .. getElementData(thePlayer, "account:id")) then
		local para = 1000000 --Değişken
			exports.global:giveMoney(thePlayer, para)
			outputChatBox("[Salvo]#f0f0f0 Kuponunuzu kullandınız ve "..para.."₺ kazandınız!", thePlayer, 0, 255, 0, true)
			exports.global:sendMessageToAdmins("KUPON: " .. getPlayerName(thePlayer):gsub("_", " ") .. " adlı kişi kuponunu bozdurdu ve "..para.."₺ kazandı.")
			setElementData(resourceRoot, "kupon" .. getElementData(thePlayer, "account:id"), true)
		else
			outputChatBox("[Salvo]#f0f0f0 Kupon kodunuzu yanlış girdiniz veya daha önce kullandınız.", thePlayer, 255, 0, 0, true)
		end
	end
)