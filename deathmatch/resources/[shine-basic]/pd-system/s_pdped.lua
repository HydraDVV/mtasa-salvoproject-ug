addEvent("lspd:ped:start", true)
function lspdPedStart(pedName)
	exports['global']:sendLocalText(client, "Mike Moore says: Merhaba Size Nas�l Yard�mc� Olabilirim ?", 255, 255, 255, 10)
end
addEventHandler("lspd:ped:start", getRootElement(), lspdPedStart)

addEvent("lspd:ped:help", true)
function lspdPedHelp(pedName)
	exports['global']:sendLocalText(client,"Mike Moore says: Tamam,Hemen Haber Veriyorum Sakin Olun Oturun L�tfen.", 255, 255, 255, 10)
	for key, value in ipairs( getPlayersInTeam( getTeamFromName("Los Santos Police Department") ) ) do
	outputChatBox("[RADIO] Su� �hbar Etmek �steyen Bir Vatanda� Var Bilginize. ((" .. getPlayerName(client):gsub("_"," ") .. "))", value, 0, 183, 239)
	end
end
addEventHandler("lspd:ped:help", getRootElement(), lspdPedHelp)

addEvent("lspd:ped:appointment", true)
function lspdPedAppointment(pedName)
	exports['global']:sendLocalText(client, "Mike Moore says: �imdi G�revlileri Uyaraca��z Oturun.", 255, 255, 255, 10)
	for key, value in ipairs( getPlayersInTeam( getTeamFromName("Los Santos Police Department") ) ) do
		outputChatBox("[RADIO] Su�unu �tiraf Etmek �steyen Biri Var Merkeze Gelebilecek Bir Polis Memuru Varsa Hemen �ntikal Etsin.((" .. getPlayerName(client):gsub("_"," ") .. "))", value, 0, 183, 239)
	end
end
addEventHandler("lspd:ped:appointment", getRootElement(), lspdPedAppointment)