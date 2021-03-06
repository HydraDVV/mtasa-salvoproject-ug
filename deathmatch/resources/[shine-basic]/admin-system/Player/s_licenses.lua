
--give player license
function givePlayerLicense(thePlayer, commandName, targetPlayerName, licenseType)
	if exports.global:isPlayerAdmin(thePlayer) then
		if not targetPlayerName or not (licenseType and (licenseType == "1" or licenseType == "2" or licenseType == "3" or licenseType == "4")) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick] [Type]", thePlayer, 255, 194, 14)
			outputChatBox("Type 1 = Driver", thePlayer, 255, 194, 14)
			outputChatBox("Type 2 = Weapon", thePlayer, 255, 194, 14)
			outputChatBox("Type 3 = OCW permit (weapon)", thePlayer, 255, 194, 14)
			outputChatBox("Type 4 = CCW permit (weapon)", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerName)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					local licenseTypeOutput = licenseType == "1" and "driver" or "weapon"
					if licenseType == "1" then
						licenseTypeOutput = "car"
					elseif licenseType == "2" then
						licenseTypeOutput = "gun"
					else
						licenseTypeOutput = "na"
					end
					--licenseType = licenseType == "1" and "car" or "gun"
					if getElementData(targetPlayer, "license."..licenseTypeOutput) == 1 then
						outputChatBox(getPlayerName(thePlayer).." has already a "..licenseTypeOutput.." license.", thePlayer, 255, 255, 0)
					else
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						if (licenseType == "1") then
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "license."..licenseType, 1, false)
							mysql:query_free("UPDATE characters SET car_license='1' WHERE id = "..mysql:escape_string(getElementData(targetPlayer, "dbid")).." LIMIT 1")
							setElementData(targetPlayer, "license.car", 1)
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVELICENSE CAR")
							--exports.global:giveItem(targetPlayer, 133, targetPlayerName) --Give car license item
							if (hiddenAdmin==0) then
								outputChatBox("Admin "..getPlayerName(thePlayer):gsub("_"," ").." gives you a drivers license.", targetPlayer, 0, 255, 0)
								outputChatBox("Player "..targetPlayerName.." now has a drivers license.", thePlayer, 0, 255, 0)
								local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
								exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave " .. targetPlayerName .. " a drivers license.")
							else
								outputChatBox("A Hidden Admin gives you a drivers license.", targetPlayer, 0, 255, 0)
								outputChatBox("Player "..targetPlayerName.." now has a drivers license.", thePlayer, 0, 255, 0)
								exports.global:sendMessageToAdmins("AdmCmd: A Hidden Admin gave " .. targetPlayerName .. " a drivers license.")
							end
						elseif (licenseType == "2") then
							if exports.global:isPlayerSuperAdmin(thePlayer) then
								exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "license."..licenseType, 1, false)
								mysql:query_free("UPDATE characters SET gun_license='1' WHERE id = "..mysql:escape_string(getElementData(targetPlayer, "dbid")).." LIMIT 1")
								setElementData(targetPlayer, "license.gun", 1)
								exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVELICENSE GUN")
								if (hiddenAdmin==0) then
									local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
									outputChatBox("Admin "..getPlayerName(thePlayer):gsub("_"," ").." gives you a weapons license.", targetPlayer, 0, 255, 0)
									exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave " .. targetPlayerName .. " a weapon license.")
								else
									outputChatBox("A Hidden Admin gives you a weapons license.", targetPlayer, 0, 255, 0)
									exports.global:sendMessageToAdmins("AdmCmd: A Hidden Admin gave " .. targetPlayerName .. " a weapon license.")

									outputChatBox("Player "..targetPlayerName.." now has a weapons license.", thePlayer, 0, 255, 0)
								end
							else
								outputChatBox("You are not allowed to spawn gun licenses.", thePlayer, 255, 0, 0)
							end
						elseif (licenseType == "3") then --OCW permit (new weapon license type)
							if exports.global:isPlayerSuperAdmin(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer) then
								exports.global:giveItem(targetPlayer, 148, targetPlayerName) --OCW permit
								outputChatBox("You have issued a OCW permit to " .. targetPlayerName .. ".", thePlayer, 0, 158, 0)
								if (hiddenAdmin==0) then
									local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
									outputChatBox("You have been issued a OCW permit by "..tostring(adminTitle).." " .. getPlayerName(thePlayer):gsub("_", " ") .. ".", targetPlayer, 0, 158, 0)
								else
									outputChatBox("You have been issued a OCW permit by a hidden admin.", targetPlayer, 0, 158, 0)								
								end
								exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVELICENSE OCW permit")
								if (hiddenAdmin==0) then
									local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
									exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave " .. targetPlayerName .. " a OCW permit.")
								else
									exports.global:sendMessageToAdmins("AdmCmd: A hidden admin gave " .. targetPlayerName .. " a OCW permit.")
								end
							else
								outputChatBox("Sorry. Super+ only.", thePlayer, 255, 0, 0)
							end
						elseif (licenseType == "4") then --CCW permit (new weapon license type)
							if exports.global:isPlayerSuperAdmin(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer) then
								exports.global:giveItem(targetPlayer, 149, targetPlayerName) --OCW permit
								outputChatBox("You have issued a CCW permit to " .. targetPlayerName .. ".", thePlayer, 0, 158, 0)
								if (hiddenAdmin==0) then
									local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
									outputChatBox("You have been issued a CCW permit by "..tostring(adminTitle).." " .. getPlayerName(thePlayer):gsub("_", " ") .. ".", targetPlayer, 0, 158, 0)
								else
									outputChatBox("You have been issued a CCW permit by a hidden admin.", targetPlayer, 0, 158, 0)								
								end
								exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVELICENSE CCW permit")
								if (hiddenAdmin==0) then
									local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
									exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave " .. targetPlayerName .. " a CCW permit.")
								else
									exports.global:sendMessageToAdmins("AdmCmd: A hidden admin gave " .. targetPlayerName .. " a CCW permit.")
								end
							else
								outputChatBox("Sorry. Super+ only.", thePlayer, 255, 0, 0)
							end						
						end
					end
				end
			end
		end
	end
end
addCommandHandler("proagivelicense", givePlayerLicense)


--take player license
function takePlayerLicense(thePlayer, commandName, dtargetPlayerName, licenseType)
	if exports.global:isPlayerSuperAdmin(thePlayer) then
		if not dtargetPlayerName or not (licenseType and (licenseType == "1" or licenseType == "2")) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Nick] [Type]", thePlayer, 255, 194, 14)
			outputChatBox("Type 1 = Driver", thePlayer, 255, 194, 14)
			outputChatBox("Type 2 = Weapon", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(nil, dtargetPlayerName)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					local licenseTypeOutput = licenseType == "1" and "driver" or "weapon"
					licenseType = licenseType == "1" and "car" or "gun"
					if getElementData(targetPlayer, "license."..licenseType) == 0 then
						outputChatBox(getPlayerName(thePlayer).." has no "..licenseTypeOutput.." license.", thePlayer, 255, 255, 0)
					else
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						if (licenseType == "gun") then
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "license."..licenseType, 0, false)
							mysql:query_free("UPDATE characters SET "..mysql:escape_string(licenseType).."_license='0' WHERE id = "..mysql:escape_string(getElementData(targetPlayer, "dbid")).." LIMIT 1")
							--outputChatBox("Player "..targetPlayerName.." now has a "..licenseTypeOutput.." license.", thePlayer, 0, 255, 0)
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "TAKELICENSE GUN")
							if hiddenAdmin == 0 then 
								outputChatBox("Admin "..getPlayerName(thePlayer):gsub("_"," ").." revokes your "..licenseTypeOutput.." license.", targetPlayer, 0, 255, 0)
								local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
								exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " revoked " .. targetPlayerName .. " his ".. licenseType .." license.")
							else
								outputChatBox("A Hidden Admin revokes your "..licenseTypeOutput.." license.", targetPlayer, 0, 255, 0)
								outputChatBox("Player "..targetPlayerName.." now  has his  "..licenseType.." license revoked.", thePlayer, 0, 255, 0)
							end
						else
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "license."..licenseType, 0, false)
							mysql:query_free("UPDATE characters SET "..mysql:escape_string(licenseType).."_license='0' WHERE id = "..mysql:escape_string(getElementData(targetPlayer, "dbid")).." LIMIT 1")
							outputChatBox("Player "..targetPlayerName.." now has a "..licenseTypeOutput.." license.", thePlayer, 0, 255, 0)
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "TAKELICENSE CAR")
							if hiddenAdmin == 0 then 
								outputChatBox("Admin "..getPlayerName(thePlayer):gsub("_"," ").." revokes your "..licenseTypeOutput.." license.", targetPlayer, 0, 255, 0)
							
								local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
								exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " revoked " .. targetPlayerName .. " his ".. licenseType .." license.")
							else
								outputChatBox("A Hidden Admin revokes your "..licenseTypeOutput.." license.", targetPlayer, 0, 255, 0)
								outputChatBox("Player "..targetPlayerName.." now  has his  "..licenseType.." license revoked.", thePlayer, 0, 255, 0)
							end
						end
					end
				end
			else
				local resultSet = mysql:query_fetch_assoc("SELECT `id`,`car_license`,`gun_license` FROM `characters` where `charactername`='"..mysql:escape_string(dtargetPlayerName).."'")
				if resultSet then
					licenseType = licenseType == "1" and "car" or "gun"
					if (tonumber(resultSet[licenseType.."_license"]) ~= 0) then
						local resultQry = mysql:query_free("UPDATE `characters` SET `"..licenseType.."_license`=0 WHERE `charactername`='"..mysql:escape_string(dtargetPlayerName).."'")
						if (resultQry) then
							exports.logs:dbLog(thePlayer, 4, { "ch"..resultSet["id"] }, "TAKELICENSE "..licenseType)
							local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
							if (hiddenAdmin==0) then
								local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
								exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " revoked " .. dtargetPlayerName .. " his ".. licenseType .." license.")
							else
								outputChatBox("Player "..dtargetPlayerName.." now  has his  "..licenseType.." license revoked.", thePlayer, 0, 255, 0)
							end
						else
							outputChatBox("Wups, atleast something went wrong there..", thePlayer, 255, 0, 0)
						end
					else
						outputChatBox("The player doesn't have this license.", thePlayer, 255, 0, 0)
					end
				else
					outputChatBox("No player found.", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("proatakelicense", takePlayerLicense)
