--[[
.
]]
function surprizkutu(thePlayer)
local Ssans = math.random( 1 , 5)
local gSsans = tonumber(ssans)
if not (exports.global:hasItem(thePlayer, 5001))then
                outputChatBox("#FF0000[!]#FFFFFFSüpriz kutun olmadan açamazsin.",thePlayer,0, 0, 0, true)
		return
	end
if ( Ssans == 1 ) then 
exports.global:takeItem(thePlayer, 5001 , 1)
exports.global:giveMoney(thePlayer, 100000)
outputChatBox("#FF0000[!]#FFFFFFTebrikler Surpriz Kutudan 100.000 TL Kazandiniz", thePlayer,0, 0, 0 ,true)

elseif ( Ssans == 2 ) then 
exports.global:takeItem(thePlayer, 5001 , 1)
exports.global:giveMoney(thePlayer, 200000)
outputChatBox("#FF0000[!]#FFFFFFTebrikler Surpriz Kutudan 200.000 TL Kazandiniz", thePlayer,0, 0, 0 ,true)



elseif ( Ssans == 3 ) then 
exports.global:takeItem(thePlayer, 5001 , 1)
exports.global:giveMoney(thePlayer, 300000)
outputChatBox("#FF0000[!]#FFFFFFTebrikler Surpriz Kutudan 300.000 TL Kazandiniz", thePlayer,0, 0, 0 ,true)


elseif ( Ssans == 4 or Ssans == 5 ) then 
exports.global:takeItem(thePlayer, 5001 , 1)
exports.global:giveMoney(thePlayer, 50000)
outputChatBox("#FF0000[!]#FFFFFFTebrikler Surpriz Kutudan 50.000 TL Kazandiniz", thePlayer,0, 0, 0 ,true)
end
end
addCommandHandler("kutuac", surprizkutu)

