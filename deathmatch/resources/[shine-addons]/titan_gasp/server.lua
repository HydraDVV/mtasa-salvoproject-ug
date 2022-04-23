
s = true
tablo = {}
days = 0.3
f = 100000

addCommandHandler("gaspet",function(p,c,t)
	if not t then 
		outputChatBox("Kullanım /"..c.." (id) yazarak gasp edebilirsiniz.",p,255,194,14,true)
	return end
		local t, tn = exports.global:findPlayerByPartialNick(p, t)
	if t then
		if s then
			x1, y1, z1 = getElementPosition (p)
			x2, y2, z2 = getElementPosition (t)
			 if  getDistanceBetweenPoints3D (x1, y1, z1 , x2, y2, z2) < 3 then
				
			 
			if not tablo[p] then tablo[p] = {} end 
			if not tablo[t] then tablo[t] = {} end 
			if tablo[p].second then
				outputChatBox("[!]#ffffff Maalesef şuanda gasp yapamazsınız.",p,255,0,0,true)
				outputChatBox("[!]#ffffff Tekrar gasp yapmak için "..secondsToTimeDesc(math.ceil(getTimerDetails(tablo[p].second)/1000)).." beklemeniz gerekli.",p,100,100,255,true)
			return end
			if t:getData("money") <= 0 then
				outputChatBox("[!]#ffffff Gasp etmek istediğiniz kişinin üzerinde para bulunmuyor.",p,255,0,0,true)
			return end
			outputChatBox("[!]#ffffff "..p:getName().." isimli şahıs sizi gasp etmek istiyor.",t,100,100,255,true)
			outputChatBox("[!]#ffffff "..t:getName().." isimli şahısı gasp etmek istiyorsun.",p,100,100,255,true)
			tablo[t] = {p,t,f}
			
			triggerClientEvent(t,"gasp:panel",t,p,t,f)
			-- p eden
			-- t edilen
			tablo[p].second = Timer(function()
			tablo[p] = {}
			end, 1000*60*60*24*days, 1)
				else
				outputChatBox("[!]#ffffff Gasp edeceğiniz kişiden çok uzaktasınız.",p,255,0,0,true)
			end
		end
	end
end)
-- tablo[source][1] = p 
-- tablo[source][2] = t
addEvent("gasp:confirm",true)
addEventHandler("gasp:confirm",root,function(d,f)
	 p = tablo[source][1] 
	 t = tablo[source][2] 
	 f = tablo[source][3] 
	if d == "yes" then -- Confirm
		outputChatBox("[!]#ffffff "..t:getName().." isimli şahsı başarıyla gasp ettiniz.",p,100,100,255,true)
		outputChatBox("[!]#ffffff "..p:getName().." isimli şahıs seni gasp etti!",t,100,100,255,true)
		if exports.global:takeMoney(t, 100000)then
			exports.global:giveMoney(p, 100000)
			else
			exports.global:giveMoney(p, getElementData(t, "money"))
			exports.global:takeMoney(t, getElementData(t, "money"))
		end
	elseif d == "no" then -- cancel
		outputChatBox("[!]#ffffff "..t:getName().." isimli şahıs gaspınızı reddetti.",p,255,0,0,true)
		outputChatBox("[!]#ffffff "..p:getName().." isimli şahsın gasp teklifini reddettiniz.",t,255,0,0,true)
		tablo[p] = {}
	end
end)

function secondsToTimeDesc( seconds )
	if seconds then
		local results = {}
		local sec = ( seconds %60 )
		local min = math.floor ( ( seconds % 3600 ) /60 )
		local hou = math.floor ( ( seconds % 86400 ) /3600 )
		local day = math.floor ( seconds /86400 )
		
		if day > 0 then table.insert( results, day .. ( day == 1 and " gün" or " gün" ) ) end
		if hou > 0 then table.insert( results, hou .. ( hou == 1 and " saat" or " saat" ) ) end
		if min > 0 then table.insert( results, min .. ( min == 1 and " dakika" or " dakika" ) ) end
		if sec > 0 then table.insert( results, sec .. ( sec == 1 and " saniye" or " saniye" ) ) end
		
		return string.reverse ( table.concat ( results, ", " ):reverse():gsub(" ,", " ev ", 1 ) )
	end
	return ""
end