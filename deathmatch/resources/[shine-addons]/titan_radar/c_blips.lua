
radarBlips = --- name : name,blip element,type,image,r,g,b
{
	["police"]={"İl Emniyet Müdürlüğü",createBlip (1552.119140625, -1675.4091796875,0,0,2,255,0,0,255,0,0),0,"police_hq",15,15,255, 255, 255},
	["advert"]={"TRT",createBlip ( 683.521484375, -1375.2763671875, 28.386959075928,0,2,255,0,0,255,0,0),0,"77",24,24,255, 255, 255},
	["hastane"]={"Hastane",createBlip (  1174.583984375, -1322.4384765625,0,0,2,255,0,0,255,0,0),0,"hospital",24,24,255, 255, 255},
	["job1"]={"Siparis Mesleği",createBlip (  2095.2197265625, -1803.2841796875,0,0,2,255,0,0,255,0,0),0,"job",24,24,255, 255, 255},
	["galeri"]={"Galeri",createBlip (  2156.0361328125, -2164.0078125,0,0,2,255,0,0,255,0,0),0,"car_shop",24,24,255, 255, 255},
	["sgr"]={"Sigara Kaçakçılığı",createBlip (  2244.21875, -2234.7177734375,0,0,2,255,0,0,255,0,0),0,"job",24,24,255, 255, 255},
	["alcl"]={"Alkol Kaçakçılığı",createBlip (  2192.1640625, -2201.0390625,0,0,2,255,0,0,255,0,0),0,"job",24,24,255, 255, 255},
	["mechanci"]={"Mekanik Ve Sanayi Sitesi",createBlip (  2875.90625, -1976.6904296875,0,0,2,255,0,0,255,0,0),0,"63",24,24,255, 255, 255},
	["bldy"]={"Belediye Binası",createBlip (  1480.7177734375, -1766.9384765625,0,0,2,255,0,0,255,0,0),0,"city_hall",24,24,255, 255, 255},
	["denzfner"]={"Deniz Feneri",createBlip (  154.1484375, -1938.78515625,0,0,2,255,0,0,255,0,0),0,"78",24,24,255, 255, 255},
	["galeri"]={"2 El Galeri ",createBlip (  1638.3330078125, -1150.7539062	,0,0,2,255,0,0,255,0,0),0,"car_shop",24,24,255, 255, 255},
	["gass"]={"Shell Benzinlik",createBlip (  999.79296875, -920.1601562,0,0,2,255,0,0,255,0,0),0,"gas_station",24,24,255, 255, 255},
	["bank"]={"Banka",createBlip (  1310.00390625, -1368.2451171875,0,0,2,255,0,0,255,0,0),0,"bank",24,24,255, 255, 255},
	["casino"]={"Alhambra",createBlip (  1836.365234375, -1682.7099609375,0,0,2,255,0,0,255,0,0),0,"casino",24,24,255, 255, 255},
	["benzin"]={"Benzinlik",createBlip (  1945.3046875, -1771.9052734375,0,0,2,255,0,0,255,0,0),0,"gas_station",24,24,255, 255, 255},
	["clothes_shop"]={"Binco",createBlip ( 2244.8046875, -1664.1103515625,0,0,2,255,0,0,255,0,0),0,"clothes_shop",24,24,255, 255, 255},
	["meth"]={"Meth Üretme ve Paketleme",createBlip (  -434.2119140625, -1396.7607421875,0,0,2,255,0,0,255,0,0),0,"job",24,24,255, 255, 255},
	["meth2"]={"Meth Satma",createBlip (  258.1201171875, -300.548828125,0,0,2,255,0,0,255,0,0),0,"job",24,24,255, 255, 255},


}
radarOwnBlips = {}

limitlessDistanceBlips = {}
setTimer(
	function()
		local blipIndex = 1
		for index, value in ipairs(getElementsByType("blip")) do
			if getBlipIcon(value) ~= 0 then
				local distanceStatus = limitlessDistanceBlips[getBlipIcon(value)] and 1 or 0
				radarBlips["blip_"..blipIndex] = {getElementData(value, "name") or "",value,distanceStatus,getBlipIcon(value),30,30,255,255,255}
				blipIndex = blipIndex + 1
			end
		end
	end,
1500, 0)



local free_ids = {}
local free_id = 1
function createOwnBlip(type,word_x,word_y)
	local name = ""
	if type == "mark_1" or type == "mark_2" or type == "mark_3" or type == "mark_4" then name = "Jelölés"
	elseif type == "garage" then name = "Garázs"
	elseif type == "house" then name = "Ház"
	elseif type == "vehicle" then name = "Jármű" end
    if not free_ids[type] then
        free_ids[type] = 0
    end
    local free_id = free_ids[type] + 1
	if not radarOwnBlips[name.." "..tostring(free_id)] then
		local element = createBlip (word_x,word_y,0,0,2,255,0,0,255,0,0)
		radarOwnBlips[name.." "..tostring(free_id)] = {name.." "..tostring(free_id),word_x,word_y,0,type,12,12,255,255,255}
		createStayBlip(name.." "..tostring(free_id),element,0,type,12,12,255,255,255)
		free_ids[type] = 1 
	else
		free_ids[type] = free_id+1
		createOwnBlip(type,word_x,word_y)
	end
end

function deleteOwnBlip(name)
	if radarOwnBlips[name] then
		destroyStayBlip(name)
		radarOwnBlips[name] = nil
	end
end

function jsonLoad()
	local json = fileOpen(":titan_radar/blips.json")
	local json_string = ""
	while not fileIsEOF(json) do
		json_string = json_string..""..fileRead(json,500)
	end
	fileClose(json)
	return fromJSON(json_string)
end

function jsonSave()
	if fileExists(":titan_radar/blips.json") then fileDelete(":titan_radar/blips.json") end
	local json = fileCreate(":titan_radar/blips.json")
		local json_string = toJSON(radarOwnBlips)
		fileWrite(json,json_string)
		fileClose(json)
end

addEventHandler( "onClientResourceStart",resourceRoot,function()
	if fileExists(":titan_radar/blips.json") then

		local blip_table = nil
		local json = fileOpen(":titan_radar/blips.json")
		local json_string = ""
		while not fileIsEOF(json) do
			json_string = json_string..""..fileRead(json,500)
		end
		fileClose(json)
		blip_table = fromJSON( json_string )
		for k, values in pairs(blip_table) do
			radarOwnBlips[values[1]] = {values[1],values[2],values[3],values[4],values[5],values[6],values[7],values[8],values[9],values[10]}
			createStayBlip(values[1],createBlip (values[2],values[3],0,0,2,255,0,0,255,0,0),values[4],values[5],values[6],values[7],values[8],values[9],values[10])
		end
	end
end)

addEventHandler( "onClientResourceStop",resourceRoot,function()
	 jsonSave()
end)



function createStayBlip(name,element,visible,image,imgw,imgh,imgr,imgg,imgb,no3d)
    radarBlips[name] = {name,element,visible,image,imgw,imgh,imgr,imgg,imgb,no3d}
end


function destroyStayBlip(name)
	radarBlips[name] = nil
end
setTimer(function()
    if getElementData(localPlayer,"faction") == 1 then
        for _,colshape in ipairs(getElementsByType("colshape")) do
            if getElementData(localPlayer,"faction") == 1 and isElement(colshape) and getElementData(colshape,"firepos",true) then
                local x,y,z = getElementPosition(colshape)
                createStayBlip("Silah Sesi",createBlip (x,y,z,0,2,255,0,0,255,0,0),0,"mark",24,24,255, 255, 255)
            else
                destroyStayBlip("Silah Sesi")
            end
        end
    else
        destroyStayBlip("Silah Sesi")
    end
end,0,0) 
