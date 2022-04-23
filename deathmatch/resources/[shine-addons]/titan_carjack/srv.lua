function checkCarJack(thePlayer, seat, jacked)
   if jacked and seat == 0 then
      cancelEvent()
      outputChatBox("#8b1a1a[!] CarJack Yasak.", thePlayer,0,0,0,true)
   end
end
addEventHandler("onVehicleStartEnter", getRootElement(), checkCarJack)