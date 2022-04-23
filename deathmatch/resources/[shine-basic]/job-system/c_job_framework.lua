job = 0
localPlayer = getLocalPlayer()


function playerSpawn()
	local logged = getElementData(localPlayer, "loggedin")

	if (logged==1) then
		job = tonumber(getElementData(localPlayer, "job"))
		if (job==1) then -- TRUCKER
			exports["job-system-trucker"]:displayTruckerJob()
		else
			exports["job-system-trucker"]:resetTruckerJob()
		end
		
		if (job==2) then -- TAXI
			displayTaxiJob()
		else
			resetTaxiJob()
		end
		
		if (job==3) then -- BUS
			displayBusJob()
		else
			resetBusJob()
		end
		
		if (job==11) then -- Kamyon
			kamyonBlip()
		end
	
		if (job==12) then -- Kamyon
			tirBlip()
		end
		
		if (job==14) then -- Beton
			betonBlip()
		end
		
		if (job==15) then -- Deniz Taşımacılığı
		
		end
	end
end
addEventHandler("onClientPlayerSpawn", localPlayer, 
	function()
		setTimer(playerSpawn, 1000, 1)
	end
)

function quitJob(job)
	if (job==1) then -- TRUCKER JOB
	    exports["job-system-trucker"]:resetTruckerJob()
		outputChatBox("[!] #FFFFFFKargoculuk mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==2) then -- TAXI JOB
		resetTaxiJob()
		outputChatBox("[!] #FFFFFFTaksicilik mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==3) then -- BUS JOB
		resetBusJob()
		outputChatBox("[!] #FFFFFFOtobüs şoförlüğü mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==4) then -- CITY MAINTENANCE
		outputChatBox("[!] #FFFFFFŞehir temizlikçisi mesleğinden istifa ettiniz.", 0, 255, 0, true)
		triggerServerEvent("cancelCityMaintenance", localPlayer)
	elseif (job==5) then -- MECHANIC
		outputChatBox("[!] #FFFFFFTamirci mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==6) then -- LOCKSMITH
		outputChatBox("[!] #FFFFFFÇilingir mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==8) then -- SİGARA KAÇAKÇILIĞI
		outputChatBox("[!] #FFFFFFSigara kaçakçılığı mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==9) then -- İÇKİ KAÇAKÇILIĞI
		outputChatBox("[!] #FFFFFFİçki kaçakçılığı mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==10) then -- TIR
		outputChatBox("[!] #FFFFFFTır şoförlüğü mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==11) then -- KAMYON
		outputChatBox("[!] #FFFFFFKamyon şoförlüğü mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==14) then -- BETON
		outputChatBox("[!] #FFFFFFBeton Taşımacılığı şoförlüğü mesleğinden istifa ettiniz.", 0, 255, 0, true)
	elseif (job==15) then -- DENİZ
		outputChatBox("[!] #FFFFFFDeniz Taşımacılığı şoförlüğü mesleğinden istifa ettiniz.", 0, 255, 0, true)
	end
end
addEvent("quitJob", true)
addEventHandler("quitJob", getLocalPlayer(), quitJob)