local spam = {}
local zaman = {}
local spamkapatsure = 500

function komutkullandi( commandName )
if getElementData(source, "komutkullanimikapat") == false or getElementData(source, "komutkullanimikapat") == 0 then
spam[source] = tonumber(spam[source] or 0) + 1
		if spam[source] >= 2 then
			local playerName = getPlayerName( source ):gsub('_', ' ')
			outputChatBox("#e42a00[Salvo] #c67979Komut kullanımı arka arkaya bu kadar sık kullanmayınız!", source, 255, 0, 0, true)
			exports.anticheat:changeProtectedElementDataEx(source, "komutkullanimikapat", true)
			setElementData(source, "komutkullanimikapat", true)
		   cancelEvent()
		end
	
		if isTimer(zaman[source]) then
			killTimer(zaman[source])
		end
	
		zaman[source] = setTimer(	function (source)
			spam[source] = 0
			
			if isElement(source) and getElementData(source, "komutkullanimikapat") == true or getElementData(source, "komutkullanimikapat") then
				exports.anticheat:changeProtectedElementDataEx(source, "komutkullanimikapat", false)
				setElementData(source, "komutkullanimikapat", false)
			end
		end, spamkapatsure, 1, source)
	else
		cancelEvent()
	end
end
addEventHandler('onPlayerCommand', root, komutkullandi)