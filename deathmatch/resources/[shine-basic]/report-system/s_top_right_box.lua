local thisResourceElement = getResourceRootElement(getThisResource())

--MAXIME MAGIC
function updateUnansweredReportsAdmins()
	local info = {}
	table.insert(info, {string.upper(" Tum Raporlar"), 255,194,14,255,1,"default-bold" })
	
	local count = 0
	for i = 1, 300 do
		local report = reports[i]
		if report then
			local reporter = report[1]
			local reported = report[2]
			local timestring = report[4]
			local admin = report[5]
			local isGMreport = report[7]
			
			local handler = ""
			if (isElement(admin)) then
				--handler = tostring(getPlayerName(admin))
			else
				handler = "None."
				if isGMreport then
					--outputChatBox("GM Report #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. ".", thePlayer, 70, 200, 30)
				else
					table.insert(info, {"Admin Reportlari #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. "."})
					count = count + 1
				end
			end
		end
	end
	
	if count == 0 then
		table.insert(info, {"None."})
	else
		--
	end

	setElementData(thisResourceElement, "urAdmin", info, true)
end

function updateUnansweredReportsGMs()
	local info = {}
	table.insert(info, {string.upper(" Cevaplanmayan GM raporlari"), 255,194,14,255,1,"default-bold" })
	
	local count = 0
	for i = 1, 300 do
		local report = reports[i]
		if report then
			local reporter = report[1]
			local reported = report[2]
			local timestring = report[4]
			local admin = report[5]
			local isGMreport = report[7]
			
			local handler = ""
			if (isElement(admin)) then
				--handler = tostring(getPlayerName(admin))
			else
				handler = "None."
				if isGMreport then
					table.insert(info, {"Admin Reportlari #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. "."})
					count = count + 1
				else
					--
				end
			end
		end
	end
	
	if count == 0 then
		table.insert(info, {"None."})
	else
		--
	end
	
	setElementData(thisResourceElement, "urGM", info, true)
end

function updateReports()
	local info = {}
	table.insert(info, {string.upper(" Tum Raporlar"), 255,194,14,255,1,"default-bold" })
	
	local count = 0
	for i = 1, 300 do
		local report = reports[i]
		if report then
			local reporter = report[1]
			local reported = report[2]
			local timestring = report[4]
			local admin = report[5]
			local isGMreport = report[7]
			
			local handler = ""
			
			if (isElement(admin)) then
				local adminName = getElementData(admin, "account:username")
				handler = tostring(getPlayerName(admin)).." ("..adminName..")"
			else
				handler = "None."
			end
			if isGMreport then
				table.insert(info, {"GM Report #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. ".", 70, 200, 30})
			else
				table.insert(info, {"Admin Report #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. "."})
			end
			count = count + 1
		end
	end
	
	if count == 0 then
		table.insert(info, {"None."})
	end
	
	setElementData(thisResourceElement, "allReports", info, true)
	
end
setTimer(updateUnansweredReportsAdmins, 4000, 0)
setTimer(updateUnansweredReportsGMs, 5000, 0)
setTimer(updateReports, 6000, 0)