wEmployment, jobList, bAcceptJob, bCancel = nil

--[[
local jessie = createPed( 141, 1474.5302734375, -1936.638671875, 290.70001220703 )
setPedRotation( jessie, 0 )
setElementDimension( jessie, 9 )
setElementInterior( jessie , 1 )
setElementData( jessie, "talk", 1, false )
setElementData( jessie, "name", "Jessie Smith", false )
--setPedAnimation ( jessie, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false, false )
setElementFrozen(jessie, true)
--]]

function showEmploymentWindow()

	-- Employment Tooltip
	if(getResourceFromName("tooltips-system"))then
		triggerEvent("tooltips:showHelp",getLocalPlayer(),7)
	end

	triggerServerEvent("onEmploymentServer", getLocalPlayer())
	local width, height = 300, 400
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)

	wEmployment = guiCreateWindow(x, y, width, height, "İş Panosu", false)

	jobList = guiCreateGridList(0.05, 0.05, 0.9, 0.8, true, wEmployment)
	local column = guiGridListAddColumn(jobList, "İş", 0.9)

	-- TRUCKER
	local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Kargo Şoförlüğü", false, false)

	-- TAXI
	local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Taksi Şoförlüğü", false, false)

	-- BUS
	local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Otobüs Şoförlüğü", false, false)

	-- KAMYON
	local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Kamyon Şoförlüğü", false, false)
	
	-- TIR
	local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Tır Şoförlüğü", false, false)
	
	-- BETON TAŞIMACILIĞI
	local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Beton Taşımacılığı", false, false)
	
	local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Deniz Taşımacılığı", false, false)
	
	-- CITY MAINTENACE
	local team = getPlayerTeam(getLocalPlayer())
	local ftype = getElementData(team, "type")
	if ftype ~= 2 then
		local rowmaintenance = guiGridListAddRow(jobList)
		guiGridListSetItemText(jobList, rowmaintenance, column, "Şehir Temizlikçisi", false, false)
		
	end

	-- MECHANIC
	--[[local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "REMAJOR", false, false)]] -- Disabled, added mechanic faction type

	-- LOCKSMITH
	--[[local row = guiGridListAddRow(jobList)
	guiGridListSetItemText(jobList, row, column, "Locksmith", false, false)]]

	bAcceptJob = guiCreateButton(0.05, 0.85, 0.45, 0.1, "İşi Kabul Et", true, wEmployment)
	bCancel = guiCreateButton(0.5, 0.85, 0.45, 0.1, "İptal", true, wEmployment)

	showCursor(true)

	addEventHandler("onClientGUIClick", bAcceptJob, acceptJob)
	addEventHandler("onClientGUIDoubleClick", jobList, acceptJob)
	addEventHandler("onClientGUIClick", bCancel, cancelJob)
end
addEvent("onEmployment", true)
addEventHandler("onEmployment", getRootElement(), showEmploymentWindow)

function acceptJob(button, state)
	if (button=="left") then
		local row, col = guiGridListGetSelectedItem(jobList)
		local job = getElementData(getLocalPlayer(), "job")

		if (row==-1) or (col==-1) then
			outputChatBox("[!] #FFFFFFLütfen listeden bir iş seçin!", 255, 0, 0, true)
		elseif (job>0) then
			outputChatBox("[!] #FFFFFFZaten bir işiniz var. Öncelikle işinizden istifa etmelisiniz. (( /quitjob )).", 255, 0, 0, true)
		else
			local job = 0
			local jobtext = guiGridListGetItemText(jobList, guiGridListGetSelectedItem(jobList), 1)

			if ( jobtext=="Kargo Şoförlüğü" or jobtext=="Taksi Şoförlüğü" or jobtext=="Otobüs Şoförlüğü" or jobtext=="Beton Taşımacılığı" or jobtext=="Kamyon Şoförlüğü" or jobtext=="Tır Şoförlüğü" ) then  -- Driving job, requires the license
				local carlicense = getElementData(getLocalPlayer(), "license.car")
				if (carlicense~=1) then
					outputChatBox("[!] #FFFFFFBu işi yapmak için ehliyete ihtiyacınız var.", 255, 0, 0, true)
					return
				end
			end

			if (jobtext=="Kargo Şoförlüğü") then
				exports["job-system-trucker"]:displayTruckerJob()
				job = 1
			elseif (jobtext=="Taksi Şoförlüğü") then
				if not (getElementData(getLocalPlayer(), "level") < 3) then
					job = 2
					displayTaxiJob()
				end
			elseif  (jobtext=="Otobüs Şoförlüğü") then
				job = 3
				displayBusJob()
			elseif  (jobtext=="Kamyon Şoförlüğü") then
				job = 11
				kamyonBlip()
			elseif (jobtext=="Şehir Temizlikçilisi") then
				job = 4
			elseif (jobtext=="Tamirci") then
				displayMechanicJob()
				job = 5
			elseif (jobtext=="Çilingir") then
				displayLocksmithJob()
				job = 6
			elseif (jobtext=="Tır Şoförlüğü") then
				tirBlip()
				job = 10
			elseif (jobtext=="Beton Taşımacılığı") then
				betonBlip()
				job = 14
			elseif (jobtext=="Deniz Taşımacılığı") then
				job = 15
				outputChatBox("[!] #f0f0f0Artık Deniz Taşımacılığı mesleğindesiniz!", 0, 255, 0, true)
			end

			triggerServerEvent("acceptJob", getLocalPlayer(), job)

			destroyElement(jobList)
			destroyElement(bAcceptJob)
			destroyElement(bCancel)
			destroyElement(wEmployment)
			wEmployment, jobList, bAcceptJob, bCancel = nil, nil, nil, nil
			showCursor(false)
		end
	end
end

function cancelJob(button, state)
	if (source==bCancel) and (button=="left") then
		destroyElement(jobList)
		destroyElement(bAcceptJob)
		destroyElement(bCancel)
		destroyElement(wEmployment)
		wEmployment, jobList, bAcceptJob, bCancel = nil, nil, nil, nil
		showCursor(false)
	end
end
