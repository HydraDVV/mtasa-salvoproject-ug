local rc = 10
local bmx = 0
local bike = 15
local low = 25
local offroad = 35
local sport = 100
local van = 50
local bus = 75
local truck = 220
local boat = 300
local heli = 500
local plane = 750
local race = 75
vehicleMaintenance = {
	70, 90, 160, 150, 18, 120, 300, 550, 150, 150, -- dumper, stretch
	15, 850, 15, 20, 25, 390, 150, heli, 30, 21,
	35, 30, 100, 80, 130, 1000, 35, 300, 260, 300, -- hunter
	480, 250, 1000, 165, 35, van, 10, 140, 80, 25, -- rhino
	15, rc, 35, 90, 1000, 120, 150, 990, 10, 0, -- monster, tram
	van, 675, 350, 350, 2000, 75, 35, 25, 25, van, -- caddie
	1000, 15, 10, 23, rc, rc, 30, 20, 30, 1230,
	130, 5, 250, 60, 95, 45, 150, 260, 15, 23, -- dinghy
	240, bmx, 95, 120, 900, 30, 300, 1300, 1300, 50, -- baggage, dozer
	140, 15, 95, 600, 350, 300, 70, heli, 100, 120,
	60, rc, 350, 350, 160, 50, 650, 110, 200, bmx,
	bmx, plane, 1147, 1013, 150, 340, 30, 20, 100, 2500,
	plane * 10, 20, 62, 90, 250, 80, 35, 60, 160, 25, -- hydra
	15, 15, 300, 110, 75, 40, 120, 0, 0, 3000, -- forklift, tractor, 2x train
	35, 440, 110, 20, 550, 35, 35, 19, heli, 18,
	15, 45, 65, plane, 70, 95, 1000, 1000, 40, 100, -- 2x monster
	50, 45, 200, heli, rc, 120, 30, 30, 120, 0, -- train trailer
	0, 20, 5, 320, 37, 130, 25, 3*plane, 240, 75,-- train trailer, kart, mower, sweeper, at400
	550, 40, 80, 17, van, 45, 10, 115, 200, 80,
	0, van, 2*plane, plane, rc, 170, low, low, low, offroad, -- train trailer, andromeda
	25, truck, 125, 75, 0, 0, low, low, low, 100,
	low, low
}