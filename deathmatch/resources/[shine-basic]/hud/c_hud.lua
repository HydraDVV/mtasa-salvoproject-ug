--MAXIME
screenWidth, screenHeight = guiGetScreenSize()
local localPlayer = getLocalPlayer()
local iconW, iconH = 34, 64
local actualIconSizeW, actualIconSizeW = 34, 64
local fontToolTip = "clear" --dxCreateFont ( ":resources/panel_tooltip.ttf" , 12)
local tooltip_background_color = tocolor( 0, 0, 0, 180 )
local tooltip_text_color = tocolor( 255, 255, 255, 255 )

--MAXIME / CHECK IF MOUSE IS WITHIN A DX BOX
function isInBox( x, y, xmin, xmax, ymin, ymax )
	--outputDebugString(tostring(x)..", "..tostring(y)..", "..tostring(xmin)..", "..tostring(xmax)..", "..tostring(ymin)..", "..tostring(ymax))
	return x >= xmin and x <= xmax and y >= ymin and y <= ymax --and not getElementData(localPlayer, "phoneRingingShowing")
end
--MAXIME / SHOW TOOLTIP AT CURSOR POSITION
function tooltip( x, y, text, text2 )
	text = tostring( text )
	if text2 then
		text2 = tostring( text2 )
	end
	
	if text == text2 then
		text2 = nil
	end
	
	local width = dxGetTextWidth( text, 1, fontToolTip ) + 20
	if text2 then
		width = math.max( width, dxGetTextWidth( text2, 1, fontToolTip ) + 20 )
		text = text .. "\n" .. text2
	end
	local height = 10 * ( text2 and 5 or 3 )
	x = math.max( 10, math.min( x, screenWidth - width - 10 ) )
	y = math.max( 10, math.min( y, screenHeight - height - 10 ) ) + iconH/3
	
	dxDrawRectangle( x, y, width, height, tooltip_background_color, true )
	dxDrawText( text, x, y, x + width, y + height, tooltip_text_color, 1, fontToolTip, "center", "center", false, false, true )
end

function drawHUD()
	local deneme = 0
	if not isPlayerMapVisible() and getElementData(localPlayer, "loggedin") == 1 and deneme == 1 then
		local ax, ay = screenWidth - iconW, getElementData(localPlayer, "annHeight") or 0
		local bx, by = screenWidth - iconW, screenHeight - iconH + 4
		local cursorX, cursorY, cwX, cwY, cwZ = getCursorPosition()
		local tooltips = {}
		local tooltips_bottom = {}
		local isBike = false
		
		--THIS IS TO LET THE FORUMS PM CHECKER KNOW WHERE TO DISPLAY
		setElementData(localPlayer, "hud:whereToDisplayY", ay)

		-- TOGGLE HUD / MAXIME
		if getElementData( localPlayer,"hide_hud" ) ~= "0" then
			dxDrawImage(ax,ay,iconH,iconH,"images/hud/tagmode.png")
			table.insert(tooltips, "settings:hud:tagmode:newstyle:on")
			ax = ax - iconW
		else
			dxDrawImage(ax,ay,iconH,iconH,"images/hud/tagmode.png", 0, 0, 0, disabled_item(100))
			table.insert(tooltips, "settings:hud:tagmode:newstyle:off")
			ax = ax - iconW
		end

		if isActive() then
			--GOLDEN NAMETAG / MAXIME
			if getElementData(localPlayer, "donation:nametag") then -- Golden nametag
				if getElementData(localPlayer, "nametag_on") then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/donor.png")
					table.insert(tooltips, "nametag_on")
					ax = ax - iconW
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/donor.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "nametag_off")
					ax = ax - iconW
				end
			else
				if getElementData(localPlayer, "donation:lifeTimeNameTag") then
					if getElementData(localPlayer, "lifeTimeNameTag_on") then
						dxDrawImage(ax,ay,iconH,iconH,"images/hud/donor.png")
						table.insert(tooltips, "lifeTimeNameTag_on")
						ax = ax - iconW
					else
						dxDrawImage(ax,ay,iconH,iconH,"images/hud/donor.png", 0, 0, 0, disabled_item(100))
						table.insert(tooltips, "lifeTimeNameTag_off")
						ax = ax - iconW
					end
				end
			end
			
			-- ADMIN TAG / MAXIME
			local isAdmin = exports.global:isPlayerAdmin(localPlayer)
			if isAdmin then
				if getElementData(localPlayer, "adminduty")  == 1  then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/adm_on.png")
					table.insert(tooltips, "adminonduty")
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/adm_on.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "adminoffduty")
				end
				ax = ax - iconW
			end
			
			-- GM TAG / MAXIME
			local isGM = exports.global:isPlayerGameMaster(localPlayer)
			if isGM then
				if getElementData( localPlayer,"account:gmduty" ) == 1 then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/gm.png")
					table.insert(tooltips, "gmonduty")
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/gm.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "gmoffduty")
				end
				ax = ax - iconW
			end
			
			
			--[[TOGGLE PMS / MAXIME
			local hasTogPM, togPMState = exports.donators:hasPlayerPerk(localPlayer, 1)
			if hasTogPM then
				if tonumber(togPMState) == 1 then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/togpm.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "settings:hud:togpm:off")
					ax = ax - iconW
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/togpm.png")
					table.insert(tooltips, "settings:hud:togpm:on")
					ax = ax - iconW
				end
			end
			
			TOGGLE DON CHAT / MAXIME
			local hasTogDon, togDonState = exports.donators:hasPlayerPerk(localPlayer, 10)
			if hasTogDon then
				if tonumber(togDonState) ~= 0 then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/togdon.png")
					table.insert(tooltips, "settings:hud:togdon:on")
					ax = ax - iconW
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/togdon.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "settings:hud:togdon:off")
					ax = ax - iconW
				end
			end
			]]--
			
			
			-- WALKING STYLE / MAXIME
			dxDrawImage(ax,ay,iconH,iconH,"images/hud/walkingstyle.png")
			table.insert(tooltips, "settings:hud:walkingstyle")
			ax = ax - iconW
			
			-- HEAD TURNING STYLE / MAXIME
			if getElementData( localPlayer,"head_turning" ) == "2" then
				dxDrawImage(ax,ay,iconH,iconH,"images/hud/head_turning.png")
				table.insert(tooltips, "settings:hud:head_turning:2")
				ax = ax - iconW
			else
				dxDrawImage(ax,ay,iconH,iconH,"images/hud/head_turning.png", 0, 0, 0, disabled_item(100))
				table.insert(tooltips, "settings:hud:head_turning:0")
				ax = ax - iconW
			end
			
			--[[ toggle hidden scoreboard / MAXIME
			local hasHidSco, hidScoState = exports.donators:hasPlayerPerk(localPlayer, 12)
			if hasHidSco then
				if tonumber(hidScoState) == 1 then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/hidden_scoreboard.png")
					table.insert(tooltips, "settings:hud:hidden_scoreboard:on")
					ax = ax - iconW
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/hidden_scoreboard.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "settings:hud:hidden_scoreboard:off")
					ax = ax - iconW
				end
			end]]--
			
			-- toggle hidden username / MAXIME
			--local hasHidUser, hidUser = exports.donators:hasPlayerPerk(localPlayer, 9)
			if hasHidUser then
				if tonumber(hidUser) == 1 then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/hide_username.png")
					table.insert(tooltips, "settings:hud:hidden_username:on")
					ax = ax - iconW
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/hide_username.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "settings:hud:hidden_username:off")
					ax = ax - iconW
				end
			end
			
			-- TOGGLE ADVERTS / MAXIME
			--local hasTogAd, togAdState = exports.donators:hasPlayerPerk(localPlayer, 2)
			if hasTogAd then
				if tonumber(togAdState) == 1 then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/togad.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips, "settings:hud:togad:off")
					ax = ax - iconW
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/togad.png")
					table.insert(tooltips, "settings:hud:togad:on")
					ax = ax - iconW
				end
			end
			
			--[[ARMOUR / MAXIME
			local armour = getPedArmor( localPlayer )
			if armour > 0 then
				dxDrawImage(ax,ay,iconH,iconH,"images/hud/armour.png")
				ax = ax - iconW
				table.insert(tooltips, "armour")
			end]]
			
			--[[MASKS / MAXIME
			for key, value in pairs(masks) do
				if getElementData(localPlayer, value[1]) then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/" .. value[1] .. ".png")
					ax = ax - iconW
					table.insert(tooltips, "mask")
				end
			end]]
			
			--[[BADGE / MAXIME
			local _, _, _, badge = getBadgeColor(localPlayer)
			if badge then
				if badge == 122 or badge == 123 or badge == 124 or badge == 125 or badge == 135 or badge == 136 then
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/bandana.png")
					table.insert(tooltips, badge)
				else
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/badge" .. tostring(badge) .. ".png")
					if badge == 2 then
						table.insert(tooltips, "pdduty")
					else
						table.insert(tooltips, "jobduty")
					end
				end
				ax = ax - iconW
			end]]
			
			if getElementData(localPlayer, "restrain") == 1 then
				dxDrawImage(ax,ay,iconH,iconH,"images/hud/handcuffs.png")
				ax = ax - iconW
				table.insert(tooltips, "handcuffs")
			end
								
			if exports['realism-system']:isLocalPlayerSmoking() then
				dxDrawImage(ax,ay,iconH,iconH,"images/hud/cigarette.png")
				ax = ax - iconW
				table.insert(tooltips, "cigarette")
			end
			
			--DEAGLE MODE / MAXIME
			if (getPedWeapon(localPlayer) == 24) and (getPedTotalAmmo(localPlayer) > 0) then
				local deagleMode = getElementData(localPlayer, "deaglemode")
				if (deagleMode == 0) then -- tazer
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/dtazer.png")
				elseif (deagleMode == 1) then-- lethal
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/dglock.png")
				elseif (deagleMode == 2) then-- radar
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/dradar.png")
				end
				ax = ax - iconW
				table.insert(tooltips, {"deaglemode", deagleMode})
			end
			
			--FIREMODE / MAXIME
			if (getPedWeapon(localPlayer)==31) or (getPedWeapon(localPlayer)==30) or (getPedWeapon(localPlayer)==29) or (getPedWeapon(localPlayer)==28) or (getPedWeapon(localPlayer)==32) and (getPedTotalAmmo(localPlayer) > 0) then
	            local fireMode = getElementData(localPlayer, "firemode")
	            if (fireMode == 0) then -- auto
	                dxDrawImage(ax,ay,iconH,iconH,"images/hud/auto.png")
	            elseif (fireMode == 1) then-- semi-auto
	                dxDrawImage(ax,ay,iconH,iconH,"images/hud/semiauto.png")
	            end
	            ax = ax - iconW
				table.insert(tooltips, "firemode")
	        end
			
			--SHOTGUN MODE / MAXIME
			--[[if (getPedWeapon(localPlayer) == 25) and (getPedTotalAmmo(localPlayer) > 0) then
				local shotgunMode = getElementData(localPlayer, "shotgunmode")
				if shotgunMode == 0 then -- bean bag
					dxDrawImage(ax,ay,iconW,iconW,"images/hud/shotbean2.png")
				elseif shotgunMode == 1 then -- lethal
					dxDrawImage(ax,ay,iconW,iconW,"images/hud/shotlethal2.png")
				end
				ax = ax - iconW
				table.insert(tooltips, {"shotgunmode", shotgunMode } )
			end]]
			

			-- hud icons for traditional - without showing local player names
			if getElementData(localPlayer, "settings_hud_style") ~= "1" then
				-- see the nametags file for definition
				local _, icons = getPlayerIcons('', localPlayer, true)
				for k = #icons, 1, -1 do
					local v = icons[k]
					dxDrawImage(ax,ay,iconH,iconH,"images/hud/" .. v .. ".png")

					ax = ax - iconW
					table.insert(tooltips, v)
				end
			end

			-- ads / MAXIME
			dxDrawImage(ax,ay,iconH,iconH,"images/hud/ads.png")
			table.insert(tooltips, "settings:hud:ads")
			ax = ax - iconW
		
			
			--HEATH / MAXIME
			local health = getElementHealth( localPlayer )
			dxDrawImage(ax,ay,iconH,iconH,"images/hud/health2.png", 0, 0, 0, disabled_item(255/100*health))
			ax = ax - iconW
			table.insert(tooltips, "health")
			ax = ax - iconW
			
			if #tooltips > 0 then
				setElementData(localPlayer, "hud:showingSomeIconsOnTopLeft", 40)
			else
				setElementData(localPlayer, "hud:showingSomeIconsOnTopLeft", 0)
			end
			
			--THIS IS TO LET THE FORUMS PM CHECKER KNOW WHERE TO DISPLAY
			setElementData(localPlayer, "hud:whereToDisplay", ax)
			

			local theVehicle = getPedOccupiedVehicle(localPlayer)
			if theVehicle then
				local vehType = getVehicleType(theVehicle)
				-- TOGGLE MODE / BOTTOM / MAXIME

				if getElementData(theVehicle, "handbrake") == 0 then
					if vehType == "Boat" then
						dxDrawImage(bx,by,iconH,iconH,"images/hud/boathandbrake.png", 0, 0, 0, disabled_item(100))
					else
						dxDrawImage(bx,by,iconH,iconH,"images/hud/handbrake.png", 0, 0, 0, disabled_item(100))
					end
					table.insert(tooltips_bottom, "settings:hud:handbrake:off")
					bx = bx - iconW
				else
					if vehType == "Boat" then
						dxDrawImage(bx,by,iconH,iconH,"images/hud/boathandbrake.png", 0, 0, 0)
					else
						dxDrawImage(bx,by,iconH,iconH,"images/hud/handbrake.png", 0, 0, 0)
					end
					table.insert(tooltips_bottom, "settings:hud:handbrake:on")
					bx = bx - iconW
				end

				--BELT / MAXIME
				if (getVehicleType(theVehicle) ~= "BMX" and getVehicleType(theVehicle) ~= "Bike") then
					if getElementData(localPlayer, "seatbelt") and getPedOccupiedVehicle(localPlayer) then
						dxDrawImage(bx,by,iconH,iconH,"images/hud/seatbelt.png")
						table.insert(tooltips_bottom, "belt:on")
					else
						dxDrawImage(bx,by,iconH,iconH,"images/hud/seatbelt.png", 0, 0, 0, disabled_item(100))
						table.insert(tooltips_bottom, "belt:off")
					end
					bx = bx - iconW

					--WINDOWS
					if (getElementData(theVehicle, "vehicle:windowstat") == 1) then
						dxDrawImage(bx,by,iconH,iconH,"images/hud/window2.png")
						table.insert(tooltips_bottom, "windowstat:down")
					else
						dxDrawImage(bx,by,iconH,iconH,"images/hud/window.png")
						table.insert(tooltips_bottom, "windowstat:up")
					end
					bx = bx - iconW

					--Lock 
					if isVehicleLocked(theVehicle) then
						dxDrawImage(bx,by,iconH,iconH,"images/hud/carlock.png")
						table.insert(tooltips_bottom, "hud:carlock:on")
					else
						dxDrawImage(bx,by,iconH,iconH,"images/hud/carlock.png", 0, 0, 0, disabled_item(100))
						table.insert(tooltips_bottom, "hud:carlock:off")
					end
					bx = bx - iconW
					isBike = false
				else
					isBike = true
				end

				bx = bx - iconW
				
				if getElementData( localPlayer,"speedo" ) == "1" then
					dxDrawImage(bx,by,iconH,iconH,"images/hud/speedo.png")
					table.insert(tooltips_bottom, "settings:hud:speedo:kmh")
					bx = bx - iconW
				elseif getElementData( localPlayer,"speedo" ) == "2" then
					dxDrawImage(bx,by,iconH,iconH,"images/hud/speedo.png")
					table.insert(tooltips_bottom, "settings:hud:speedo:mph")
					bx = bx - iconW
				else 
					dxDrawImage(bx,by,iconH,iconH,"images/hud/speedo.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips_bottom, "settings:hud:speedo:off")
					bx = bx - iconW
				end

				-- TOGGLE AUTOPARK / BOTTOM/ MAXIME 
				if getElementData( localPlayer,"autopark" ) == "1" then
					dxDrawImage(bx,by,iconH,iconH,"images/hud/autopark.png")
					table.insert(tooltips_bottom, "settings:hud:autopark:on")
					bx = bx - iconW
				else
					dxDrawImage(bx,by,iconH,iconH,"images/hud/autopark.png", 0, 0, 0, disabled_item(100))
					table.insert(tooltips_bottom, "settings:hud:autopark:off")
					bx = bx - iconW
				end
			end
		end

		--SHOWING TOOLTIP + ACTIONS ON CLIENT CLICK / MAXIME
		if isCursorShowing() then
			ax, ay = screenWidth, getElementData(localPlayer, "annHeight") or 0
			bx, by = screenWidth, screenHeight - iconH + 4
			cursorX, cursorY = cursorX * screenWidth, cursorY * screenHeight
			
			for i = 1, #tooltips do
				ax = ax - iconW
				if isInBox( cursorX, cursorY, ax, ax + iconW, ay, ay + iconH/2 ) then
					--ADMIN DUTY / MAXIME
					if tooltips[i] == "adminonduty" then
						tooltip( cursorX, cursorY, "Admin Gorevi Aktif", "Inaktif olmak icin tiklayiniz.")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", localPlayer, localPlayer, "adminduty", 0)
							triggerServerEvent("updateNametagColor", localPlayer, localPlayer)
							playToggleSound()
						end
					elseif tooltips[i] == "adminoffduty" then
						tooltip( cursorX, cursorY, "Admin Gorevi Inaktif", "Goreve gecmek icin tiklayiniz")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", localPlayer, localPlayer, "adminduty", 1)
							triggerServerEvent("updateNametagColor", localPlayer, localPlayer)
							playToggleSound()
						end
					--GM DUTY / MAXIME
					elseif tooltips[i] == "gmonduty" then
						tooltip( cursorX, cursorY, "Rehber Gorevi Aktif", "Inaktif olmak icin tiklayiniz.")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", localPlayer, localPlayer, "account:gmduty", 0)
							--triggerServerEvent("updateNametagColor", localPlayer)
							playToggleSound()
						end
					elseif tooltips[i] == "gmoffduty" then
						tooltip( cursorX, cursorY, "Rehber Gorevi Inaktif", "Goreve gecmek icin tiklayiniz")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", localPlayer, localPlayer, "account:gmduty", 1)
							--triggerServerEvent("updateNametagColor", localPlayer)
							playToggleSound()
						end
					--GOLDEN NAMETAGE / MAXIME
					elseif tooltips[i] == "nametag_on" then
						tooltip( cursorX, cursorY, "Altin Isim Tagi", "Son tarih: "..(getElementData(localPlayer, "donation:nametag:expiredate") or "Guncelleniyor.."))
						if justClicked then
							triggerServerEvent("global:toggleGoldenNametag", localPlayer, localPlayer)
							playToggleSound()
						end
					elseif tooltips[i] == "nametag_off" then
						tooltip( cursorX, cursorY, "Altin Isim Tagi InAktif", "Son Tarih: "..(getElementData(localPlayer, "donation:nametag:expiredate") or "Guncelleniyor.."))
						if justClicked then
							triggerServerEvent("global:toggleGoldenNametag", localPlayer, localPlayer)
							playToggleSound()
						end
					elseif tooltips[i] == "lifeTimeNameTag_on" then
						tooltip( cursorX, cursorY, "Altin Isim Tagi Aktif", "Son Tarih: Sinirsiz")
						if justClicked then
							triggerServerEvent("global:toggleGoldenNametag", localPlayer, localPlayer)
							playToggleSound()
						end
					elseif tooltips[i] == "lifeTimeNameTag_off" then
						tooltip( cursorX, cursorY, "Altin Isim Tagi Inaktif", "Son Tarih: Sinirsiz")
						if justClicked then
							triggerServerEvent("global:toggleGoldenNametag", localPlayer, localPlayer)
							playToggleSound()
						end
					-- BADGE / MAXIME
					elseif tooltips[i] == "pdduty" then
						tooltip( cursorX, cursorY, "Polis Gorevi Aktif", "Inaktif olmak icin tiklayiniz.")
						if justClicked then
							triggerServerEvent("item-system:toggleBadge", localPlayer, localPlayer, exports['item-system']:getBadges(), 64 , "Test")
							playToggleSound()
						end
					elseif tooltips[i] == "jobduty" then
						tooltip( cursorX, cursorY, "Meslek Gorevi Aktif")
						if justClicked then
							triggerServerEvent("item-system:toggleBadge", localPlayer, localPlayer, exports['item-system']:getBadges(), 64 , "Test")
							playToggleSound()
						end
					--BANDANA / MAXIME
					elseif tooltips[i] == 122 or tooltips[i] == 123 or tooltips[i] == 124 or tooltips[i] == 125 or tooltips[i] == 135 or tooltips[i] == 136 then
						tooltip( cursorX, cursorY, "Bandana aktif", "Cikarmak icin tiklayiniz")
						if justClicked then
							triggerServerEvent("item-system:toggleBadge", localPlayer, localPlayer, exports['item-system']:getBadges(), tooltips[i] , "Test")
							playToggleSound()
						end
					--HP / MAXIME
					elseif tooltips[i] == "health" then
						tooltip( cursorX, cursorY, "Bu simge sizin saglikli oldugunuzun simgesidir.")
						if justClicked then
							--setElementData( localPlayer,"report_panel_mod", true )
							--playToggleSound()
						end
					--STYLE / MAXIME
					elseif tooltips[i] == "settings:hud:tagmode:newstyle:on" then
						tooltip( cursorX, cursorY, "HUD Aktif", "Tikla ve gizle.")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", localPlayer, localPlayer, "hide_hud", "0")
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:tagmode:newstyle:off" then
						tooltip( cursorX, cursorY, "HUD Gizli", "Tikla ve aktif et.")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", localPlayer, localPlayer, "hide_hud", "1")
							playToggleSound()
						end
					--WALKING STYLE / MAXIME
					elseif tooltips[i] == "settings:hud:walkingstyle" then
						tooltip( cursorX, cursorY, "Yuruyus Sekli: "..tostring(getElementData(localPlayer,"walkingstyle")), "Tiklayarak yuruyusunuzu degistirin.")
						if justClicked then
							triggerServerEvent("realism:switchWalkingStyle", localPlayer)
							playToggleSound()
						end
					--AUTOPARK / MAXIME
					elseif tooltips[i] == "settings:hud:autopark:on" then
						tooltip( cursorX, cursorY, "Otomatik Park Sistemi Aktif", "Kapatmak icin tiklayin.")
						if justClicked then
							triggerEvent("accounts:settings:updateAccountSettings", localPlayer, "autopark", "0")
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:autopark:off" then
						tooltip( cursorX, cursorY, "Otomatik Park Sistemi Inaktif", "Aktif etmek icin tiklayin.")
						if justClicked then
							triggerEvent("accounts:settings:updateAccountSettings", localPlayer, "autopark", "1")
							playToggleSound()
						end
				
					-- ARMOR / MAXIME
					elseif tooltips[i] == "armour" then
						tooltip( cursorX, cursorY, "You are wearing body armor.")
					-- DEAGLEMODE / MAXIME
					elseif tooltips[i][1] == "deaglemode" then
						local mode = tooltips[i][2]
						if mode == 0 then
							tooltip( cursorX, cursorY, "Taze modu", "Lethal Modu icin tiklayin")
						elseif mode == 1 then
							tooltip( cursorX, cursorY, "Lethal modu", "Radar Modu icin tiklayin")
						elseif mode == 2 or mode == 1 then
							tooltip( cursorX, cursorY, "Radar modu", "Taze Modu icin tiklayin")
						end
						if justClicked then
							exports["pd-system"]:switchMode()
							playToggleSound()
						end
					-- SHOTGUN / MAXIME
					elseif tooltips[i][1] == "shotgunmode" then
						local mode = tooltips[i][2]
						--local team = getPlayerTeam(localPlayer)
						if mode == 0 then
							tooltip( cursorX, cursorY, "Beanbag modu", "Lethal modu icin tiklayin")
						elseif mode == 1 then
							tooltip( cursorX, cursorY, "Lethal modu", "Beanbag modu icin tiklayin")
						end
						if justClicked then
							exports["pd-system"]:switchMode()
							playToggleSound()
						end
					-- HEAD TURNING / MAXIME
					elseif tooltips[i] == "settings:hud:head_turning:0" then
						tooltip( cursorX, cursorY, "Kafayi dondurmek", "Acmak icin tiklayin.")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", getLocalPlayer(), getLocalPlayer(), "head_turning", "2")
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:head_turning:2" then
						tooltip( cursorX, cursorY, "Etrafa rahatlikla bakabilirsiniz.", "Diger moda gecmek icin tiklayin.")
						if justClicked then
							triggerServerEvent("anticheat:changeEld", getLocalPlayer(), getLocalPlayer(), "head_turning", "0")
							playToggleSound()
						end
					--TOGAD / MAXIME
					elseif tooltips[i] == "settings:hud:togad:on" then
						tooltip( cursorX, cursorY, "Reklam aktif", "Tikla ve kapat.")
						if justClicked then
							triggerServerEvent("chat:togad", localPlayer,localPlayer)
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:togad:off" then
						tooltip( cursorX, cursorY, "Reklam Inaktif", "Tikla ve aktif et.")
						if justClicked then
							triggerServerEvent("chat:togad", localPlayer,localPlayer)
							playToggleSound()
						end
					--TOGPM / MAXIME
					elseif tooltips[i] == "settings:hud:togpm:on" then
						tooltip( cursorX, cursorY, "Ozel Mesajlar Aktif", "Kapatmak icin tiklayiniz.")
						if justClicked then
							triggerServerEvent("chat:togpm", localPlayer,localPlayer)
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:togpm:off" then
						tooltip( cursorX, cursorY, "Ozel Mesajlar Inaktif", "Acmak icin tiklayiniz.")
						if justClicked then
							triggerServerEvent("chat:togpm", localPlayer,localPlayer)
							playToggleSound()
						end
					--TOGDON / MAXIME
					elseif tooltips[i] == "settings:hud:togdon:on" then
						tooltip( cursorX, cursorY, "Donator sohbet Aktif", "Click to ignore incoming messages.")
						if justClicked then
							exports.donators:updatePerkValue(localPlayer, 10, 0)
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:togdon:off" then
						tooltip( cursorX, cursorY, "Donator sohbet Inaktif", "Click to receive incoming messages.")
						if justClicked then
							exports.donators:updatePerkValue(localPlayer, 10, 1)
							playToggleSound()
						end
					--tog hidden from scoreboard / MAXIME
					elseif tooltips[i] == "settings:hud:hidden_scoreboard:on" then
						tooltip( cursorX, cursorY, "You're now hidden from scoreboard", "Click to reveal.")
						if justClicked then
							exports.donators:updatePerkValue(localPlayer, 12, 0)
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:hidden_scoreboard:off" then
						tooltip( cursorX, cursorY, "You're now visible in scoreboard", "Click to hide.")
						if justClicked then
							exports.donators:updatePerkValue(localPlayer, 12, 1)
							playToggleSound()
						end
					--tog hidden username / maxime
					elseif tooltips[i] == "settings:hud:hidden_username:on" then
						tooltip( cursorX, cursorY, "Kullanici isimleri Gizli.", "Aktif etmek icin tiklayin.")
						if justClicked then
							exports.donators:updatePerkValue(localPlayer, 9, 0)
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:hidden_username:off" then
						tooltip( cursorX, cursorY, "Kullanici isimleri Aktif.", "Gizlemek icin tiklayin.")
						if justClicked then
							exports.donators:updatePerkValue(localPlayer, 9, 1)
							playToggleSound()
						end
					elseif tooltips[i] == "settings:hud:ads" then
						tooltip( cursorX, cursorY, "Reklam Olustur.", "Reklam olusturmak icin tiklayin. Reklamlari yonetmek icin /ads yazin.")
						if justClicked then
							triggerServerEvent("advertisements:open_ads", localPlayer)
							playToggleSound()
						end
					elseif justClicked then
						outputDebugString('Siz tikladiniz ' .. tooltips[i])
					end
				end
			end

			for i = 1, #tooltips_bottom do
				bx = bx - iconW
				if isInBox( cursorX, cursorY, bx, bx + iconW, by, by + iconH/2 ) then
					--AUTOPARK / BOTTOM / MAXIME
					
					if tooltips_bottom[i] == "settings:hud:engine:on" then
						tooltip( cursorX, cursorY, "Motor - Aktif", "'J' ve /engine")
						if justClicked then
							triggerServerEvent("toggleEngine", localPlayer, localPlayer)
							playToggleSound()
						end
					elseif tooltips_bottom[i] == "settings:hud:engine:off" then
						tooltip( cursorX, cursorY, "Motor - Inaktif", "'J' ve /engine")
						if justClicked then
							triggerServerEvent("toggleEngine", localPlayer, localPlayer)
							playToggleSound()
						end

					elseif tooltips_bottom[i] == "settings:hud:handbrake:on" then
						if isBike then
							tooltip( cursorX, cursorY, "Elfreni - Aktif", "'G' ve /kickstand")
						else
							tooltip( cursorX, cursorY, "Elfreni - Aktif", "'G' ve /handbrake")
						end
						if justClicked then
							exports['realism-system']:doHandbrake()
							playToggleSound()
						end
					elseif tooltips_bottom[i] == "settings:hud:handbrake:off" then
						if isBike then
							tooltip( cursorX, cursorY, "Elfreni - Inaktif", "'G' ve /kickstand")
						else
							tooltip( cursorX, cursorY, "Elfreni - Inaktif", "'G' ve /handbrake")
						end
						if justClicked then
							exports['realism-system']:doHandbrake()
							playToggleSound()
						end

					elseif tooltips_bottom[i] == "settings:hud:headlights:off" then
						tooltip( cursorX, cursorY, "Arac Farlari - Inaktif", "'L' ve /lights")
						if justClicked then
							triggerServerEvent('togLightsVehicle', localPlayer)
							playToggleSound()
						end

					elseif tooltips_bottom[i] == "settings:hud:headlights:on" then
						tooltip( cursorX, cursorY, "Arac Farlari - Aktif", "'L' ve /lights")
						if justClicked then
							triggerServerEvent('togLightsVehicle', localPlayer)
							playToggleSound()
						end

					elseif tooltips_bottom[i] == "hud:carlock:on" then
						tooltip( cursorX, cursorY, "Kapilar Kitli", "'K' ve /lock")
						if justClicked then
							triggerServerEvent('togLockVehicle', localPlayer, localPlayer)
							playToggleSound()
						end

					elseif tooltips_bottom[i] == "hud:carlock:off" then
						tooltip( cursorX, cursorY, "Kapilar Acik", "'K' ve /lock")
						if justClicked then
							triggerServerEvent('togLockVehicle', localPlayer, localPlayer)
							playToggleSound()
						end

					elseif tooltips_bottom[i] == "settings:hud:speedo:off" then
						tooltip( cursorX, cursorY, "Hiz Kitleme Modu - Inaktif", " ")
						if justClicked then
							triggerEvent("accounts:settings:updateAccountSettings", localPlayer, "speedo", "1")
							playToggleSound()
						end
					elseif tooltips_bottom[i] == "settings:hud:speedo:kmh" then
						tooltip( cursorX, cursorY, "Hiz Kitleme Modu - KM/H", " ")
						if justClicked then
							triggerEvent("accounts:settings:updateAccountSettings", localPlayer, "speedo", "2")
							playToggleSound()
						end
					elseif tooltips_bottom[i] == "settings:hud:speedo:mph" then
						tooltip( cursorX, cursorY, "Hiz Kitleme - MPH", " ")
						if justClicked then
							triggerEvent("accounts:settings:updateAccountSettings", localPlayer, "speedo", "0")
							playToggleSound()
						end
					-- seatbelt
					elseif tooltips_bottom[i] == 'belt:on' then
						tooltip( cursorX, cursorY, 'Emniyet kemerinizi takmak icin.', "'Z' veya /belt")
						if justClicked then
							--triggerServerEvent('realism:seatbelt:toggle', localPlayer, localPlayer)
							playToggleSound()
						end
					elseif tooltips_bottom[i] == 'belt:off' then
						tooltip( cursorX, cursorY, 'Emniyet kemerinizi cikarmak icin.', "'Z' veya /belt")
						if justClicked then
							--triggerServerEvent('realism:seatbelt:toggle', localPlayer, localPlayer)
							playToggleSound()
						end
					--Window state
					elseif tooltips_bottom[i] == 'windowstat:up' then
						tooltip( cursorX, cursorY, 'Cami acmak icin.', "'X' veya /togwindow")
						if justClicked then
							triggerServerEvent('vehicle:togWindow', localPlayer)
							playToggleSound()
						end
					elseif tooltips_bottom[i] == 'windowstat:down' then
						tooltip( cursorX, cursorY, 'Cami kapatmak icin.', "'X' veya /togwindow")
						if justClicked then
							triggerServerEvent('vehicle:togWindow', localPlayer)
							playToggleSound()
						end
					--CC state
					elseif tooltips_bottom[i] == 'cc:on' then
						tooltip( cursorX, cursorY, 'Hiz Kitleme Sistemi Aktif.', "'C' veya /cc")
						if justClicked then
							triggerEvent('realism:togCc', localPlayer)
							playToggleSound()
						end
					elseif tooltips_bottom[i] == 'cc:off' then
						tooltip( cursorX, cursorY, 'Hiz Kitleme Sistemi Inaktif.', "'C' veya /cc")
						if justClicked then
							triggerEvent('realism:togCc', localPlayer)
							playToggleSound()
						end
					-- auto park
					elseif tooltips_bottom[i] == "settings:hud:autopark:on" then
						tooltip( cursorX, cursorY, "Aracin otomatik park olmasi Aktif", "Kapatmak icin tiklayiniz.")
						if justClicked then
							triggerEvent("accounts:settings:updateAccountSettings", localPlayer, "autopark", "0")
							playToggleSound()
						end
					elseif tooltips_bottom[i] == "settings:hud:autopark:off" then
						tooltip( cursorX, cursorY, "Aracin otomatik park olmasi Inaktif", "Aktif etmek icin tiklayiniz.")
						if justClicked then
							triggerEvent("accounts:settings:updateAccountSettings", localPlayer, "autopark", "1")
							playToggleSound()
						end
					elseif tooltips_bottom[i] == "settings:hud:mdc" then
						tooltip( cursorX, cursorY, "Mobil Dijital Bilgisayar", "Tiklayip acin.")
						if justClicked then
							executeCommandHandler("mdc")
							playToggleSound()
						end
					end
				end
			end
		end
	end
	justClicked = false
end
--addEventHandler("onClientRender", getRootElement(), drawHUD)

function playToggleSound()
	playSound(":resources/toggle.mp3")
end

--[[
addCommandHandler( "togglehud",
	function( )
		active = not active
		if active then
			outputChatBox( "HUD is now on.", 0, 255, 0 )
			triggerEvent( "item:updateclient", localPlayer )
		else
			outputChatBox( "HUD is now off.", 255, 0, 0 )
			setPlayerHudComponentVisible( 'radar', false )
		end
	end
)
]]

function isActive()
	return getElementData(localPlayer, "hide_hud") ~= "0"
end

--[[TO DETECT CLICK ON DX BOX / MAXIME
addEventHandler( "onClientClick", root,
	function( button, state )
		if button == "left" and state == "up" then
			justClicked = true
		end
	end
)]]

function disabled_item(value)
	return tocolor(value,value,value)
end

local function explode(div,str)
  if (div=='') then return false end
  local pos,arr = 0,{}
  for st,sp in function() return string.find(str,div,pos,true) end do
	table.insert(arr,string.sub(str,pos,st-1))
	pos = sp + 1
  end
  table.insert(arr,string.sub(str,pos))
  return arr
end



--[[
--lalt+Mouse2 to toggle cursor / MAXIME
local holdingShift = nil
function togMouse(button, press)
	if button == "lalt" then
		if press then
			holdingShift = true
		else
			holdingShift = nil
		end
	end
end
addEventHandler("onClientKey", root, togMouse)
function togMouse2 ( button, press)
    if button == "mouse2" and press and holdingShift then
        showCursor ( not isCursorShowing() )        
        cancelEvent()          
    end
end
addEventHandler("onClientKey", root, togMouse2)
]]