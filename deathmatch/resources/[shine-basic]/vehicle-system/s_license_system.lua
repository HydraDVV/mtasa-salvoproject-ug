mysql = exports.mysql

function onLicenseServer()
	local gender = getElementData(source, "gender")
	if (gender == 0) then
		exports.global:sendLocalText(source, "Carla Cooper says: Merhaba efendim, bir lisans için mi baktınız?", nil, nil, nil, 10)
	else
		exports.global:sendLocalText(source, "Carla Cooper says: Merhaba hanımefendi, lisans için mi baktınız?", nil, nil, nil, 10)
	end
end

addEvent("onLicenseServer", true)
addEventHandler("onLicenseServer", getRootElement(), onLicenseServer)

function giveLicense(license, cost)
	if (license==1) then -- car drivers license
		local theVehicle = getPedOccupiedVehicle(source)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "realinvehicle", 0, false)
		removePedFromVehicle(source)
		respawnVehicle(theVehicle)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "license.car", 1)
		exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "handbrake", 1, false)
		setElementFrozen(theVehicle, true)
		mysql:query_free("UPDATE characters SET car_license='1' WHERE charactername='" .. mysql:escape_string(getPlayerName(source)) .. "' LIMIT 1")
		outputChatBox("Tebrikler, Sürüş Lisansı testinin 2. bölümünü geçtiniz.", source, 255, 194, 14)
		outputChatBox("Artık caddede sürüş için lisansınız var. Bunun için 350TL ödediniz.", source, 255, 194, 14)
		exports.global:giveItem(source, 133, getPlayerName(thePlayer):gsub("_"," "))
		exports.global:takeMoney(source, cost)
	end
end
addEvent("acceptLicense", true)
addEventHandler("acceptLicense", getRootElement(), giveLicense)

function payFee(amount)
	exports.global:takeMoney(source, amount)
end
addEvent("payFee", true)
addEventHandler("payFee", getRootElement(), payFee)

function passTheory()
	exports['anticheat-system']:changeProtectedElementDataEx(source,"license.car.cangetin",true, false)
	exports['anticheat-system']:changeProtectedElementDataEx(source,"license.car",3) -- Set data to "theory passed"
	mysql:query_free("UPDATE characters SET car_license='3' WHERE charactername='" .. mysql:escape_string(getPlayerName(source)) .. "' LIMIT 1")
end
addEvent("theoryComplete", true)
addEventHandler("theoryComplete", getRootElement(), passTheory)

function showLicenses(thePlayer, commandName, targetPlayer)
	local loggedin = getElementData(thePlayer, "loggedin")

	if (loggedin==1) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)

			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")

				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					local x, y, z = getElementPosition(thePlayer)
					local tx, ty, tz = getElementPosition(targetPlayer)

					if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)>5) then -- Are they standing next to each other?
						outputChatBox("You are too far away to show your license to '".. targetPlayerName .."'.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You have shown your licenses to " .. targetPlayerName .. ".", thePlayer, 255, 194, 14)
						outputChatBox(getPlayerName(thePlayer) .. " has shown you their licenses.", targetPlayer, 255, 194, 14)

						local gunlicense = getElementData(thePlayer, "license.gun")
						local carlicense = getElementData(thePlayer, "license.car")
						local weedlicense = getElementData(thePlayer, "license.weed")
						local businesslicense = getElementData(thePlayer, "license.business")

						local guns, cars, weed, business

						if (gunlicense<=0) then
							guns = "No"
						else
							guns = "Yes"
						end

						if (weedlicense<=0) then
							weed = "No"
						else
							weed = "Yes"
						end

						if (businesslicense<=0) then
							business = "No"
						else
							business = "Yes"
						end

						if (carlicense<=0) then
							cars = "No"
						elseif (carlicense==3)then
							cars = "Theory test passed"
						else
							cars = "Yes"
						end

						outputChatBox("~-~-~-~- " .. getPlayerName(thePlayer) .. "'s Licenses -~-~-~-~", targetPlayer, 255, 194, 14)
						outputChatBox("        Weapon License: " .. guns, targetPlayer, 255, 194, 14)
						outputChatBox("        Car License: " .. cars, targetPlayer, 255, 194, 14)
						outputChatBox("        Marijuana License: " ..weed, targetPlayer, 255, 194, 14)
						outputChatBox("        Business License: " ..business, targetPlayer, 255, 194, 14)
					end
				end
			end
		end
	end
end
addCommandHandler("showlicenses", showLicenses, false, false)


function checkDMVCars(player, seat)
	-- aka civilian previons
	if getElementData(source, "owner") == -2 and getElementData(source, "faction") == -1 and getElementModel(source) == 436 then
		if getElementData(player,"license.car") == 3 then
			if getElementData(player, "license.car.cangetin") then
				outputChatBox("(( J ' ye basarak motoru çalıştırın ve /handbrake yazarak el frenini indirin. ))", player, 0, 255, 0)
			else
				outputChatBox("(( Bu DMV aracı sadece Sürücü Kursu ' na özeldir, lütfen Carla Cooper ' a uğrayın. ))", player, 255, 0, 0)
				cancelEvent()
			end
		elseif seat > 0 then
			outputChatBox("(( Bu DMV aracı sadece Sürüş Testine özel. ))", player, 255, 194, 14)
		else
			outputChatBox("(( Bu DMV aracı sadece Sürüş Testine özel. ))", player, 255, 0, 0)
			cancelEvent()
		end
	end
end
addEventHandler( "onVehicleStartEnter", getRootElement(), checkDMVCars)

--[[function buywlicense()
	local gunlicense = getElementData(source, "license.gun")
	 if (gunlicense==1) then
		outputChatBox("You already got weapon license",source,255,0,0)
		return
	end

	if exports.global:takeMoney(source,35000) then
	exports['anticheat-system']:changeProtectedElementDataEx(source, "license.gun", 1)
	mysql:query_free("UPDATE characters SET gun_license='1' WHERE id = "..mysql:escape_string(getElementData(source, "dbid")).." LIMIT 1")
	outputChatBox("You bought weapon license. Now you are allowed to buy weapons from ammunition.",source, 0, 255, 0)
	else
		outputChatBox("You need $35000 for weapon license.",source,255,0,0)
	end
end
addEvent("givewlicense", true)
addEventHandler("givewlicense", getRootElement(),buywlicense)
--]]
