function getAdmins()
	local players = exports.pool:getPoolElementsByType("player")
	
	local admins = { }
	
	for key, value in ipairs(players) do
		if isPlayerSuspendedAdmin(value) and getPlayerAdminLevel(value) <= 8 then
			table.insert(admins,value)
		end
	end
	return admins
end

function getScripters()
	local players = exports.pool:getPoolElementsByType("player")
	local scripters = { }
	for key, value in ipairs(players) do
		if isPlayerScripter(value) then
			table.insert(scripters,value)
		end
		if isPlayerLvl2Scripter(value) then
			table.insert(scripters,value)
		end
	end
	return scripters
end

function getPlayerScripterTitle(thePlayer)
	local text = "Scripter"
	if isPlayerScripter(thePlayer) then
		text = "L3 Scripter"
	else
		text = "L2 Scripter"
	end
end	
	
function isPlayerSuspendedAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 1
end

function isPlayerAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 2
end

function isPlayerFullAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 3
end

function isPlayerSuperAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 4
end

function isPlayerHeadAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 6
end

function isPlayerLeadAdmin(thePlayer)
	return getPlayerAdminLevel(thePlayer) >= 5
end

function getPlayerAdminLevel(thePlayer)
	return isElement( thePlayer ) and tonumber(getElementData(thePlayer, "adminlevel")) or 0
end

--local adminTitles = { "Suspended Admin", "Trial Admin", "Admin", "Super Admin", "Lead Admin", "Head Admin", "Owner" }
local adminTitles = {
	["1"] = "Cezali Admin", 
	["2"] = "Deneme Admin", 
	["3"] = "Stajyer Admin", 
	["4"] = "Kıdemli Admin", 
	["5"] = "Baş Admin", 
	["6"] = "Yönetim Ekibi Üyesi", 
		["6.000000000001"] = "Server Owner 0.1434539e3",
	["7"] = "Genel Yetkili",
	["8"] = "Developer",
	["10"] = "Server Kurucusu",
	["11"] = "Bayan",
	["11.56"] = "Anthony's Slut"
}
function getPlayerAdminTitle(thePlayer)
	local text = adminTitles[""..tostring(getPlayerAdminLevel(thePlayer))..""] or "Oyuncu"
		
	local hiddenAdmin = getElementData(thePlayer, "hiddenadmin") or 0
	if (hiddenAdmin==1) then
		text = text .. " (Gizli)"
	end

	return text
end

--[[ GM ]]--
function getGameMasters()
	local players = exports.pool:getPoolElementsByType("player")
	local gameMasters = { }
	for key, value in ipairs(players) do
		if isPlayerGameMaster(value) then
			table.insert(gameMasters, value)
		end
	end
	return gameMasters
end

function isPlayerGameMaster(thePlayer)
	return getPlayerGameMasterLevel(thePlayer) >= 1
end

function isPlayerFullGameMaster(thePlayer)
	return getPlayerGameMasterLevel(thePlayer) >= 2
end

function isPlayerSeniorGameMaster(thePlayer)
	return getPlayerGameMasterLevel(thePlayer) >= 3
end
	
function isPlayerLeadGameMaster(thePlayer)
	return getPlayerGameMasterLevel(thePlayer) >= 4
end

function isPlayerHeadGameMaster(thePlayer)
	return getPlayerGameMasterLevel(thePlayer) >= 5
end

function getPlayerGameMasterLevel(thePlayer)
	return isElement( thePlayer ) and tonumber(getElementData(thePlayer, "account:gmlevel")) or 0
end

function isPlayerGMTeamLeader(thePlayer)
	if not isPlayerFullAdmin(thePlayer) and not isPlayerHeadGameMaster(thePlayer) then
		return false
	end
	return exports.donators:hasPlayerPerk(thePlayer,17)
end

local GMtitles = { "Deneme Rehber", "Rehber", "Kýdemli Rehber", "Lider Rehber", "Oncu Rehber" }
function getPlayerGMTitle(thePlayer)
	local text = GMtitles[getPlayerGameMasterLevel(thePlayer)] or "Oyuncu"
	return text
end

--[[ /GM ]]--

local scripters = {
	-- tamfire = true,
	--FrolicBeast = true, - Left.
	-- powercow = true, 
	--Anthony = true, - Left
	-- Exciter = true,
	--Bean = true,
	--Jevi = true,
	--Weimy = true,
	-- Grimes = true
}

local lvl2scripters = {
--	Weimy = true,
	--florence = true,
	--Daniel = true,
	--BetaSpark = true
}

--[[ Dafauq is this shit
local internalaffairs = {
	Jevi = true,
	forrest = true,
	Chuevo = true,
	Piranha = true
}
]]

function isPlayerLvl2Scripter(thePlayer)
	return lvl2scripters[thePlayer] or lvl2scripters[ getElementData(thePlayer, "account:username") or "nobody" ] or false
end

function isPlayerIA(thePlayer)
	return false --internalaffairs[thePlayer] or internalaffairs[ getElementData(thePlayer, "account:username") or "nobody" ] or false
end

function isPlayerScripter(thePlayer)
	return scripters[thePlayer] or scripters[ getElementData(thePlayer, "account:username") or "nobody" ] or false
end



local factionreviewteam = {
	-- Maxime = true,
	-- Liam = true,
	-- FireBird = true,
}

function isPlayerFRT(thePlayer)
	return factionreviewteam[thePlayer] or factionreviewteam[ getElementData(thePlayer, "account:username") or "nobody" ] or false
end