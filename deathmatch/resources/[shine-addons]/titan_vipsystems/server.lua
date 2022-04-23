local mysql = exports.mysql
local gun1 = 86400
function setvip(oyuncu, commandName, targetPlayerName, vip,sure)
	--local targetName = exports.global:getPlayerFullIdentity(oyuncu, 1)
	if getElementData(oyuncu, "account:username") == "REMAJOR" or getElementData(oyuncu, "account:username") == "pabloo50" or getElementData(oyuncu, "account:username") == "REMAJOR" then
		local vip,sure = tonumber(vip),tonumber(sure)
		if not targetPlayerName or not tonumber(vip) or not sure  then
			outputChatBox("Kullanım: #ffffff/"..commandName.." [İsim/ID] [VIP] [SÜRE]", oyuncu, 255, 194, 14, true)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( oyuncu, targetPlayerName )
			if not targetPlayer then
					
				elseif getElementData( targetPlayer, "loggedin" ) ~= 1 then
					outputChatBox( "Oyuncu giriş yapmamış.", oyuncu, 255, 0, 0 )
				else
				local cid = getElementData(targetPlayer, "dbid")
				
				if vip == 0 then
					mysql:query_free("UPDATE `characters` SET `vip`="..mysql:escape_string(vip).." WHERE `id`='"..mysql:escape_string(getElementData(targetPlayer, "dbid")).."'")
					removeElementData(targetPlayer,"vipver")
					outputChatBox("[!]#ffffff Şahısın vip yetkisi alındı.", oyuncu, 0, 255, 0, true)
					outputChatBox("[!]#ffffff Vip yetkiniz alındı.", targetPlayer, 0, 0, 255, true)
					return 
				end
				if vip >= -0  then
					if vip <= 3 then
						local gundakika = sure*gun1
						local suan = getRealTime()
						local bitis = getRealTime(suan.timestamp+gundakika)
						mysql:query_free("UPDATE `characters` SET `vip`="..mysql:escape_string(vip)..", suan='"..(suan.year+1900).."-".. (suan.month+1) .."-".. suan.monthday .." "..suan.hour..":"..suan.minute..":"..suan.second.."', bitis='"..(bitis.year+1900).."-".. (bitis.month+1) .."-".. bitis.monthday .." "..bitis.hour..":"..bitis.minute..":"..bitis.second.."' WHERE `id`='"..mysql:escape_string(getElementData(targetPlayer, "dbid")).."'")
						setElementData(targetPlayer, "vipver", vip)
						outputChatBox("[!]#ffffff".. targetPlayerName .. " adlı kişinin vip seviyesini [" .. vip .. "] yaptın.", oyuncu, 0, 255, 0, true)
						outputChatBox("[!]#ffffff"..getPlayerName(oyuncu).." tarafından vip seviyeniz [" .. vip .. "] yapıldı.", targetPlayer, 0, 255, 0,true)
						outputChatBox("[!]#ffffffVip["..vip.."] bitiş tarihiniz: "..bitis.monthday.."."..(bitis.month+1).."."..(bitis.year+1900).." - "..bitis.hour..":"..bitis.minute..":"..bitis.second.." ", targetPlayer, 0, 255, 0,true)
					else
						outputChatBox("[!]#ffffff "..vip.." seviye veremezsin 1-3 seviye arasında verebilirsin.", oyuncu, 255, 0, 0, true)
					end
				else
					outputChatBox("[!]#ffffff "..vip.." seviye veremezsin 1-3 seviye arasında verebilirsin.", oyuncu, 255, 0, 0, true)
				end
			end
		end
	else
	    outputChatBox( "[!]#ffffffBu işlemi yapmaya yetkiniz yok.", oyuncu, 255, 0, 0, true)
	end
end
addCommandHandler("vipver", setvip)

local ayTablosu = {"Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"}
function ayAdiCek(ay)
	if tostring(ay) == "01" then
		ay = 1
	elseif tostring(ay) == "02" then
		ay = 2
	elseif tostring(ay) == "03" then
		ay = 3
	elseif tostring(ay) == "04" then
		ay = 4
	elseif tostring(ay) == "05" then
		ay = 5
	elseif tostring(ay) == "06" then
		ay = 6
	elseif tostring(ay) == "07" then
		ay = 7
	elseif tostring(ay) == "08" then
		ay = 8
	elseif tostring(ay) == "09" then
		ay = 9
	end
	if (not ayTablosu[ay]) then return end
	local ay = ayTablosu[ay]
	return ay
end

addEvent("oyuncuVipKontrol",true)
addEventHandler("oyuncuVipKontrol", root, function()
	local cid = getElementData(source, "dbid")
	local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
	local timeToConvert = getElementData(source, "bitis")
	local vipLevel = tonumber(getElementData(source, "vipver"))
	local runyear, runmonth, runday, runhour, runminute, runseconds = timeToConvert:match(pattern)
	local bitis = os.time({year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds})
	local suan = getRealTime().timestamp
	if vipLevel > 0 then
		if tonumber(bitis) < suan then
			outputChatBox("[!]#ffffffVip("..vipLevel..") süresi dolmuştur.", source, 0, 255, 0,true)
			setElementData(source, "vipver", 0)
			mysql:query_free("UPDATE `characters` SET `vip`=0, suan='0000-00-00 00:00:00', bitis='0000-00-00 00:00:00' WHERE `id`='"..mysql:escape_string(cid).."'")
			return
		end
		outputChatBox("[!]#ffffffVip["..vipLevel.."] bitiş tarihiniz: ".. runday .. " " .. ayAdiCek(runmonth) .. " " .. runyear .. " " .. runhour .. ":".. runminute .. ":"..runseconds, source, 0, 255, 0,true)
	end
end)

addCommandHandler("vipsurem", function(oyuncu)
	local vip_seviye = getElementData(oyuncu, "vipver") or 0
	if vip_seviye == 0 then outputChatBox("[!] #ffffffVip değilsiniz.", source, 255, 0, 0,true) return end
	local cid = getElementData(oyuncu, "dbid")
	local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
	local timeToConvert = getElementData(oyuncu, "bitis")
	local runyear, runmonth, runday, runhour, runminute, runseconds = timeToConvert:match(pattern)
	local bitis = getRealTime(os.time({year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds}))
	outputChatBox("[!]#ffffffVip("..vip_seviye..") bitiş tarihiniz: ".. runday .. " " .. ayAdiCek(runmonth) .. " " .. runyear .. " " .. runhour .. ":".. runminute .. ":"..runseconds, oyuncu, 0, 255, 0,true)
end)


