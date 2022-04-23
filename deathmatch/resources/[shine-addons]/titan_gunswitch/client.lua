Switch = Service:new('switchGun')
local font = exports.titan_fonts:getFont("Roboto",10)
screen = Vector2(guiGetScreenSize())
active = false
localPlayer = getLocalPlayer()
dxDrawImage = dxDrawImage
dxDrawText = dxDrawText

Switch.constructor = function()
	addEventHandler('onClientPlayerWeaponSwitch', getRootElement(), Switch.Draw)
end

Switch.Draw = function()
	if not active then
		active = true
		Switch.close()
		Switch.render = Timer(
			function()
				local weapon = localPlayer:getWeapon()
				local clip = localPlayer:getAmmoInClip()
		        local ammo = localPlayer:getTotalAmmo()
				dxDrawImage(screen.x/2-50, screen.y/6, 95, 95, "components/weapon/"..weapon..".png")
				dxDrawRoundedRectangle(screen.x/2-47, screen.y/6+92, 90, 20, tocolor(10,10,10,225))
				if (weapon >= 15 and weapon ~= 40 and weapon <= 44 or weapon >= 46) then
					dxDrawText(''..ammo-clip..'/'..clip..'', screen.x/2-27+1, screen.y/6+94, 150, 150, tocolor(0,0,0,255), 1, font)
					dxDrawText(''..ammo-clip..'/'..clip..'', screen.x/2-27, screen.y/6+94+1, 150, 150, tocolor(0,0,0,255), 1, font)
					dxDrawText(''..ammo-clip..'/'..clip..'', screen.x/2-27, screen.y/6+94-1, 150, 150, tocolor(0,0,0,255), 1, font)
					dxDrawText(''..ammo-clip..'/'..clip..'', screen.x/2-27-1, screen.y/6+94, 150, 150, tocolor(0,0,0,255), 1, font)
					dxDrawText(''..ammo-clip..'/'..clip..'', screen.x/2-27, screen.y/6+94, 150, 150, tocolor(200,200,200,250), 1, font)
				end
			end,
		0, 0)
	end
end

Switch.close = function()
	Switch._close = Timer(
		function()
			active = false
			killTimer(Switch.render)
		end,
	1500, 1)
end

Switch.constructor()
