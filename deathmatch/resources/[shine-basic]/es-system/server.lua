local esenyurt = createColSphere (2371.73828125, -716.7109375, 128.64457702637, 100)
local kapikule = createColSphere (-494.0888671875, -121.5517578125, 65.994094848633, 100)
local izmir = createColSphere (-2644.8251953125, -5.794921875, 30.640625, 280)
local gise = createColSphere (-75.5302734375, -1425.232421875, 26.648696899414, 180)

function bayginlikCalistir(player)	
	if not getElementData(player, "loggedin") == 1 then return false end
	local id = getElementData(player, "dbid")
	if not id then return false end

	if getElementData(player, "dead") == 0 then
		setElementData(player, "knockout", false)
		setElementData(player, "dead", 0)
		setElementData(player, "yaralisinArtik", 0)
		setElementData(player, "knockout_moving", false)
	end
end
addEvent("es-system:ready", true)
addEventHandler("es-system:ready", root, bayginlikCalistir)

function playerDeath(totalAmmo, killer, killerWeapon)
	if getElementData(source, "dbid") then
		if isElementWithinColShape(source, esenyurt) or isElementWithinColShape(source, kapikule) or isElementWithinColShape(source, izmir)  or isElementWithinColShape(source, gise) then
			outputChatBox("[!] #ffffffKırmızı alanda öldüğün için şehre atıldın",source,0,255,0,true)
			lucky = math.random(1,2)
			local x,y,z = getElementPosition(source)
			local int = getElementInterior(source)
			local dim = getElementDimension(source)
			local team = getPlayerTeam(source)
			local rotx, roty, rotz = getElementRotation(source)
			local skin = getElementModel(source)

			if lucky == 1 then
				spawnPlayer(source, -2051.7685546875, 1323.220703125, 7.1729698181152, rotz, skin, int, dim, team)
			else
				spawnPlayer(source, 318.8251953125, -50.2451171875, 1.578125, rotz, skin, int, dim, team)
			end
			triggerEvent("updateLocalGuns", source)
		return end
		if getElementData(source, "adminjailed") then
			local team = getPlayerTeam(source)
			spawnPlayer(source, 232.3212890625, 160.5693359375, 1003.0234375, 270)
			
			setElementModel(source,getElementModel(source))
			setPlayerTeam(source, team)
			setElementInterior(source, 9)
			setElementDimension(source, 3)
			
			setCameraInterior(source, 9)
			setCameraTarget(source)
			fadeCamera(source, true)
		elseif getElementData(source, "jailed") then
			exports["prison-system"]:checkForRelease(source)
		else
			if getElementData(source, "dead") == 1 then
				return false
			end



		
			if getElementData(source, "seatbelt") then
				setElementData(source, "seatbelt", false)
			end

			setElementData(source, "dead", 1)
			setElementData(source, "yaralisinArtik", 1)
			local x,y,z = getElementPosition(source)
			local int = getElementInterior(source)
			local dim = getElementDimension(source)
			local team = getPlayerTeam(source)
			local rotx, roty, rotz = getElementRotation(source)
			local skin = getElementModel(source)
			
			spawnPlayer(source, x, y, z, rotz, skin, int, dim, team)

			setPedHeadless(source, false)
			setCameraInterior(source, int)
			setCameraTarget(source, source) 

			setPlayerTeam(source, team)
			setElementInterior(source, int)
			setElementDimension(source, dim)

			setTimer(setPedAnimation, 500, 1, source, "ped", "ko_shot_face",-1,false)

			setTimer(setPedAnimation, 3000, 1, source, "CRACK", "crckidle1", -1, true, false, false)
		
			setElementHealth(source, 10)
			
			triggerClientEvent(source, "playerdeath", source)
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), playerDeath)

function changeDeathView(source, victimDropItem)

end
addEvent("changeDeathView", true)
addEventHandler("changeDeathView", getRootElement(), changeDeathView)
local mysql = exports.mysql
function acceptDeath(thePlayer, victimDropItem, hideMessage)
	if getElementData(thePlayer, "dead") == 1 then		
		fadeCamera(thePlayer, true)
		if not hideMessage then
			outputChatBox("[!] #ffffffAyılıyorsun.", thePlayer, 0, 255, 0, true)
		end
		triggerClientEvent(thePlayer, "bayilmaRevive", thePlayer)
		setPedAnimation(thePlayer, false)
		triggerClientEvent(thePlayer, "stopAnimationFix", root, thePlayer)
		local x,y,z = getElementPosition(thePlayer)
		local int = getElementInterior(thePlayer)
		local dim = getElementDimension(thePlayer)
		local skin = getElementModel(thePlayer)
		local team = getPlayerTeam(thePlayer)
		setPedHeadless(thePlayer, false)
		setCameraInterior(thePlayer, int)
		setCameraTarget(thePlayer, thePlayer)
		spawnPlayer(thePlayer, x, y, z, 0)
		setElementData(thePlayer, "dead", 0)
		setElementData(thePlayer, "yaralisinArtik", 0)
		setElementHealth(thePlayer, 20)
		setElementModel(thePlayer,skin)
		setPlayerTeam(thePlayer, team)
		setElementInterior(thePlayer, int)
		setElementDimension(thePlayer, dim)
	end
end
addEvent("es-system:acceptDeath", true)
addEventHandler("es-system:acceptDeath", getRootElement(), acceptDeath)

function revivePlayerFromPK(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				if getElementData(targetPlayer, "dead") == 1 then
					setElementData(targetPlayer, "yaralanma", 0)
				
					triggerClientEvent(targetPlayer,"es-system:closeRespawnButton",targetPlayer)
					acceptDeath(targetPlayer)
					setElementData(targetPlayer, "dead", 0)
					triggerClientEvent(targetPlayer, "bayilmaRevive", targetPlayer)
					triggerEvent("updateLocalGuns", targetPlayer)
					local adminTitle = tostring(exports.global:getPlayerAdminTitle(thePlayer))
					outputChatBox("[!] #f0f0f0"..tostring(exports.global:getPlayerAdminTitle(thePlayer)).." "..tostring(getPlayerName(thePlayer):gsub("_"," ")).." tarafından canlandırıldınız.", targetPlayer, 0, 255, 0, true)
					outputChatBox("[!] #f0f0f0"..tostring(getPlayerName(targetPlayer):gsub("_"," ")).." isimli oyuncuyu canlandırdınız.", thePlayer, 0, 255, 0, true)
					setElementHealth(targetPlayer, 100)
					exports.global:sendMessageToAdmins("[ADMIN] "..tostring(exports.global:getPlayerAdminTitle(thePlayer)).." "..getPlayerName(thePlayer).." adlı yetkili "..tostring(getPlayerName(targetPlayer)).." adlı oyuncuyu yeniden canlandırdı.")
	
				else
					outputChatBox(tostring(getPlayerName(targetPlayer):gsub("_"," ")).." is not dead.", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("revive", revivePlayerFromPK, false, false)


function revivePlayerFromPK2(thePlayer, commandName, targetPlayer)
	if not exports.global:hasItem(thePlayer,1005231) then 
		outputChatBox("[!] #ffffffİyileştirme kitin olmadan kimseyi iyileştiremezsin.",thePlayer,255,0,0,true)
    return end
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				if getElementData(targetPlayer, "dead") == 1 then
					setElementData(targetPlayer, "yaralanma", 0)
				
					triggerClientEvent(targetPlayer,"es-system:closeRespawnButton",targetPlayer)
					acceptDeath(targetPlayer)
					setElementData(targetPlayer, "dead", 0)
					triggerClientEvent(targetPlayer, "bayilmaRevive", targetPlayer)
					triggerEvent("updateLocalGuns", targetPlayer)
					local adminTitle = tostring(exports.global:getPlayerAdminTitle(thePlayer))
					outputChatBox("[!] #f0f0f0"..tostring(exports.global:getPlayerAdminTitle(thePlayer)).." "..tostring(getPlayerName(thePlayer):gsub("_"," ")).." tarafından canlandırıldınız.", targetPlayer, 0, 255, 0, true)
					outputChatBox("[!] #f0f0f0"..tostring(getPlayerName(targetPlayer):gsub("_"," ")).." isimli oyuncuyu canlandırdınız.", thePlayer, 0, 255, 0, true)
					exports["item-system"]:takeItem(thePlayer,1005231,1)
					setElementHealth(targetPlayer, 100)
					exports.global:sendMessageToAdmins("[ADMIN] "..tostring(exports.global:getPlayerAdminTitle(thePlayer)).." "..getPlayerName(thePlayer).." adlı yetkili "..tostring(getPlayerName(targetPlayer)).." adlı oyuncuyu yeniden canlandırdı.")
	
				else
					outputChatBox(tostring(getPlayerName(targetPlayer):gsub("_"," ")).." is not dead.", thePlayer, 255, 0, 0)
				end
			end
		end
	--end
end
addCommandHandler("iyilestir", revivePlayerFromPK2, false, false)

komut_tablo2 = {
	["stopanim"] = true,
	["superman"] = true,
	["u"] = true,
	["pm"] = true,
	["goto"] = true,
	["gethere"] = true,
	["ooc"] = true,
	["z"] = true,	

}


komut_tablo = {
	["stopanim"] = true,
	["b"] = true,
	["u"] = true,
	["pm"] = true,
	["goto"] = true,
	["f"] = true,
	["teamsay"] = true,	
	["gethere"] = true,
	["ooc"] = true,
	["voice"] = true,	
	["aracgetir"] = true,	
	["faracgetir"] = true,		
}
addEventHandler("onPlayerCommand", root,
    function(c)
		if komut_tablo[c] then
      --  if ((getElementData(source, 'voice') or 0) ~= 1) then 
		if getElementData(source, "dead")== 1 or getElementData(source, "adminjailed") then
			outputChatBox("Salvo#ffffff Bu durumda "..c.." komutunu kullanamazsın!",source,44,44,44,true)
			cancelEvent ()
		return false end	
		end
    end

)
addEventHandler('onPlayerVoiceStart', root,
    function()
		if getElementData(source, "dead")== 1 or getElementData(source, "adminjailed") then
            cancelEvent()
            outputChatBox('[!]#D6D6D6 Bu durumda mikrofonunu kullanamazsın.', source, 180, 0, 0, true)
        end
    end
)

function enterVehicle ( player, seat, jacked ) 
    if getElementData(player,'death') == 1 then
        cancelEvent()
        outputChatBox ( "[!]#ffffff Baygın vaziyetteyken araca binemezsin", player, 255, 0, 0, true) 
    end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )


