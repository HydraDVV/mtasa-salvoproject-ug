local sx,sy = guiGetScreenSize ()
local chatData = getChatboxLayout()
local oocState = true
local maxLines = 12
local oocMessages = {}
local font = "default-bold"
local _,scale = chatData["chat_scale"]
local bg = {chatData["chat_color"]}
local color = {205,205,205,255}
local lines = chatData["chat_lines"]
local chatX,chatY = 0.015625*sx,16 + 15*lines + 50

addEventHandler ("onClientRender",getRootElement(),
	function ()
		if getElementData(getLocalPlayer(), "loggedin") == 1 then
			if oocState then
				dxDrawText ("[Safak Roleplay] OOC'yi kapatmak için /togooc, chat'i temizlemek için /tamizle",chatX+1,chatY+1,0,0,tocolor(0,0,0,255),1,font,"left","top",false,false,false)
				dxDrawText ("#6C97FB[Safak Roleplay]#ffffff OOC'yi kapatmak için /togooc, chat'i temizlemek için /tamizle",chatX,chatY,0,0,0,tocolor(255,255,0,255),1,font,"left","top", 255, 255, 255,true)
				for k,v in ipairs(oocMessages) do
					local tx,ty = chatX,chatY + (maxLines+2)*15 - k*15
					dxDrawText (v,tx+1,ty+1,0,0,tocolor(0,0,0,255),1,font,"left","top",false,false,false)
					dxDrawText (v,tx,ty,0,0,tocolor(color[1],color[2],color[3],color[4]),1,font,"left","top",false,false,false)
				end
			end
		end
	end
)

addEvent ("onOOCMessageSend",true)
addEventHandler ("onOOCMessageSend",getRootElement(),
	function (message)
		local player = source
		local int,dim = getElementInterior (player),getElementDimension(player)
		if int == getElementInterior (getLocalPlayer()) and dim == getElementDimension (getLocalPlayer()) then
			-- local visibleName = getElementData (player,"visibleName")
			-- if visibleName then
				local length = #oocMessages
				if #oocMessages >= maxLines then
					table.remove (oocMessages,maxLines)
				end
				local text = message
				-- local text = visibleName .. ": (( " .. message .. " ))"
				table.insert (oocMessages,1,text)
				if player ~= getLocalPlayer () then
					outputConsole (text)
				end
			-- end
		end
	end
)

function isOOCChatToggled ()
	return oocState
end

function toggleOOCChat (state)
	if state ~= oocState then
		oocState = state
	end
end

function togOOCCMD (cname,arg)
	-- if arg == "ooc" or arg == "OOC" then
		toggleOOCChat (not oocState)
	-- end
end
addCommandHandler ("togooc",togOOCCMD)

function co ()
	for k in pairs (oocMessages) do
    oocMessages[k] = nil
end
end
addCommandHandler ("/temizle",co)