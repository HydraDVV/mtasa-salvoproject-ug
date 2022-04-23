addCommandHandler("esyaac", function()


if getElementDimension(localPlayer) == 0 and getElementInterior(localPlayer) == 0 then
    outputChatBox("[Salvo] #ffffffBu işlemi yapmak için Interior içinde olmanız gerekmektedir.", 255, 0, 0, true)
else

for i=0,4 do
setInteriorFurnitureEnabled(i, true)
end
    outputChatBox("[Salvo] #ffffffEşyalar açıldı.", 0, 255, 0, true)
    
end



end)

addCommandHandler("esyakapa", function()
    

        if getElementDimension(localPlayer) == 0 and getElementInterior(localPlayer) == 0 then
            outputChatBox("[Salvo] #ffffffBu işlemi yapmak için Interior içinde olmanız gerekmektedir.", 255, 0, 0, true)
        else
        
        for i=0,4 do
        setInteriorFurnitureEnabled(i, false)
        end
             outputChatBox("[Salvo] #ffffffEşyalar kapandı.", 0,255, 0, true)
        end
        
    


end)