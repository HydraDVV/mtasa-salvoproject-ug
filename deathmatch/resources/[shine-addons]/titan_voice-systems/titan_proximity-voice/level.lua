
function sesDuzeyi(player, commandName, voiceLevel)
		if not tonumber(voiceLevel) then
			exports["titan_infobox"]:addBox(player, "info", "/"..commandName.." [1 ile 10 arası bir değer]")
		return end
		if tonumber(voiceLevel) > 0 and tonumber(voiceLevel) < 11 then
			player:setData("maxVol", tonumber(voiceLevel))
			exports["titan_infobox"]:addBox(player, "success", "Ses seviyeniz ("..tonumber(voiceLevel)..") olarak ayarlandı.")
		else
			exports["titan_infobox"]:addBox(player, "error", "1 - 10 değerleri arasında bir ses seviyesi girmelisiniz.")
		end
end
addCommandHandler("voicelevel", sesDuzeyi)
addCommandHandler("sesduzeyi", sesDuzeyi)
addCommandHandler("sesseviyesi", sesDuzeyi)
