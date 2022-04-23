function servertalkprivate(message, sendto)
        --Talk to one client only
	outputChatBox(tostring(message), sendto, msg_red, msg_green, msg_blue, true)
end
 
function servertalk(message)
        --Talk to everyone
	servertalkprivate(message, getRootElement())
end
 
function onJoin()
	servertalkprivate("#01ff00[✯]#FFFFFFSalvo Roleplay'e Hoşgeldiniz.  ", source, 0, 0, 0, true)
	servertalkprivate("#01ff00[✯]#FFFFFFSunucumuz Medium Ekonomiye Sahiptir.  ", source, 0, 0, 0, true)
	servertalkprivate("#01ff00[✯]#FFFFFFHard Roleplay Yapısına Ev Sahipliği Yapmaktadır.  ", source, 0, 0, 0, true)
	servertalkprivate("#01ff00[✯]#FFFFFFwww.Salvoroleplay.com (Bakımda)  ", source, 0, 0, 0, true)
end
 
addEventHandler("onPlayerJoin",getRootElement(),onJoin)