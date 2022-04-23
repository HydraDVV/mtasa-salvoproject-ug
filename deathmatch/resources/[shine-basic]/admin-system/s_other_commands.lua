local mysql = exports.mysql

-- GET VEHICLE KEY OR INTERIOR KEY / MAXIME
function getKey(thePlayer, commandName)
	if exports.global:isPlayerAdmin(thePlayer)	then
		local adminName = getPlayerName(thePlayer):gsub(" ", "_")
		local veh = getPedOccupiedVehicle(thePlayer)
		if veh then
			local vehID = getElementData(veh, "dbid")
			
			givePlayerItem(thePlayer, "giveitem" , adminName, "3" , tostring(vehID))
			
			return true
		else
			local intID = getElementDimension(thePlayer)
			if intID then
				local foundIntID = false
				local keyType = false
				local possibleInteriors = getElementsByType("interior")
				for _, theInterior in pairs (possibleInteriors) do
					if getElementData(theInterior, "dbid") == intID then
						local intType = getElementData(theInterior, "status")[1] 
						if intType == 0 or intType == 2 or intType == 3 then
							keyType = 4 --Yellow key
						else
							keyType = 5 -- Pink key
						end
						foundIntID = intID
						break
					end
				end
				
				if foundIntID and keyType then
					givePlayerItem(thePlayer, "giveitem" , adminName, tostring(keyType) , tostring(foundIntID))
					
					return true
				else
					outputChatBox(" You're not in any vehicle or possible interior.", thePlayer, 255,0 ,0 )
					return false
				end
				
			end
		end
	end
end



addCommandHandler("getkey", getKey, false, false)
function setSvPassword(thePlayer, commandName, password)
	if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "alperen2124" then
		outputChatBox("SYNTAX: /" .. commandName .. " [Password without spaces, empty to remove pw] - Set/remove server's password", thePlayer, 255, 194, 14)
		if password and string.len(password) > 0 then
			if setServerPassword(password) then
				exports.global:sendMessageToStaff("[SYSTEM] "..exports.global:getPlayerFullIdentity(thePlayer).." has set server's password to '"..password.."'.", true)
			end
		else
			if setServerPassword('') then
				exports.global:sendMessageToStaff("[SYSTEM] "..exports.global:getPlayerFullIdentity(thePlayer).." has removed server's password.", true)
			end
		end
	end
end
addCommandHandler("setserverpassword", setSvPassword, false, false)
addCommandHandler("setserverpw", setSvPassword, false, false)

function bakimZamani(thePlayer)
	if not (getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR") then
		return
	end
	setServerPassword("bakim1234bakim")
	setTimer(
		function()
			outputChatBox("!! SUNUCUMU BAKIM MODUNA ALINMAKTADIR !!", root, 255, 0, 0)
			outputChatBox("!! 30 SANİYE İÇERİSİNDE SUNUCUDAN ÇIKARTILACAKSINIZ !!", root, 255, 0, 0)
		end, 5000, 6
	)
	for i, v in ipairs(getElementsByType("player")) do
		if not (exports.global:isPlayerAdmin(v)) then
--		if not exports.integration:isPlayerSeniorAdmin(v) then
			setTimer(kickPlayer, 30000, 1, v, "Sunucumuz bakım moduna alınmıştır. discord.gg/f4wKrmDWce")
		end
	end
end
addCommandHandler("bakim", bakimZamani)

function RealServerTime ( )
	local time = getRealTime()
	setMinuteDuration(60000)
	setTime(time.hour, time.minute)
end
setTimer(RealServerTime,600000,0)


do
	local dxGetStatus = dxGetStatus -- declare
	local playerInfo = dxGetStatus()
	local videoCardName = playerInfo.VideoCardName
	local intelString = 'HD Graphics'
	if match(videoCardName, intelString) then
	  return setFPSLimit(100)
	end
  end