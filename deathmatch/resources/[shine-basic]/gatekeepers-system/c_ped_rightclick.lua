wPedRightClick = nil
bTalkToPed, bClosePedMenu = nil
ax, ay = nil
closing = nil
sent=false

function pedDamage()
	cancelEvent()
end
addEventHandler("onClientPedDamage", getRootElement(), pedDamage)

function clickPed(button, state, absX, absY, wx, wy, wz, element)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if (element) and (getElementType(element)=="ped") and (button=="right") and (state=="down") and (sent==false) and (element~=getLocalPlayer()) then
		if (isPedDoingGangDriveby(getLocalPlayer()) == true) then
			setPedWeaponSlot(getLocalPlayer(), 0)
			setPedDoingGangDriveby(getLocalPlayer(), false)
		end
		local gatekeeper = getElementData(element, "talk")
		if (gatekeeper) then
			local x, y, z = getElementPosition(getLocalPlayer())
			
			if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=3) then
				if (wPedRightClick) then
					hidePlayerMenu()
				end
				
				showCursor(true)
				ax = absX
				ay = absY
				player = element
				closing = false
				local pedName = getElementData(element, "name") or "The Storekeeper"
				pedName = tostring(pedName):gsub("_", " ")
				wPedRightClick = guiCreateWindow(ax, ay, 150, 75, pedName, false)
				
				bTalkToPed = guiCreateButton(0.05, 0.3, 0.87, 0.25, "Konuş", true, wPedRightClick)
				addEventHandler("onClientGUIClick", bTalkToPed,  function (button, state)
					if(button == "left" and state == "up") then
					
						hidePedMenu()
						
						local ped = getElementData(element, "name")
						local isFuelped = getElementData(element,"ped:fuelped")
						local isTollped = getElementData(element,"ped:tollped")
						local isShopKeeper = getElementData(element,"shopkeeper") or false
						
						if (ped=="Steven Pullman") then
							triggerServerEvent( "startStevieConvo", getLocalPlayer())
							if (getElementData(element, "activeConvo")~=1) then
								triggerEvent ( "stevieIntroEvent", getLocalPlayer()) -- Trigger Client side function to create GUI.
							end
						elseif (ped=="Hunter") then
							triggerServerEvent( "startHunterConvo", getLocalPlayer())
						elseif (ped=="Orospu Azra") then
							triggerEvent("point:fahise:panel", getLocalPlayer())						
						elseif (ped=="Ahmet Caycı") then
							triggerEvent("zkin:panel", getLocalPlayer())						
						elseif (ped=="Rook") then
							triggerServerEvent( "startRookConvo", getLocalPlayer())
						elseif (ped=="Victoria Greene") then
							triggerEvent("cPhotoOption", getLocalPlayer(), ax, ay)
						elseif (ped=="Doktor Ali Vefa") then
                            triggerEvent("tedavigui:event", getLocalPlayer(), ax, ay)
						elseif (ped=="Kiyafetci Rifat") then
                            triggerEvent("skin:ac", getLocalPlayer(), ax, ay)
						elseif (ped=="Jessie Smith") then
							triggerEvent("onEmployment", getLocalPlayer())
						elseif (ped=="Carla Cooper") then
							triggerEvent("onLicense", getLocalPlayer())
						elseif (ped=="Elizabeth Wilson") then
							triggerEvent("reklamGUI", getLocalPlayer())
						elseif (ped=="Kiyafetci Rifat") then
							triggerServerEvent("skin:ac", getLocalPlayer())
						elseif (ped=="Aslı Peker") then
							triggerEvent("pd:panel", root, localPlayer)
						elseif (ped=="Mr. Clown") then
							triggerServerEvent("electionWantVote", getLocalPlayer())
						elseif (ped=="Ahmet Kar") then
							triggerServerEvent("onTowMisterTalk", getLocalPlayer())
						elseif (ped=="Ahmet Kar") then
							triggerServerEvent("gateCityHall", getLocalPlayer())
						elseif (ped=="Albert Henry") then
							triggerEvent("AracSatma:PanelAc", getLocalPlayer())
						elseif (ped=="Doktor Ali Vefa") then
							triggerEvent("vazgec:gui", getLocalPlayer())
						elseif (ped=="Airman Connor") then
							triggerServerEvent("gateAngBase", getLocalPlayer())
							elseif (ped=="Yasemin Guzel") then
							triggerEvent("cBeginPlate", getLocalPlayer())
						elseif (ped=="Rosie Jenkins") then
							triggerEvent("lses:popupPedMenu", getLocalPlayer())
						--elseif (ped=="Melike Hanim") then
						--triggerEvent("reklamlarTablo", getLocalPlayer())
						elseif (ped=="Pete Robinson") then
							triggerServerEvent("vergi:sVergiGUI", getLocalPlayer())
						elseif (ped=="Melike Hanim") then
							triggerEvent("reklamGUI", getLocalPlayer())
						elseif (ped=="Layla Clapton") then
							triggerEvent("scrap:popupPedMenu", getLocalPlayer())
						elseif (ped=="Ronnie Johnson") then
							triggerEvent("usmc:popupPedMenu", getLocalPlayer())
						elseif (ped=="Yasmin Hutchings") then
							triggerEvent("cBeginPlate", getLocalPlayer())
						elseif (ped=="Fishmonger") then
							triggerEvent("fish:list", getLocalPlayer())
						elseif (ped=="Vanna Spadafora") then
							triggerEvent("vm:popupPedMenu", getLocalPlayer())
						elseif (ped=="Bahittin Sürmeli") then
							triggerEvent("isimGUI", getLocalPlayer())	
						elseif (ped=="Muzaffer Sarı") then
							triggerEvent("ickiGUI", getLocalPlayer(), getLocalPlayer())
						elseif (ped=="Baran Sancak") then
							triggerEvent("sigaraGUI", getLocalPlayer(), getLocalPlayer())
						elseif (isFuelped == true) then
							triggerServerEvent("fuel:startConvo", element)
						elseif (isTollped == true) then
							triggerServerEvent("sigaraGUI", getLocalPlayer())
						elseif isShopKeeper then -- MAXIME
							triggerServerEvent("shop:keeper", element)
						elseif (ped=="Ekrem Bey") then
							triggerServerEvent("vergi:sVergiGUI", getLocalPlayer())
						elseif (ped=="Gökhan Ada") then
							triggerEvent("AracSatma:PanelAc", getLocalPlayer())
						elseif (ped=="Görkem Sağmacı") then
							triggerEvent('k9:K9Panel', getLocalPlayer())
						elseif (ped=="Erdem Menekse") then
							triggerEvent('aksesuar:shop', getLocalPlayer())
						elseif (ped=="Galerici Şahin") then
							triggerEvent('galeri:panel', getLocalPlayer())
						elseif (ped=="Bahittin Ermez") then
							triggerEvent('birlikGUI', getLocalPlayer())
						elseif (ped=="Deniz Özyurt") then 
				
							triggerServerEvent('clothing:list', getResourceRootElement(getResourceFromName("titan_dupont")))
						else
							exports.hud:sendBottomNotification(getLocalPlayer(),"NPC says:", "        'Hi!'")
						end
					end
				end, false)
				
				bClosePedMenu = guiCreateButton(0.05, 0.6, 0.87, 0.25, "Kapat", true, wPedRightClick)
				addEventHandler("onClientGUIClick", bClosePedMenu, hidePedMenu, false)
				sent=true
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickPed, true)

function hidePedMenu()
	if (isElement(bTalkToPed)) then
		destroyElement(bTalkToPed)
	end
	bTalkToPed = nil
	
	if (isElement(bClosePedMenu)) then
		destroyElement(bClosePedMenu)
	end
	bClosePedMenu = nil

	if (isElement(wPedRightClick)) then
		destroyElement(wPedRightClick)
	end
	wPedRightClick = nil
	
	ax = nil
	ay = nil
	sent=false
	showCursor(false)
	
end