wLicense, licenseList, bAcceptLicense, bCancel = nil
local Johnson = createPed(1489.0390625, 1305.6484375, 1093.2963867188)
setPedRotation(Johnson, 268.66101074219)
setElementDimension(Johnson, 105)
setElementInterior(Johnson, 3)
setElementData( Johnson, "talk", 1, false )
setElementData( Johnson, "name", "Carla Cooper", false )


local localPlayer = getLocalPlayer()

function showLicenseWindow()
	triggerServerEvent("onLicenseServer", getLocalPlayer())
	
	local vehiclelicense = getElementData(getLocalPlayer(), "license.car")
	local gunlicense = getElementData(getLocalPlayer(), "license.gun")

	local width, height = 300, 400
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)
	
	wLicense= guiCreateWindow(x, y, width, height, "Los Santos Surucu Kursu", false)
	
	licenseList = guiCreateGridList(0.05, 0.05, 0.9, 0.8, true, wLicense)
	local column = guiGridListAddColumn(licenseList, "License", 0.7)
	local column2 = guiGridListAddColumn(licenseList, "Cost", 0.2)
	
	if (vehiclelicense~=1) then
		local row = guiGridListAddRow(licenseList)
		guiGridListSetItemText(licenseList, row, column, "Car License", false, false)
		guiGridListSetItemText(licenseList, row, column2, "450", true, false)
	end
--[[if (gunlicense~=1) then
		local row2 = guiGridListAddRow(licenseList)
		guiGridListSetItemText(licenseList, row2, column, "Weapon License", false, false)
		guiGridListSetItemText(licenseList, row2, column2, "35,000", true, false)
	end --]]
				
	bAcceptLicense = guiCreateButton(0.05, 0.85, 0.45, 0.1, "Buy License", true, wLicense)
	bCancel = guiCreateButton(0.5, 0.85, 0.45, 0.1, "Cancel", true, wLicense)
	
	showCursor(true)
	
	addEventHandler("onClientGUIClick", bAcceptLicense, acceptLicense)
	addEventHandler("onClientGUIClick", bCancel, cancelLicense)
end
addEvent("onLicense", true)
addEventHandler("onLicense", getRootElement(), showLicenseWindow)

function acceptLicense(button, state)
	if (source==bAcceptLicense) and (button=="left") then
		local row, col = guiGridListGetSelectedItem(jobList)
		
		if (row==-1) or (col==-1) then
			outputChatBox("Please select a license first!", 255, 0, 0)
		else
			local license = 0
			local licensetext = guiGridListGetItemText(licenseList, guiGridListGetSelectedItem(licenseList), 1)
			local licensecost = tonumber(guiGridListGetItemText(licenseList, guiGridListGetSelectedItem(licenseList), 2))
			
			if (licensetext=="Car License") then
				license = 1
			end
			if (licensetext=="Weapon License") then
				license = 2
			end
			if (license==2) then
				triggerServerEvent("givewlicense", getLocalPlayer())
			end

			
			if (license>0) then
				if not exports.global:hasMoney( getLocalPlayer(), licensecost ) then
					outputChatBox("You cant afford that! Turn around and get some money out of the atm first!", 255, 0, 0)
				else
					if (license == 1) then
						if getElementData(getLocalPlayer(), "license.car") < 0 then
							outputChatBox( "You need to wait another " .. -getElementData(getLocalPlayer(), "license.car") .. " hours before being able to obtain a " .. licensetext .. ".", 255, 0, 0 )
						elseif (getElementData(getLocalPlayer(),"license.car")==0) then
							triggerServerEvent("payFee", getLocalPlayer(), 100)
							createlicenseTestIntroWindow() -- take the drivers theory test.
							destroyElement(licenseList)
							destroyElement(bAcceptLicense)
							destroyElement(bCancel)
							destroyElement(wLicense)
							wLicense, licenseList, bAcceptLicense, bCancel = nil, nil, nil, nil
							showCursor(false)
						elseif(getElementData(getLocalPlayer(),"license.car")==3) then
							initiateDrivingTest()
						end
					end
				end
			end
		end
	end
end

function cancelLicense(button, state)
	if (source==bCancel) and (button=="left") then
		destroyElement(licenseList)
		destroyElement(bAcceptLicense)
		destroyElement(bCancel)
		destroyElement(wLicense)
		wLicense, licenseList, bAcceptLicense, bCancel = nil, nil, nil, nil
		showCursor(false)
	end
end

   ------------ TUTORIAL QUIZ SECTION - SCRIPTED BY PETER GIBBONS (AKA JASON MOORE), ADAPTED BY CHAMBERLAIN --------------
   
   
   
   
questions = { 

	{"Yolun hangi tarafinda sürülmeli?", "Sag", "Sol", "Fark Etmez", 1},
	{"Dört seritli bir kavsakta, hangi sürücü önce gider?", "Soldaki sürücü.", "Sagdaki sürücü.", "Kavsaga ilk varan sürücü.", 2}, 
	{"Keskin dönüslere neden yavas girilmeli?", "Lastiklere bozulmasin diye.", "Karsida ne cikacagini görmek icin.", "Yolda biri varsa durmak icin.", 3},
	{"Kirmizi isik yandiginda ne yapmalisiniz?", "Arabayi durdurmak.", "Devam etmek.", "Kimse gelmiyorsa devam etmek.", 1},
	{"Sürücüler ne zaman yayalara saygi göstermelidir?", "Her Zaman.", "Özel Mülkde.", "Sadece kaldirimda. ", 1},
	{"Asagdakilerinden hangisinde kamyoncu seni göremez?", "Kasanin arkasinda.", "Kullanicinin solunda.", "Ikiside dogru." , 3},
	{"Arkanizdan bir acil durum araci geliyorsa ve sirenleri yaniyorsa ne yapmalisiniz?", "Yavaslayip sürmeye devam etmek.", "Sag'a cekip durmak.", "Hizini korumak. ", 2},
	{"Iki seritli veya daha fazla seritli bir yolda, sürücü hangi tarafta sürmelidir?", "Herhangi bir seritte.", "Soldaki seritte.", "Sollamadigin sürece sagda.", 3},
	{"Kötü bir havada diger sürücüler seni iyi görmesi icin ne yapmalisin:", "Ön farlasi acmalisin.", "Cakarlarini ve sirenlerini yakmalisin.", "Uzun farlarini yakmalisin.", 1},
	{"Yangin musluklarindan ne kadar uzakta durmalisin?", "10 feet", "15 feet", "20 feet", 2}
}

guiIntroLabel1 = nil
guiIntroProceedButton = nil
guiIntroWindow = nil
guiQuestionLabel = nil
guiQuestionAnswer1Radio = nil
guiQuestionAnswer2Radio = nil
guiQuestionAnswer3Radio = nil
guiQuestionWindow = nil
guiFinalPassTextLabel = nil
guiFinalFailTextLabel = nil
guiFinalRegisterButton = nil
guiFinalCloseButton = nil
guiFinishWindow = nil

-- variable for the max number of possible questions
local NoQuestions = 10
local NoQuestionToAnswer = 7
local correctAnswers = 0
local passPercent = 80
		
selection = {}

-- functon makes the intro window for the quiz
function createlicenseTestIntroWindow()
	
	showCursor(true)
	
	outputChatBox("You have paid the $100 fee to take the driving theory test.", source, 255, 194, 14)
	
	local screenwidth, screenheight = guiGetScreenSize ()
	
	local Width = 450
	local Height = 200
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	
	guiIntroWindow = guiCreateWindow ( X , Y , Width , Height , "Driving Theory Test" , false )
	
	guiCreateStaticImage (0.35, 0.1, 0.3, 0.2, "banner.png", true, guiIntroWindow)
	
	guiIntroLabel1 = guiCreateLabel(0, 0.3,1, 0.5, [[You will now proceed with the driving theory test. You will
be given seven questions based on basic driving theory. You must score
a minimum of 80 percent to pass.

Good luck.]], true, guiIntroWindow)
	
	guiLabelSetHorizontalAlign ( guiIntroLabel1, "center", true )
	guiSetFont ( guiIntroLabel1,"default-bold-small")
	
	guiIntroProceedButton = guiCreateButton ( 0.4 , 0.75 , 0.2, 0.1 , "Start Test" , true ,guiIntroWindow)
	
	addEventHandler ( "onClientGUIClick", guiIntroProceedButton,  function(button, state)
		if(button == "left" and state == "up") then
		
			-- start the quiz and hide the intro window
			startLicenceTest()
			guiSetVisible(guiIntroWindow, false)
		
		end
	end, false)
	
end


-- function create the question window
function createLicenseQuestionWindow(number)

	local screenwidth, screenheight = guiGetScreenSize ()
	
	local Width = 450
	local Height = 200
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	
	-- create the window
	guiQuestionWindow = guiCreateWindow ( X , Y , Width , Height , "Question "..number.." of "..NoQuestionToAnswer , false )
	
	guiQuestionLabel = guiCreateLabel(0.1, 0.2, 0.9, 0.2, selection[number][1], true, guiQuestionWindow)
	guiSetFont ( guiQuestionLabel,"default-bold-small")
	guiLabelSetHorizontalAlign ( guiQuestionLabel, "left", true)
	
	
	if not(selection[number][2]== "nil") then
		guiQuestionAnswer1Radio = guiCreateRadioButton(0.1, 0.4, 0.9,0.1, selection[number][2], true,guiQuestionWindow)
	end
	
	if not(selection[number][3] == "nil") then
		guiQuestionAnswer2Radio = guiCreateRadioButton(0.1, 0.5, 0.9,0.1, selection[number][3], true,guiQuestionWindow)
	end
	
	if not(selection[number][4]== "nil") then
		guiQuestionAnswer3Radio = guiCreateRadioButton(0.1, 0.6, 0.9,0.1, selection[number][4], true,guiQuestionWindow)
	end
	
	-- if there are more questions to go, then create a "next question" button
	if(number < NoQuestionToAnswer) then
		guiQuestionNextButton = guiCreateButton ( 0.4 , 0.75 , 0.2, 0.1 , "Next Question" , true ,guiQuestionWindow)
		
		addEventHandler ( "onClientGUIClick", guiQuestionNextButton,  function(button, state)
			if(button == "left" and state == "up") then
				
				local selectedAnswer = 0
			
				-- check all the radio buttons and seleted the selectedAnswer variabe to the answer that has been selected
				if(guiRadioButtonGetSelected(guiQuestionAnswer1Radio)) then
					selectedAnswer = 1
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer2Radio)) then
					selectedAnswer = 2
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer3Radio)) then
					selectedAnswer = 3
				else
					selectedAnswer = 0
				end
				
				-- don't let the player continue if they havn't selected an answer
				if(selectedAnswer ~= 0) then
					
					-- if the selection is the same as the correct answer, increase correct answers by 1
					if(selectedAnswer == selection[number][5]) then
						correctAnswers = correctAnswers + 1
					end
				
					-- hide the current window, then create a new window for the next question
					guiSetVisible(guiQuestionWindow, false)
					createLicenseQuestionWindow(number+1)
				end
			end
		end, false)
		
	else
		guiQuestionSumbitButton = guiCreateButton ( 0.4 , 0.75 , 0.3, 0.1 , "Submit Answers" , true ,guiQuestionWindow)
		
		-- handler for when the player clicks submit
		addEventHandler ( "onClientGUIClick", guiQuestionSumbitButton,  function(button, state)
			if(button == "left" and state == "up") then
				
				local selectedAnswer = 0
			
				-- check all the radio buttons and seleted the selectedAnswer variabe to the answer that has been selected
				if(guiRadioButtonGetSelected(guiQuestionAnswer1Radio)) then
					selectedAnswer = 1
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer2Radio)) then
					selectedAnswer = 2
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer3Radio)) then
					selectedAnswer = 3
				elseif(guiRadioButtonGetSelected(guiQuestionAnswer4Radio)) then
					selectedAnswer = 4
				else
					selectedAnswer = 0
				end
				
				-- don't let the player continue if they havn't selected an answer
				if(selectedAnswer ~= 0) then
					
					-- if the selection is the same as the correct answer, increase correct answers by 1
					if(selectedAnswer == selection[number][5]) then
						correctAnswers = correctAnswers + 1
					end
				
					-- hide the current window, then create the finish window
					guiSetVisible(guiQuestionWindow, false)
					createTestFinishWindow()


				end
			end
		end, false)
	end
end


-- funciton create the window that tells the
function createTestFinishWindow()

	local score = math.floor((correctAnswers/NoQuestionToAnswer)*100)

	local screenwidth, screenheight = guiGetScreenSize ()
		
	local Width = 450
	local Height = 200
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
		
	-- create the window
	guiFinishWindow = guiCreateWindow ( X , Y , Width , Height , "End of test.", false )
	
	if(score >= passPercent) then
	
		guiCreateStaticImage (0.35, 0.1, 0.3, 0.2, "pass.png", true, guiFinishWindow)
	
		guiFinalPassLabel = guiCreateLabel(0, 0.3, 1, 0.1, "Congratulations! You have passed this section of the test.", true, guiFinishWindow)
		guiSetFont ( guiFinalPassLabel,"default-bold-small")
		guiLabelSetHorizontalAlign ( guiFinalPassLabel, "center")
		guiLabelSetColor ( guiFinalPassLabel ,0, 255, 0 )
		
		guiFinalPassTextLabel = guiCreateLabel(0, 0.4, 1, 0.4, "You scored "..score.."%, and the pass mark is "..passPercent.."%. Well done!" ,true, guiFinishWindow)
		guiLabelSetHorizontalAlign ( guiFinalPassTextLabel, "center", true)
		
		guiFinalRegisterButton = guiCreateButton ( 0.35 , 0.8 , 0.3, 0.1 , "Continue" , true ,guiFinishWindow)
		
		-- if the player has passed the quiz and clicks on register
		addEventHandler ( "onClientGUIClick", guiFinalRegisterButton,  function(button, state)
			if(button == "left" and state == "up") then
				-- set player date to say they have passed the theory.
				

				initiateDrivingTest()
				-- reset their correct answers
				correctAnswers = 0
				toggleAllControls ( true )
				triggerEvent("onClientPlayerWeaponCheck", source)
				--cleanup
				destroyElement(guiIntroLabel1)
				destroyElement(guiIntroProceedButton)
				destroyElement(guiIntroWindow)
				destroyElement(guiQuestionLabel)
				destroyElement(guiQuestionAnswer1Radio)
				destroyElement(guiQuestionAnswer2Radio)
				destroyElement(guiQuestionAnswer3Radio)
				destroyElement(guiQuestionWindow)
				destroyElement(guiFinalPassTextLabel)
				destroyElement(guiFinalRegisterButton)
				destroyElement(guiFinishWindow)
				guiIntroLabel1 = nil
				guiIntroProceedButton = nil
				guiIntroWindow = nil
				guiQuestionLabel = nil
				guiQuestionAnswer1Radio = nil
				guiQuestionAnswer2Radio = nil
				guiQuestionAnswer3Radio = nil
				guiQuestionWindow = nil
				guiFinalPassTextLabel = nil
				guiFinalRegisterButton = nil
				guiFinishWindow = nil
				
				correctAnswers = 0
				selection = {}
				
				showCursor(false)
			end
		end, false)
		
	else -- player has failed, 
	
		guiCreateStaticImage (0.35, 0.1, 0.3, 0.2, "fail.png", true, guiFinishWindow)
	
		guiFinalFailLabel = guiCreateLabel(0, 0.3, 1, 0.1, "Sorry, you have not passed this time.", true, guiFinishWindow)
		guiSetFont ( guiFinalFailLabel,"default-bold-small")
		guiLabelSetHorizontalAlign ( guiFinalFailLabel, "center")
		guiLabelSetColor ( guiFinalFailLabel ,255, 0, 0 )
		
		guiFinalFailTextLabel = guiCreateLabel(0, 0.4, 1, 0.4, "You scored "..math.ceil(score).."%, and the pass mark is "..passPercent.."%." ,true, guiFinishWindow)
		guiLabelSetHorizontalAlign ( guiFinalFailTextLabel, "center", true)
		
		guiFinalCloseButton = guiCreateButton ( 0.2 , 0.8 , 0.25, 0.1 , "Close" , true ,guiFinishWindow)
		
		-- if player click the close button
		addEventHandler ( "onClientGUIClick", guiFinalCloseButton,  function(button, state)
			if(button == "left" and state == "up") then
				destroyElement(guiIntroLabel1)
				destroyElement(guiIntroProceedButton)
				destroyElement(guiIntroWindow)
				destroyElement(guiQuestionLabel)
				destroyElement(guiQuestionAnswer1Radio)
				destroyElement(guiQuestionAnswer2Radio)
				destroyElement(guiQuestionAnswer3Radio)
				destroyElement(guiQuestionWindow)
				destroyElement(guiFinalFailTextLabel)
				destroyElement(guiFinalCloseButton)
				destroyElement(guiFinishWindow)
				guiIntroLabel1 = nil
				guiIntroProceedButton = nil
				guiIntroWindow = nil
				guiQuestionLabel = nil
				guiQuestionAnswer1Radio = nil
				guiQuestionAnswer2Radio = nil
				guiQuestionAnswer3Radio = nil
				guiQuestionWindow = nil
				guiFinalFailTextLabel = nil
				guiFinalCloseButton = nil
				guiFinishWindow = nil
				
				selection = {}
				correctAnswers = 0
				
				showCursor(false)
			end
		end, false)
	end
	
end
 
 -- function starts the quiz
 function startLicenceTest()
 
	-- choose a random set of questions
	chooseTestQuestions()
	-- create the question window with question number 1
	createLicenseQuestionWindow(1)
 
 end
 
 
 -- functions chooses the questions to be used for the quiz
 function chooseTestQuestions()
 
	-- loop through selections and make each one a random question
	for i=1, 10 do
		-- pick a random number between 1 and the max number of questions
		local number = math.random(1, NoQuestions)
		
		-- check to see if the question has already been selected
		if(testQuestionAlreadyUsed(number)) then
			repeat -- if it has, keep changing the number until it hasn't
				number = math.random(1, NoQuestions)
			until (testQuestionAlreadyUsed(number) == false)
		end
		
		-- set the question to the random one
		selection[i] = questions[number]
	end
 end
 
 
 -- function returns true if the queston is already used
 function testQuestionAlreadyUsed(number)
 
	local same = 0
 
	-- loop through all the current selected questions
	for i, j in pairs(selection) do
		-- if a selected question is the same as the new question
		if(j[1] == questions[number][1]) then
			same = 1 -- set same to 1
		end
		
	end
	
	-- if same is 1, question already selected to return true
	if(same == 1) then
		return true
	else
		return false
	end
 end

---------------------------------------
------ Practical Driving Test ---------
---------------------------------------
 
testRoute = {
	{ 1092.5546875, -1744.9541015625, 13.555706977844 },	-- Start
	{ 1172.3232421875, -1753.662109375, 13.503225326538 },	-- 
	{ 1180.583984375, -1854.6533203125, 13.50319671630 },	-- 
	{ 1364.4638671875, -1871.7001953125, 13.488300323486 },	-- 
	{ 1590.302734375, -1874.7041015625, 13.486867904663 },	-- 
	{ 1701.41015625, -1814.896484375, 13.472445487976 },	-- 
	{ 1818.89453125, -1844.357421875, 13.518051147461 },	-- 
	{ 1977.880859375, -1935.0205078125, 13.485818862915 },	-- 
	{ 2084.828125, -1905.8388671875, 13.3828125 },	        -- 
	{ 2145.4384765625, -1897.1357421875, 13.128493309021 }, -- 
	{ 2215.7490234375, -1906.83203125, 13.144317626953 }, 	-- 
	{ 2226.431640625, -1974.8251953125, 13.150550842285  }, -- 
	{ 2299.4833984375, -1974.80078125, 13.153079032898 },   -- 
	{ 2415.873046875, -1958.26953125, 13.14902305603 }, 	-- 
	{ 2427.4697265625, -1935.0986328125, 13.13793182373 }, 	-- 
	{ 2488.513671875, -1939.33984375, 13.149515151978 }, 	-- 
	{ 2476.2431640625, -1953.32421875, 13.194999694824 },	-- 
	{ 2488.896484375, -1940.3984375, 13.154356956482 },	    -- 
	{ 2518.9951171875, -1919.3193359375, 13.147796630859 },	-- 
	{ 2519.25390625, -1819.572265625, 13.147236824036 },	-- 
	{ 2542.25390625, -1734.888671875, 13.155002593994 },	-- 
	{ 2645.2607421875, -1720.6748046875, 10.499878883362 },	-- 
	{ 2656.17578125, -1659.98828125, 10.477874755859 },	    -- 
	{ 2734.8544921875, -1643.6982421875, 12.766128540039 },	-- 
	{ 2730.5263671875, -1517.853515625, 30.03440284729 },	-- 
	{ 2710.4833984375, -1608.201171875, 12.900537490845 },	-- 
	{ 2506.0068359375, -1600.779296875, 17.073341369629 },	-- 
	{ 2372.8642578125, -1599.8623046875, 8.2977952957153 }, -- 
	{ 2152.7197265625, -1527.091796875, 2.1688795089722 }, 	-- 
	{ 1939.6396484375, -1497.1875, 3.082667350769 }, 	    -- 
	{ 1815.443359375, -1489.6416015625, 6.0986266136169 }, 	-- 
	{ 1782.5263671875, -1454.2021484375, 13.14845085144 }, 	-- 
	{ 1845.0888671875, -1473.3427734375, 13.159116744995 }, -- 
	{ 1819.666015625, -1597.7939453125, 13.12656211853 },   -- 
	{ 1819.6240234375, -1744.1943359375, 13.144682884216 }, -- 
	{ 1819.2822265625, -1843.810546875, 13.181602478027 }, 	-- 
	{ 1834.8359375, -1934.974609375, 13.144345283508 }, 	-- 
	{ 1946.69140625, -1934.810546875, 13.14790058136 }, 	-- 
	{ 2084.220703125, -1879.4326171875, 13.092319488525 },	--
	{ 2068.76953125, -1809.9345703125, 13.148040771484 },	--
	{ 1964.3720703125, -1798.3896484375, 13.148784637451 },	--
	{ 1927.0595703125, -1750.0947265625, 13.149410247803 },	--
	{ 1818.5654296875, -1730.2578125, 13.148732185364 },	--
	{ 1532.3330078125, -1720.6025390625, 13.149641990662 },	--
	{ 1517.298828125, -1589.6337890625, 13.149742126465 },	--
	{ 1431.8271484375, -1582.6611328125, 13.137134552002 },	--
	{ 1443.7373046875, -1438.24609375, 13.151012420654 },	--
	{ 1326.9365234375, -1393.2880859375, 13.131184577942 },	--
	{ 1060.5458984375, -1416.1005859375, 13.144618988037 },	--
	{ 1035.0107421875, -1585.486328125, 13.149500846863 },	--
	{ 1049.072265625, -1714.5078125, 13.154427528381 },		--
	{ 1171.78125, -1722.85546875, 13.406962394714 },		--
	{ 1092.1943359375, -1752.2041015625, 13.134586334229 },	--
}

testVehicle = { [436]=true } -- Previons need to be spawned at the start point.

local blip = nil
local marker = nil

function initiateDrivingTest()
	triggerServerEvent("theoryComplete", getLocalPlayer())
	local x, y, z = testRoute[1][1], testRoute[1][2], testRoute[1][3]
	blip = createBlip(x, y, z, 0, 2, 0, 255, 0, 255)
	marker = createMarker(x, y, z, "checkpoint", 4, 0, 255, 0, 150) -- start marker.
	addEventHandler("onClientMarkerHit", marker, startDrivingTest)
	
	outputChatBox("#FF9933You are now ready to take your practical driving examination. Collect a DMV test car and begin the route.", 255, 194, 14, true)
	
end

function startDrivingTest(element)
	if element == getLocalPlayer() then
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		local id = getElementModel(vehicle)
		if not (testVehicle[id]) then
			outputChatBox("#FF9933You must be in a DMV test car when passing through the checkpoints.", 255, 0, 0, true ) -- Wrong car type.
		elseif not exports.global:hasMoney( getLocalPlayer(), 100 ) then
			outputChatBox("You can't pay the processing fee.", 255, 0, 0 )
		else
			destroyElement(blip)
			destroyElement(marker)
			
			outputChatBox("You have paid the $100 fee to take the driving practical test.", source, 255, 194, 14)
			triggerServerEvent("payFee", getLocalPlayer(), 100)
			
			local vehicle = getPedOccupiedVehicle ( getLocalPlayer() )
			setElementData(getLocalPlayer(), "drivingTest.marker", 2, false)

			local x1,y1,z1 = nil -- Setup the first checkpoint
			x1 = testRoute[2][1]
			y1 = testRoute[2][2]
			z1 = testRoute[2][3]
			setElementData(getLocalPlayer(), "drivingTest.checkmarkers", #testRoute, false)

			blip = createBlip(x1, y1 , z1, 0, 2, 255, 0, 255, 255)
			marker = createMarker( x1, y1,z1 , "checkpoint", 4, 255, 0, 255, 150)
				
			addEventHandler("onClientMarkerHit", marker, UpdateCheckpoints)
				
			outputChatBox("#FF9933You will need to complete the route without damaging the test car. Good luck and drive safe.", 255, 194, 14, true)
		end
	end
end

function UpdateCheckpoints(element)
	if (element == localPlayer) then
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		local id = getElementModel(vehicle)
		if not (testVehicle[id]) then
			outputChatBox("You must be in a DMV test car when passing through the check points.", 255, 0, 0) -- Wrong car type.
		else
			destroyElement(blip)
			destroyElement(marker)
			blip = nil
			marker = nil
				
			local m_number = getElementData(getLocalPlayer(), "drivingTest.marker")
			local max_number = getElementData(getLocalPlayer(), "drivingTest.checkmarkers")
			
			if (tonumber(max_number-1) == tonumber(m_number)) then -- if the next checkpoint is the final checkpoint.
				outputChatBox("#FF9933Park your car at the #FF66CCin the parking lot #FF9933to complete the test.", 255, 194, 14, true)
				
				local newnumber = m_number+1
				setElementData(getLocalPlayer(), "drivingTest.marker", newnumber, false)
					
				local x2, y2, z2 = nil
				x2 = testRoute[newnumber][1]
				y2 = testRoute[newnumber][2]
				z2 = testRoute[newnumber][3]
				
				marker = createMarker( x2, y2, z2, "checkpoint", 4, 255, 0, 255, 150)
				blip = createBlip( x2, y2, z2, 0, 2, 255, 0, 255, 255)
				
				
				addEventHandler("onClientMarkerHit", marker, EndTest)
			else
				local newnumber = m_number+1
				setElementData(getLocalPlayer(), "drivingTest.marker", newnumber, false)
						
				local x2, y2, z2 = nil
				x2 = testRoute[newnumber][1]
				y2 = testRoute[newnumber][2]
				z2 = testRoute[newnumber][3]
						
				marker = createMarker( x2, y2, z2, "checkpoint", 4, 255, 0, 255, 150)
				blip = createBlip( x2, y2, z2, 0, 2, 255, 0, 255, 255)
				
				addEventHandler("onClientMarkerHit", marker, UpdateCheckpoints)
			end
		end
	end
end

function EndTest(element)
	if (element == localPlayer) then
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		local id = getElementModel(vehicle)
		if not (testVehicle[id]) then
			outputChatBox("You must be in a DMV test car when passing through the check points.", 255, 0, 0)
		else
			local vehicleHealth = getElementHealth ( vehicle )
			if (vehicleHealth >= 800) then
				if not exports.global:hasMoney( getLocalPlayer(), 250 ) then
					outputChatBox("You can't afford the $250 processing fee.", 255, 0, 0)
				else
					----------
					-- PASS --
					----------
					outputChatBox("After inspecting the vehicle we can see no damage.", 255, 194, 14)
					triggerServerEvent("acceptLicense", getLocalPlayer(), 1, 250)
				end
			else
				----------
				-- Fail --
				----------
				outputChatBox("After inspecting the vehicle we can see that it's damage.", 255, 194, 14)
				outputChatBox("You have failed the practical driving test.", 255, 0, 0)
			end
			
			destroyElement(blip)
			destroyElement(marker)
			blip = nil
			marker = nil
					
			removeElementData(thePlayer, "drivingTest.vehicle")
			
			removeElementData(thePlayer, "drivingTest.vehicle")	-- cleanup data
			removeElementData ( thePlayer, "drivingTest.marker" )
			removeElementData ( thePlayer, "drivingTest.checkmarkers" )
		end
	end
end

bindKey( "accelerate", "down",
	function( )
		local veh = getPedOccupiedVehicle( getLocalPlayer( ) )
		if veh and getVehicleOccupant( veh ) == getLocalPlayer( ) then
			if isElementFrozen( veh ) and getVehicleEngineState( veh ) then
				outputChatBox( "(( El frenini indirmek için G tuşuna basınız ))", 255, 194, 14 )
			elseif not getVehicleEngineState( veh ) then
				outputChatBox( "(( Aracınızı çalıştırmak için J tuşuna basınız.. ))", 255, 194, 14 )
			end
		end
	end
)