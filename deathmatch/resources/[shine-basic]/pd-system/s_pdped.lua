addEvent("lspd:ped:start", true)
function lspdPedStart(pedName)
	exports['global']:sendLocalText(client, "Mike Moore says: Merhaba Size Nasýl Yardýmcý Olabilirim ?", 255, 255, 255, 10)
end
addEventHandler("lspd:ped:start", getRootElement(), lspdPedStart)

addEvent("lspd:ped:help", true)
function lspdPedHelp(pedName)
	exports['global']:sendLocalText(client,"Mike Moore says: Tamam,Hemen Haber Veriyorum Sakin Olun Oturun Lütfen.", 255, 255, 255, 10)
	for key, value in ipairs( getPlayersInTeam( getTeamFromName("Los Santos Police Department") ) ) do
	outputChatBox("[RADIO] Suç Ýhbar Etmek Ýsteyen Bir Vatandaþ Var Bilginize. ((" .. getPlayerName(client):gsub("_"," ") .. "))", value, 0, 183, 239)
	end
end
addEventHandler("lspd:ped:help", getRootElement(), lspdPedHelp)

addEvent("lspd:ped:appointment", true)
function lspdPedAppointment(pedName)
	exports['global']:sendLocalText(client, "Mike Moore says: Þimdi Görevlileri Uyaracaðýz Oturun.", 255, 255, 255, 10)
	for key, value in ipairs( getPlayersInTeam( getTeamFromName("Los Santos Police Department") ) ) do
		outputChatBox("[RADIO] Suçunu Ýtiraf Etmek Ýsteyen Biri Var Merkeze Gelebilecek Bir Polis Memuru Varsa Hemen Ýntikal Etsin.((" .. getPlayerName(client):gsub("_"," ") .. "))", value, 0, 183, 239)
	end
end
addEventHandler("lspd:ped:appointment", getRootElement(), lspdPedAppointment)