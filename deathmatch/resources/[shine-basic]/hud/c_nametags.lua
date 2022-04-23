local localPlayer = getLocalPlayer()
local badges = {}
local hfont = exports.titan_fonts:getFont("Roboto",10)
masks = {}
local moneyFloat = {}
local maxIconsPerLine = 6
function startRes()
	for key, value in ipairs(getElementsByType("player")) do
		setPlayerNametagShowing(value, false)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), startRes)

function initStuff(res)
	if (res == getThisResource() and getResourceFromName("item-system")) or getResourceName(res) == "item-system" then
		for key, value in pairs(exports['item-system']:getBadges()) do
			badges[value[1]] = { value[4][1], value[4][2], value[4][3], value[5] }
		end
		
		masks = exports['item-system']:getMasks()
	end
end
addEventHandler("onClientResourceStart", getRootElement(), initStuff)

local playerhp = { }
local lasthp = { }

local playerarmor = { }
local lastarmor = { }

function playerQuit()
	if (getElementType(source)=="player") then
		playerhp[source] = nil
		lasthp[source] = nil
		playerarmor[source] = nil
		lastarmor[source] = nil
	end
end
addEventHandler("onClientElementStreamOut", getRootElement(), playerQuit)
addEventHandler("onClientPlayerQuit", getRootElement(), playerQuit)


function setNametagOnJoin()
	setPlayerNametagShowing(source, false)
end
addEventHandler("onClientPlayerJoin", getRootElement(), setNametagOnJoin)

function streamIn()
	if (getElementType(source)=="player") then
		playerhp[source] = getElementHealth(source)
		lasthp[source] = playerhp[source]
		
		playerarmor[source] = getPedArmor(source)
		lastarmor[source] = playerarmor[source]
	end
end
addEventHandler("onClientElementStreamIn", getRootElement(), streamIn)

function isPlayerMoving(player)
	return (not isPedInVehicle(player) and (getPedControlState(player, "forwards") or getPedControlState(player, "backwards") or getPedControlState(player, "left") or getPedControlState(player, "right") or getPedControlState(player, "accelerate") or getPedControlState(player, "brake_reverse") or getPedControlState(player, "enter_exit") or getPedControlState(player, "enter_passenger")))
end

local lastrot = nil

function aimsSniper()
	return getPedControlState(localPlayer, "aim_weapon") and getPedWeapon(localPlayer) == 34
end

function aimsAt(player)
	return getPedTarget(localPlayer) == player and aimsSniper()
end

function getBadgeColor(player)
	for k, v in pairs(badges) do
		if getElementData(player, k) then
			return unpack(badges[k])
		end
	end
end

function getPlayerIcons(name, player, forTopHUD, distance)
	distance = distance or 0
	local tinted, masked = false, false
	local icons = {}

	if not forTopHUD then
		--ADMIN / GM TAGS
		if getElementData(player,"hiddenadmin") ~= 1 then
			if exports.global:isPlayerAdmin(player) and getElementData(player,"adminduty") == 1 then
				table.insert(icons, "adm_on")
			end
			
			if exports.global:isPlayerGameMaster(player) and getElementData(player,"gmduty") == 1 then
				table.insert(icons, 'gm_on')
			end
		end

			--Etiket Panel
		if getElementData(player,"etiket") == 1 then
				table.insert(icons, "isimetiketleri1")
			end
			if getElementData(player,"etiket") == 2 then
				table.insert(icons, "isimetiketleri2")
				end
			if getElementData(player,"etiket") == 3 then
				table.insert(icons, "isimetiketleri3")
				end
			if getElementData(player,"etiket") == 4 then
				table.insert(icons, "isimetiketleri4")
				end
            if getElementData(player,"etiket") == 5 then
				table.insert(icons, "isimetiketleri5")
				end
		
		   --VİP PANEL
		    if getElementData(player,"vipver") == 1 then
				table.insert(icons, "vip1")
			end
			if getElementData(player,"vipver") == 2 then
				table.insert(icons, "vip2")
			end
			if getElementData(player,"vipver") == 3 then
				table.insert(icons, "vip3")
			end
		-- DONATOR NAMETAGS
		if getElementData(player, "RPArtiKontrol") == 1 then
			table.insert(icons, 'donor')
		end
	end	
	
	for key, value in pairs(masks) do
		if getElementData(player, value[1]) then
			table.insert(icons, value[1])
			if value[4] then
				masked = true
			end
		end
	end
	

	local vehicle = getPedOccupiedVehicle(player)
	local windowsDown = vehicle and getElementData(vehicle, "vehicle:windowstat") == 1

	if vehicle and not windowsDown and vehicle ~= getPedOccupiedVehicle(localPlayer) and getElementData(vehicle, "tinted") then
		local seat0 = getVehicleOccupant(vehicle, 0) == player
		local seat1 = getVehicleOccupant(vehicle, 1) == player
		--outputDebugString(toJSON(seat0, seat1))
		if seat0 or seat1 then
			if distance > 1.4 then
				name = "Bilinmeyen Kisi (Film)"
				tinted = true
			end
		else
			name = "Bilinmeyen Kisi (Film)"
			tinted = true
		 end
	end

	if not tinted then
		-- pretty damn hard to see thru tint
		if getElementData(player,"seatbelt") == true  then
			table.insert(icons, 'seatbelt')
		end


		if getElementData(player,"smoking") == true then
			table.insert(icons, 'cigarette')
		end
		for k, v in pairs(badges) do
			local title = getElementData(player, k)
			if title then
				if v[4] == 122 or v[4] == 123 or v[4] == 124 or v[4] == 125 or v[4] == 135 or v[4] == 136 or v[4] == 158 or v[4] == 168 then
					table.insert(icons, 'bandana')
					name = "Bilinmeyen Kisi (Bandana)"
					badge = true
				elseif v[2] == 112 or v[2] == 64 then
					table.insert(icons, 'police')
					name = title .. "\n" .. name
					badge = true
				elseif v[5] == 56 then
					table.insert(icons, 'mask')
					name = "Bilinmeyen Kisi (Mask)"
					badge = true
				elseif v[5] == 26 then
					table.insert(icons, 'gasmask')
					name = "Bilinmeyen Kisi (Gaz Mask)"
					badge = true
				else
					table.insert(icons, "badge" .. tostring(v[5] or 1))
					name = title .. "\n" .. name
					badge = true
				end
			end
		end

		if tonumber(getElementData(player, 'phonestate') or 0) > 0 then
			table.insert(icons, 'phone')
		end
	end

	if not tinted then
		if not forTopHUD then
			local health = getElementHealth( player )
			local tick = math.floor(getTickCount () / 1000) % 2
			if health <= 10 and tick == 0 then
				table.insert(icons, 'bleeding')
			elseif (health <= 30) then
				table.insert(icons, 'lowhp')
			end
		end

		if getPedArmor( player ) > 50 then
			table.insert(icons, 'armour')
		end
	end
		
	if not forTopHUD then
		if windowsDown then
			table.insert(icons, 'window2')
		end
	end

	return name, icons, tinted
end
local zaman = {}
addEventHandler("onClientMinimize", getRootElement(),
	function()
		local logged = getElementData(localPlayer, "account:loggedin")
		if (logged == true) then
			setElementData(localPlayer, "hud:minimized", true)
			setElementData(localPlayer, "sayac:saniye", 0)
			setElementData(localPlayer, "sayac:dakika", 0)
			setElementData(localPlayer, "sayac:saat", 0)
			saniye = getElementData(localPlayer, "sayac:saniye")
			dakika = getElementData(localPlayer, "sayac:dakika")
			saat = getElementData(localPlayer, "sayac:saat")
			zaman[localPlayer] = setTimer ( function()
				saniye = math.floor(saniye) + 1
				setElementData(localPlayer, "sayac:saniye", saniye)
				if saniye >= 60 then
					saniye = 0
					setElementData(localPlayer, "sayac:saniye", 0)
					dakika = math.floor(dakika) + 1
					setElementData(localPlayer, "sayac:dakika", dakika)
				end
				if dakika >= 60 then
					dakika = 0
					setElementData(localPlayer, "sayac:dakika", 0)
					saat = math.floor(saat) + 1
					setElementData(localPlayer, "sayac:saat", saat)
				end
			end, 1000, 0 )
		end
	end
)

addEventHandler("onClientRestore", getRootElement(),
	function()
		local logged = getElementData(localPlayer, "account:loggedin")
		if (logged == true) then
			setElementData(localPlayer, "hud:minimized", false)
			saniye = 0
			dakika = 0
			saat = 0
			setElementData(localPlayer, "sayac:saniye", 0)
			setElementData(localPlayer, "sayac:dakika", 0)
			setElementData(localPlayer, "sayac:saat", 0)
			if isTimer(zaman[localPlayer]) then
				killTimer ( zaman[localPlayer] )
			end
		end
	end
)
function renderNametags()
	if (getElementData(localPlayer, "graphic_nametags") ~= "0") and not isPlayerMapVisible() and isActive() then
		local players = { }
		local distances = { }
		--local lx, ly, lz = getCameraMatrix()
		local lx, ly, lz = getElementPosition(localPlayer)
		local dim = getElementDimension(localPlayer)
		local isNewtyle = (getElementData(localPlayer, "settings_hud_style") ~= "0") 
		if isNewtyle then
			font = "default-bold"
		else
			font = "default-bold"
		end
		setElementData(localPlayer, "yaziyor", isChatBoxInputActive())
		for key, player in ipairs(getElementsByType("player")) do
			if (isElement(player)) and getElementDimension(player) == dim then
				local logged = getElementData(player, "account:loggedin")

				if (logged == true) then

					local rx, ry, rz = getElementPosition(player)
					local distance = getDistanceBetweenPoints3D(lx, ly, lz, rx, ry, rz)
					local limitdistance = 25
					local reconx = getElementData(localPlayer, "reconx") and exports.integration:isPlayerTrialAdmin(localPlayer)

					if isElementOnScreen(player) and (player~=localPlayer or isNewtyle) then
						if (aimsAt(player) or distance<limitdistance or reconx) then
							if not getElementData(player, "reconx") and not getElementData(player, "freecam:state") and not (getElementAlpha(player) < 255) then
								--local lx, ly, lz = getPedBonePosition(localPlayer, 7)
								local lx, ly, lz = getCameraMatrix()
								local vehicle = getPedOccupiedVehicle(player) or nil
								local collision, cx, cy, cz, element = processLineOfSight(lx, ly, lz, rx, ry, rz+1, true, true, true, true, false, false, true, false, vehicle)

								if not (collision) or aimsSniper() or (reconx) then
									local x, y, z = getElementPosition(player)

									if not (isPedDucked(player)) then
										z = z + 1
									else
										z = z + 0.5
									end

									local sx, sy = getScreenFromWorldPosition(x, y, z+0.30, 100, false)
									local oldsy = nil
									
									local tinted = false
									-- HP

									local name = getElementData(player, "fakename") or getPlayerName(player):gsub("_", " ")
									if getElementData(localPlayer, "samp")  == 1 then
										name = getElementData(player, "fakename") or getPlayerName(player)
									end
									sy = sy + 40
									if (sx) and (sy) then
										distance = distance / 3

										if (reconx or aimsAt(player)) then distance = 1
										elseif (distance<1) then distance = 1
										elseif (distance>2) then distance = 2 end

										--DRAW BG
										--dxDrawRectangle(sx-offset-5, sy, 95 / distance, 20 / distance, tocolor(0, 0, 0, 100), false)
										if getElementData(localPlayer, "samp")  == 1 then
											oldsy = sy
										else
											oldsy = sy+10
										end

										local picxsize = 64 / 1 --/distance
										local picysize = 64 / 1 --/distance
										local picxsize2 = 28 --/distance
										local picysize2 = 28 --/distance
										local xpos, ypos = 2, 45

										name, icons, tinted = getPlayerIcons(name, player, false, distance)
										local expectedIcons = math.min(#icons, maxIconsPerLine)
										local iconsThisLine = 0
										local offset = 16 * expectedIcons
										if getElementData(localPlayer, "samp")  == 0 then
											for k, v in ipairs(icons) do
												dxDrawImage(sx-offset+xpos+7,oldsy-5+ypos,picxsize-40,picysize-40,"components/" .. v .. ".png")

												iconsThisLine = iconsThisLine + 1
												if iconsThisLine == expectedIcons then
													expectedIcons = math.min(#icons - k, maxIconsPerLine)
													offset = 16 * expectedIcons
													iconsThisLine = 0
													xpos = 0
													ypos = ypos + 32
												else
													xpos = xpos + 32
												end
											end
										else
											armor = getPedArmor(player)
											if armor > 0 then
												oldsy = oldsy + 15
											end
											for k, v in ipairs(icons) do
												dxDrawImage(sx-offset+xpos,oldsy+35+ypos,30,30,"components/" .. v .. ".png")
												iconsThisLine = iconsThisLine + 1
												if iconsThisLine == expectedIcons then
													expectedIcons = math.min(#icons - k, maxIconsPerLine)
													offset = 16 * expectedIcons
													iconsThisLine = 0
													xpos = 2
													ypos = ypos + 32
												else
													xpos = xpos + 32
												end
											end
											badgeY = 10
											dxDrawRectangle(sx-offset+xpos-30,sy-8+77, 58, 8, tocolor( 0, 0, 0, 210), false )
											local health = getElementHealth( player )
											local maxHealth = 100
											local colourPercent = ( health / maxHealth ) * 255
											local red, green
											if health < ( maxHealth / 2 ) then
												red = 200;
												green = ( health / 50 ) * ( colourPercent * 2 )
												else
												green = 255
												red = 0 - ( ( health - 50 ) / 50 ) * 200
											end
											local armor = getPedArmor( player )
											local lineLength = 56 * ( health / 100 )
											if getTickCount () %800 < 500 and health <= 30 then  
												else 
												dxDrawRectangle(sx-offset+xpos-29,sy-7+77, lineLength, 6, tocolor( 255, 0, 0, 255 ), false )
											end
											local armorLength = 56 * ( armor / 100 )
											if (armor > 0) then
												dxDrawRectangle(sx-offset+xpos-30,sy-8+77+14, 58, 8, tocolor( 0, 0, 0, 210), false )
												dxDrawRectangle(sx-offset+xpos-29,sy-7+77+14, armorLength, 6, tocolor( 207, 207, 207, armorAlpha ), false )
											end
										end




										if (distance<=2) then
											sy = math.ceil( sy + ( 2 - distance ) * 20 )
										end
										sy = sy + 15


										if (sx) and (sy) then


											if (6>5) then
												local offset = 45 / distance
											end
										end

										if (distance<=2) then
											sy = math.ceil( sy - ( 2 - distance ) * 40 )
										end
										if getElementData(localPlayer, "samp")  == 0 then
											sy = sy - 20
										end

										if (sx) and (sy) and oldsy then
											if (distance < 1) then distance = 1 end
											if (distance > 2) then distance = 2 end
											local offset = 60 / distance
											local scale = 1.2 --/ distance
											local r, g, b = getBadgeColor(player)
											if not r or tinted then
												r, g, b = getPlayerNametagColor(player)
											end
											local id = getElementData(player, "playerid")

											if badge then
												sy = sy - dxGetFontHeight(scale, font) * scale + 15
											end
											local sehir = getElementData(player, "sehir")
											local isMinimized = getElementData(player, "hud:minimized")
											local sanyie_metin = "" .. (getElementData(player, "sayac:saniye") or "00")
											local dakika_metin = "" .. (getElementData(player, "sayac:dakika") or "00")
											local saat_metin = "" .. (getElementData(player, "sayac:saat") or "00")
											if isMinimized then
												if math.floor(getElementData(player, "sayac:saniye")) < 10 then sanyie_metin = "0" .. sanyie_metin end
												if math.floor(getElementData(player, "sayac:dakika")) < 10 then dakika_metin = "0" .. dakika_metin end
												if math.floor(getElementData(player, "sayac:saat")) < 10 then saat_metin = "0" .. saat_metin end
											end
											if getElementData(localPlayer, "samp")  == 0 then
												if isMinimized then
													dxDrawBorderedText("AFK ("..saat_metin..":"..dakika_metin..":"..sanyie_metin..")", sx-offset, sy-10, (sx-offset)+130 / distance, sy+80 / distance, tocolor(190, 50, 50, 255), 1, hfont, "center", "center", false, false, false, false, false)
												end
												dxDrawBorderedText(name.." ("..id..")", sx-offset, sy, (sx-offset)+130 / distance, sy+124 / distance, tocolor(0, 0, 0, 255), 1, hfont, "center", "center", false, false, false, false, false)
												dxDrawBorderedText(name.." ("..id..")", sx-offset, sy, (sx-offset)+130 / distance, sy+120 / distance, tocolor(r, g, b, 250), 1, hfont, "center", "center", false, false, false, false, false)
											else
												local a = 255/(distance)
												if distance > 1.5 and a > 5 then
													a = a - 5
												end
												sy = sy - 5
												if isMinimized then
													dxDrawBorderedText("AFK ("..saat_metin..":"..dakika_metin..":"..sanyie_metin..")", sx-offset, sy-20, (sx-offset)+130 / distance, sy+75 / distance, tocolor(190, 50, 50, a), 1, "default-bold", "center", "center", false, false, false, false, false)
												end
												dxDrawBorderedText(name.."("..id..")\n[".. sehir.."]", sx-offset, sy, (sx-offset)+130 / distance, sy+120 / distance, tocolor(r, g, b, a), 1, "default-bold", "center", "center", false, false, false, false, false)
												if getElementData(player, "yaziyor") then
													local nickuzunluk = dxGetTextWidth(name.."("..id..")", 1, "default-bold")
													dxDrawImage((sx-offset)+nickuzunluk+picxsize2-5, sy+50, picxsize2, picysize2, "components/written.png")
												end
												if getElementData(player, "mikrofon") and tonumber(getElementData(player, "level")) >= 3 then
													local nickuzunluk = dxGetTextWidth(name.."("..id..")", 1, "default-bold")
													dxDrawImage((sx-offset)+nickuzunluk+picxsize2-5, sy+50, picxsize2, picysize2, "components/microphone.png")
												end
											end
											local countryImgW, countryImgH = 32, 16
											local uyruk = getElementData(player, "ulke")
				                            if (uyruk == 1) then -- Amerika
											dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/1.png")
											elseif (uyruk == 0) then-- BOŞ
					                        dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/0.png")
			                              	elseif (uyruk == 2) then-- Almanya
					                        dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/2.png")
			                             	elseif (uyruk == 3) then-- Rusya
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/3.png")
			                             	elseif (uyruk == 4) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/4.png")
			                             	elseif (uyruk == 5) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/5.png")
			                             	elseif (uyruk == 6) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/6.png")
			                             	elseif (uyruk == 7) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/7.png")
			                             	elseif (uyruk == 8) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/8.png")
			                             	elseif (uyruk == 9) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/9.png")
			                             	elseif (uyruk == 10) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/10.png")
			                             	elseif (uyruk == 11) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/11.png")
			                             	elseif (uyruk == 12) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/12.png")
											elseif (uyruk == 13) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/13.png")
											elseif (uyruk == 14) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/14.png")
											elseif (uyruk == 15) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/15.png")
											elseif (uyruk == 16) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/16.png")
											elseif (uyruk == 17) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/17.png")
											elseif (uyruk == 18) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/18.png")
											elseif (uyruk == 19) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/19.png")
											elseif (uyruk == 20) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/20.png")
											elseif (uyruk == 21) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/21.png")
											elseif (uyruk == 22) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/22.png")
											elseif (uyruk == 23) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/23.png")
											elseif (uyruk == 24) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/24.png")
											elseif (uyruk == 25) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/25.png")
											elseif (uyruk == 26) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/26.png")
											elseif (uyruk == 27) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/27.png")
											elseif (uyruk == 28) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/28.png")
											elseif (uyruk == 29) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/29.png")
											elseif (uyruk == 30) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/30.png")
											elseif (uyruk == 31) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/31.png")
											elseif (uyruk == 32) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/32.png")
											elseif (uyruk == 33) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/33.png")
											elseif (uyruk == 34) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/34.png")
											elseif (uyruk == 35) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/35.png")
											elseif (uyruk == 36) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/36.png")
											elseif (uyruk == 37) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/37.png")
											elseif (uyruk == 38) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/38.png")
											elseif (uyruk == 39) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/39.png")
											elseif (uyruk == 40) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/40.png")
											elseif (uyruk == 41) then-- Fransa
											dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/41.png")
											elseif (uyruk == 42) then-- Fransa
											dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/42.png")
											elseif (uyruk == 43) then-- Fransa
											dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/43.png")
											elseif (uyruk == 44) then-- Fransa
											dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/44.png")
											elseif (uyruk == 45) then-- Fransa
											dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/45.png")
											elseif (uyruk == 46) then-- Fransa
											dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/46.png")
											elseif (uyruk == 47) then-- Fransa
				                        	dxDrawImage(sx-(dxGetTextWidth(name, scale, font)/2)-(countryImgW)-2, sy+53, countryImgW-3, countryImgH,"images/bayrak/47.png")
                                            end
											if moneyFloat and moneyFloat["mAlpha"] and moneyFloat["mAlpha"] > 1 and player == localPlayer then
												if moneyFloat["mAlpha"] > 0 then
													dxDrawText(moneyFloat["text"], sx-offset, sy+moneyFloat["moneyYOffset"], (sx-offset)+130 / distance, sy+120 / distance, tocolor(moneyFloat["mR"], moneyFloat["mG"], moneyFloat["mB"], moneyFloat["mAlpha"]), scale, moneyFont, "center", "center", false, false, false, false, false)
													moneyFloat["moneyYOffset"] = moneyFloat["moneyYOffset"] + moneyFloat["direction"]
													moneyFloat["mAlpha"] = moneyFloat["mAlpha"] - 2
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
		for key, player in ipairs(getElementsByType("ped")) do
			if (isElement(player) and  (player~=localPlayer) and (isElementOnScreen(player)))then
				
				if (getElementData(player,"talk") == 1) or (getElementData(player, "nametag")) then
					local lx, ly, lz = getElementPosition(localPlayer)
					local rx, ry, rz = getElementPosition(player)
					local distance = getDistanceBetweenPoints3D(lx, ly, lz, rx, ry, rz)
					local limitdistance = 20
					local reconx = getElementData(localPlayer, "reconx")
					
					-- smoothing
					playerhp[player] = getElementHealth(player)
					
					if (lasthp[player] == nil) then
						lasthp[player] = playerhp[player]
					end
					
					playerarmor[player] = getPedArmor(player)
					
					if (lastarmor[player] == nil) then
						lastarmor[player] = playerarmor[player]
					end
				
					if (aimsAt(player) or distance<limitdistance or reconx) then
						if not getElementData(player, "reconx") and not getElementData(player, "freecam:state") then
							local lx, ly, lz = getCameraMatrix()
							local vehicle = getPedOccupiedVehicle(player) or nil
							local collision, cx, cy, cz, element = processLineOfSight(lx, ly, lz, rx, ry, rz+1, true, true, true, true, false, false, true, false, vehicle)
								if not (collision) or aimsSniper() or (reconx) then
								local x, y, z = getElementPosition(player)
								
								if not (isPedDucked(player)) then
									z = z + 1
								else
									z = z + 0.5
								end
								
								local sx, sy = getScreenFromWorldPosition(x, y, z+0.1, 100, false)
								local oldsy = nil
								-- HP
								if (sx) and (sy) then
																		
									if (1>0) then
										distance = distance / 5
										
										if (reconx or aimsAt(player)) then distance = 1
										elseif (distance<1) then distance = 1
										elseif (distance>2) then distance = 2 end
										
										local offset = 45 / distance

										oldsy = sy 
									end
								end
								

								if (sx) and (sy) then
									if (distance<=2) then
										sy = math.ceil( sy + ( 2 - distance ) * 20 )
									end
									sy = sy + 10
									
									
									if (sx) and (sy) then
										
										if (4>5) then
											local offset = 45 / distance
											
											-- DRAW BG
											dxDrawRectangle(sx-offset-5, sy, 95 / distance, 20 / distance, tocolor(0, 0, 0, 100), false)
											
											-- DRAW HEALTH
											local width = 85
											local armorsize = (width / 100) * armor
											local barsize = (width / 100) * (100-armor)
											
											
											if (distance<1.2) then
												dxDrawRectangle(sx-offset, sy+5, armorsize/distance, 10 / distance, tocolor(197, 197, 197, 130), false)
												dxDrawRectangle((sx-offset)+(armorsize/distance), sy+5, barsize/distance, 10 / distance, tocolor(162, 162, 162, 100), false)
											else
												dxDrawRectangle(sx-offset, sy+5, armorsize/distance-5, 10 / distance-3, tocolor(197, 197, 197, 130), false)
												dxDrawRectangle((sx-offset)+(armorsize/distance-5), sy+5, barsize/distance-2, 10 / distance-3, tocolor(162, 162, 162, 100), false)
											end
										end
									end
									
									if (distance<=2) then
										sy = math.ceil( sy - ( 2 - distance ) * 40 )
									end
									sy = sy - 20
										
									if (sx) and (sy) then
										if (distance < 1) then distance = 1 end
										if (distance > 2) then distance = 2 end
										local offset = 75 / distance
										local scale = 1 / distance
										local r = 255
										local g = 255
										local b = 255--getPlayerNametagColor(player)
										local pedName = getElementData(player,"name") and tostring(getElementData(player,"name")):gsub("_", " ") or "The Storekeeper"
										dxDrawText(pedName, sx-offset+2, sy+2, (sx-offset)+130 / distance, sy+20 / distance, tocolor(0, 0, 0, 220), scale, font, "center", "center", false, false, false)
										dxDrawText(pedName, sx-offset, sy, (sx-offset)+130 / distance, sy+20 / distance, tocolor(r, g, b, 220), scale, font, "center", "center", false, false, false)
										local offset = 65 / distance
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), renderNametags)
function dxDrawBorderedText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak,postGUI) 
	for oX = -1, 1 do -- Border size is 1 
		for oY = -1, 1 do -- Border size is 1 
				dxDrawText(text, left + oX, top + oY, right + oX, bottom + oY, tocolor(20, 20, 20, 40), scale, font, alignX, alignY, clip, wordBreak,postGUI) 
		end 
	end 
	dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI) 
end  