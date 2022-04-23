mysql = exports.mysql
local tirYeri = createColSphere ( 2588.7431640625, -2233.2890625, 13.546875, 3)
local meslekID = 32
function tir(thePlayer)
    if (isElementWithinColShape(thePlayer, tirYeri)) then
	    if not (getElementData(thePlayer, "job") == meslekID) then
	        if not (getElementData(thePlayer, "job") == 0) then
		        outputChatBox("#cc0000[!]#ffffffBu mesleğe girebilmek için önceki mesleğinden istifa etmen gerekli. #F55C5C(/meslektenayril)", thePlayer, 255, 0, 0, true )
		    else
	            if setElementData(thePlayer, "job", tonumber(meslekID)) then
                    mysql:query_free("UPDATE characters SET job = ".. tonumber(meslekID) .." WHERE id = " .. mysql:escape_string(getElementData( thePlayer, "dbid" )) )
					exports["job-system"]:fetchJobInfoForOnePlayer(thePlayer)
	                outputChatBox("#00CC00[!]#ffffffMeslek başarıyla alındı: #6699FFTır Şöförü", thePlayer, 255, 194, 14, true )
	            end
		    end
		else
		outputChatBox("#cc0000[!]#ffffffZaten Tır Şöförlüğü mesleğindesiniz.", thePlayer, 255, 0, 0, true )
	    end
	else	
	    outputChatBox("#cc0000[!]#ffffffMeslek bölgesinde değilsin.", thePlayer, 255, 0, 0, true )
	end
end
addCommandHandler("tirisbasi", tir)