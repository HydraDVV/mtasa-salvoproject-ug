wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelp, wHelp, lNameCheck, lLengthCheck, bSubmitAdminReport, bSubmitGMReport , lPlayerName, reportedPlayer, tPlayerName, lReport, tReport, tHelpMessage, bGMHelp = nil

function resourceStop()
	guiSetInputEnabled(false)
	showCursor(false)
end
addEventHandler("onClientResourceStop", getResourceRootElement(), resourceStop)

function resourceStart()
	bindKey("F2", "down", toggleReport)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), resourceStart)

function toggleReport()
	executeCommandHandler("report")
	if wHelp then
	guiSetInputEnabled(false)
	showCursor(false)
	destroyElement(wHelp)
	wHelp = nil
	end
end

function checkBinds()
	if ( exports.global:isPlayerAdmin(getLocalPlayer()) or getElementData( getLocalPlayer(), "account:gmlevel" )  ) then
		if getBoundKeys("ar") or getBoundKeys("acceptreport") then
			--outputChatBox("You had keys bound to accept reports. Please delete these binds.", 255, 0, 0)
			triggerServerEvent("arBind", getLocalPlayer())
		end
	end
end
setTimer(checkBinds, 60000, 0)

local function scale(w)
	local width, height = guiGetSize(w, false)
	local screenx, screeny = guiGetScreenSize()
	local minwidth = math.min(700, screenx)
	if width < minwidth then
		guiSetSize(w, minwidth, height / width * minwidth, false)
		local width, height = guiGetSize(w, false)
		guiSetPosition(w, (screenx - width) / 2, (screeny - height) / 2, false)
	end
end

function showReportMainUI()
	local logged = getElementData(getLocalPlayer(), "loggedin")
	if (logged==1) then
		if (wReportMain==nil) and (wHelp==nil) then
			reportedPlayer = nil
			wReportMain = guiCreateWindow(0.2, 0.2, 0.1, 0.175, "SalvoMTA - Rapor", true)
			scale(wReportMain)

			-- Controls within the window
			bClose = guiCreateButton(0.85, 0.9, 0.2, 0.1, "Kapat", true, wReportMain)
			addEventHandler("onClientGUIClick", bClose, clickCloseButton)
			
			-- Admin help related
			lHelp = guiCreateLabel(0.125, 0.10, 1.0, 0.1, "Admin RAPORU", true, wReportMain)
			guiSetFont(lHelp, "default-bold-small")
			lHelpAbout = guiCreateLabel(0.125, 0.15, 0.75, 0.6, "Arac sorunlarinizi, Izlenmesi gereken bir rol varsa, Herhangi biroyun BUG'u varsa Admin Raporu atiniz.", true, wReportMain)
			guiLabelSetHorizontalAlign(lHelpAbout, "left", true)
			--  roleplay, gameplay and character
			bHelpAdmin = guiCreateButton(0.125, 0.280, 0.75, 0.10, "Admin RAPORU", true, wReportMain)
			addEventHandler("onClientGUIClick", bHelpAdmin, adminReportUI)
			
			-- GM help related
			lGMHelp = guiCreateLabel(0.125, 0.40, 1.0, 0.1, "Helper RAPORU", true, wReportMain)
			guiSetFont(lGMHelp, "default-bold-small")
			lGMHelpAbout = guiCreateLabel(0.125, 0.45, 0.75, 0.6, "Roleplay nedir? , Roleplay nasıl yapılmalıdır? , Rol derslerini , oyun kurallarınu , öğrenmek istediğiniz komutları buradan öğrenebilirsiniz.", true, wReportMain)
			guiLabelSetHorizontalAlign(lGMHelpAbout, "left", true)
			--  
			bGMHelp = guiCreateButton(0.125, 0.580, 0.75, 0.10, "GameMaster RAPORU", true, wReportMain)
			addEventHandler("onClientGUIClick", bGMHelp, gmReportUI)
			
			-- Bug help
			lBug = guiCreateLabel(0.125, 0.75, 1.0, 0.1, "Diğer her türlü bilgilere ;", true, wReportMain)
			guiSetFont(lBug, "default-bold-small")
			lBugAbout = guiCreateLabel(0.125, 0.80, 0.75, 0.8, "Sitemizden www.Salvoroleplay.com'dan bize ulaşabilirsiniz..", true, wReportMain)
			guiLabelSetHorizontalAlign(lBugAbout, "left", true)
			
			guiWindowSetSizable(wReportMain, false)
			--guiBringToFront(wReportMain)
			showCursor(true)
		elseif (wReportMain~=nil) then
			guiSetVisible(wReportMain, false)
			destroyElement(wReportMain)
			
			wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelp = nil
			guiSetInputEnabled(false)
			showCursor(false)
		end
	end
end
addCommandHandler("report", showReportMainUI)

-- GM Report UI
function gmReportUI(button, state)
	if source == bGMHelp then
		local adminreport = getElementData(getLocalPlayer(), "adminreport")
		local gmreport = getElementData(getLocalPlayer(), "gmreport")
		-- outputDebugString(adminreport or "false")
		-- outputDebugString(gmreport or "false")
		if adminreport or gmreport then
			guiSetText(wReportMain, "Rapor ID #" .. (adminreport or gmreport).. " hala beklemededir.Beklemek istemiyorsanız /er ile raporunuzu sonlandırabilirsiniz.")
		else
			if (source==bGMHelp) and (button=="left") and (state=="up") then
				if (wHelp==nil) then
					destroyElement(wReportMain)
					wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelp, reportedPlayer = nil
					guiSetInputEnabled(true)
					
					wHelp = guiCreateWindow(0.2, 0.2, 0.2, 0.175, "GM Report", true)
					guiWindowSetSizable(wHelp, false)
					scale(wHelp)
					--guiSetAlpha(wHelp, 0.6)
					
					-- Controls within the window
					bClose = guiCreateButton(0.85, 0.9, 0.2, 0.1, "Kapat", true, wHelp)
					guiSetEnabled(bClose, true)
					addEventHandler("onClientGUIClick", bClose, clickCloseButton)
					
					lPlayerName = guiCreateLabel(0.025, 0.12, 1.0, 0.3, "Lutfen report etmek istediginiz oyuncunun nickini/id sini ve sebebini yazin", true, wHelp)
					--guiSetFont(lPlayerName, "default-bold-small")
					
					--tPlayerName = guiCreateEdit(0.425, 0.11, 0.25, 0.08, "Firstname_Lastname", true, wHelp)
					
					--lNameCheck = guiCreateLabel(0.425, 0.2, 1.0, 0.3, "Player not found or multiple were found.", true, wHelp)
					--guiSetFont(lNameCheck, "default-bold-small")
					--guiLabelSetColor(lNameCheck, 255, 0, 0)
					--addEventHandler("onClientGUIChanged", tPlayerName, checkNameExists)
					
					lReport = guiCreateLabel(0.025, 0.3, 1.0, 0.3, "Adi:\n- Playername\n- Aciklama", true, wHelp)
					guiSetFont(lPlayerName, "default-bold-small")
					
					tReport = guiCreateMemo(0.225, 0.29, 0.75, 0.5, "", true, wHelp)
					--guiMemoSetReadOnly(tReport, false)
					addEventHandler("onClientGUIChanged", tReport, checkReportLength)
					
					lLengthCheck = guiCreateLabel(0.4, 0.81, 0.4, 0.3, "Uzunluk: " .. string.len(tostring(guiGetText(tReport)))-1 .. "/150 Karakter.", true, wHelp)
					guiLabelSetColor(lLengthCheck, 0, 255, 0)
					guiSetFont(lLengthCheck, "default-bold-small")
					
					bSubmitGMReport = guiCreateButton(0.4, 0.875, 0.2, 0.1, "Raporu Yolla", true, wHelp)
					addEventHandler("onClientGUIClick", bSubmitGMReport, gmSubmitReport)
					guiSetEnabled(bSubmitGMReport, false)
				end
			end
		end
	end
end

-- Admin Report UI
function adminReportUI(button, state)
	if source == bHelpAdmin then
		local adminreport = getElementData(getLocalPlayer(), "adminreport")
		local gmreport = getElementData(getLocalPlayer(), "gmreport")
		-- outputDebugString(adminreport or "false")
		-- outputDebugString(gmreport or "false")
		if adminreport or gmreport then
			guiSetText(wReportMain, "Rapor ID #" .. (adminreport or gmreport).. " hala beklemede.Lutfen bekleyin veya /er yazarak report u kapayin.")
			--outputChatBox("Your Admin Report ID #" .. report .. " is still pending. Please wait or /er before submitting another.", getLocalPlayer(), 255, 0, 0)
			-- if (wReportMain~=nil) then
				-- destroyElement(wReportMain)
			-- end
			
			-- if (wHelp) then
				-- destroyElement(wHelp)
			-- end
			
			--wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelpAdmin, wHelp, lNameCheck, bSubmitGMReport, lPlayerName, reportedPlayer, tPlayerName, lReport, tReport, tHelpMessage = nil
			--guiSetInputEnabled(false)
			--showCursor(false)
		else
			if (source==bHelpAdmin) and (button=="left") and (state=="up") then
				if (wHelp==nil) then
					destroyElement(wReportMain)
					wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelpAdmin, reportedPlayer = nil
					guiSetInputEnabled(true)
					
					wHelp = guiCreateWindow(0.2, 0.2, 0.2, 0.175, "Admin Report", true)
					guiWindowSetSizable(wHelp, false)
					scale(wHelp)
					--guiSetAlpha(wHelp, 0.6)
					
					-- Controls within the window
					bClose = guiCreateButton(0.85, 0.9, 0.2, 0.1, "Kapat", true, wHelp)
					guiSetEnabled(bClose, true)
					addEventHandler("onClientGUIClick", bClose, clickCloseButton)
					
					lPlayerName = guiCreateLabel(0.025, 0.12, 1.0, 0.3, "Report etmek istedigin oyuncu(Opsiyonel):", true, wHelp)
					guiSetFont(lPlayerName, "default-bold-small")
					
					tPlayerName = guiCreateEdit(0.425, 0.11, 0.25, 0.08, "Oyuncu Ismi / ID", true, wHelp)
					addEventHandler("onClientGUIClick", tPlayerName, function()
						guiSetText(tPlayerName,"")
					end, false)
					
					lNameCheck = guiCreateLabel(0.425, 0.2, 1.0, 0.3, "Kendini report ediyorsun !.", true, wHelp)
					guiSetFont(lNameCheck, "default-bold-small")
					guiLabelSetColor(lNameCheck, 0, 255, 0)
					addEventHandler("onClientGUIChanged", tPlayerName, checkNameExists)
					
					lReport = guiCreateLabel(0.025, 0.3, 1.0, 0.3, "Report Bilgisi:", true, wHelp)
					guiSetFont(lPlayerName, "default-bold-small")
					
					tReport = guiCreateMemo(0.225, 0.29, 0.75, 0.5, "", true, wHelp)
					--guiMemoSetReadOnly(tReport, true)
					addEventHandler("onClientGUIChanged", tReport, checkReportLength)
					
					lLengthCheck = guiCreateLabel(0.4, 0.81, 0.4, 0.3, "Uzunluk: " .. string.len(tostring(guiGetText(tReport)))-1 .. "/150 Karakter.", true, wHelp)
					guiLabelSetColor(lLengthCheck, 0, 255, 0)
					guiSetFont(lLengthCheck, "default-bold-small")
					
					bSubmitAdminReport = guiCreateButton(0.4, 0.875, 0.2, 0.1, "Raporu yolla", true, wHelp)
					addEventHandler("onClientGUIClick", bSubmitAdminReport, submitAdminReport)
					guiSetEnabled(bSubmitAdminReport, false)
					bSubmitGMReport = nil
				end
			end
		end
	end
end

function submitAdminReport(button, state)
	if (source==bSubmitAdminReport) and (button=="left") and (state=="up") then
		triggerServerEvent("clientSendReport", getLocalPlayer(), reportedPlayer or getLocalPlayer(), tostring(guiGetText(tReport))) 
		
		if (wReportMain~=nil) then
			destroyElement(wReportMain)
		end
		
		if (wHelp) then
			destroyElement(wHelp)
		end
		
		wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelpAdmin, wHelp, lNameCheck, bSubmitAdminReport, lPlayerName, reportedPlayer, tPlayerName, lReport, tReport, tHelpMessage = nil
		guiSetInputEnabled(false)
		showCursor(false)
	end
end

function gmSubmitReport(button, state)
	if (source==bSubmitGMReport) and (button=="left") and (state=="up") then
		triggerServerEvent("GMclientSendReport", getLocalPlayer(), tostring(guiGetText(tReport))) 
		
		if (wReportMain~=nil) then
			destroyElement(wReportMain)
		end
		
		if (wHelp) then
			destroyElement(wHelp)
		end
		
		wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelp, wHelp, lNameCheck, bSubmitGMReport, lPlayerName, reportedPlayer, tPlayerName, lReport, tReport, tHelpMessage = nil
		guiSetInputEnabled(false)
		showCursor(false)
	end
end

function checkReportLength(theEditBox)
	guiSetText(lLengthCheck, "Uzunluk: " .. string.len(tostring(guiGetText(tReport)))-1 .. "/150 Karakter.")

	if (tonumber(string.len(tostring(guiGetText(tReport))))-1>150) then
		guiLabelSetColor(lLengthCheck, 255, 0, 0)
		if bSubmitAdminReport then
			guiSetEnabled(bSubmitAdminReport, false)
		end
		if bSubmitGMReport then
			guiSetEnabled(bSubmitGMReport, false)
		end
	elseif (tonumber(string.len(tostring(guiGetText(tReport))))-1<3) then
		guiLabelSetColor(lLengthCheck, 255, 0, 0)
		if bSubmitAdminReport then
			guiSetEnabled(bSubmitAdminReport, false)
		end
		if bSubmitGMReport then
			guiSetEnabled(bSubmitGMReport, false)
		end
	elseif (tonumber(string.len(tostring(guiGetText(tReport))))-1>130) then
		guiLabelSetColor(lLengthCheck, 255, 255, 0)
		if bSubmitAdminReport then
			guiSetEnabled(bSubmitAdminReport, true)
		end
		if bSubmitGMReport then
			guiSetEnabled(bSubmitGMReport, true)
		end
	else
		guiLabelSetColor(lLengthCheck,0, 255, 0)
		if bSubmitAdminReport then
			guiSetEnabled(bSubmitAdminReport, true)
		end
		if bSubmitGMReport then
			guiSetEnabled(bSubmitGMReport, true)
		end
	end
end
	

function checkNameExists(theEditBox)
	local found = nil
	local count = 0
	
	
	local text = guiGetText(theEditBox)
	if text and #text > 0 then
		local players = getElementsByType("player")
		if tonumber(text) then
			local id = tonumber(text)
			for key, value in ipairs(players) do
				if getElementData(value, "playerid") == id then
					found = value
					count = 1
					break
				end
			end
		else
			for key, value in ipairs(players) do
				local username = string.lower(tostring(getPlayerName(value)))
				if string.find(username, string.lower(text)) then
					count = count + 1
					found = value
					break
				end
			end
		end
	end
	
	if (count>1) then
		guiSetText(lNameCheck, "Birden fazla bulundu..")
		guiLabelSetColor(lNameCheck, 255, 255, 0)
	elseif (count==1) then
		guiSetText(lNameCheck, "Kullanici Bulundu: " .. getPlayerName(found) .. " (ID #" .. getElementData(found, "playerid") .. ")")
		guiLabelSetColor(lNameCheck, 0, 255, 0)
		reportedPlayer = found
	elseif (count==0) then
		guiSetText(lNameCheck, "Oyuncu bulunamadi.")
		guiLabelSetColor(lNameCheck, 255, 0, 0)
	end
end

-- Close button
function clickCloseButton(button, state)
	if (source==bClose) and (button=="left") and (state=="up") then
		if (wReportMain~=nil) then
			destroyElement(wReportMain)
		end
		
		if (wHelp) then
			destroyElement(wHelp)
		end
		
		wReportMain, lWelcome, bClose, pHelp, lHelp, lHelpAbout, bHelp, wHelp, lNameCheck, bSubmitAdminReport, lPlayerName, reportedPlayer, tPlayerName, lReport, tReport, tHelpMessage = nil
		guiSetInputEnabled(false)
		showCursor(false)
	end
end

function onOpenCheck(playerID)
	executeCommandHandler ( "check", tostring(playerID) )
end
addEvent("report:onOpenCheck", true)
addEventHandler("report:onOpenCheck", getRootElement(), onOpenCheck)
