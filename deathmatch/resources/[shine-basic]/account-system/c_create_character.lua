local gui = {}
local curskin = 1
local dummyPed = nil
local languageselected = 1
function newCharacter_init()
	guiSetInputEnabled(true)
	setCameraInterior(0)
	setCameraMatrix(1142.000000, -1151.587890625, 24.841033935547, 1141.986328125, -1158.662109375, 23.828125 )
	dummyPed = createPed(2, 1142.1865234375, -1156.650390625, 23.828125 )
	setElementInterior(dummyPed, 0)
	setElementInterior(getLocalPlayer(), 0)
	setPedRotation(dummyPed, 2.590087890625)
	setElementDimension(dummyPed, getElementDimension(getLocalPlayer()))
	
	local screenX, screenY = guiGetScreenSize()
	
	gui["_root"] = guiCreateWindow(0, screenY/2-65, 480, 207, "kendi hikayeni kendin yaz...unutma karakterini özenli ve ciddi bir amaç için oluştur.", false)
	guiWindowSetSizable(gui["_root"], false)
	guiWindowSetMovable(gui["_root"], true)
	
	gui["lblCharName"] = guiCreateLabel(80, 25, 91, 16, "Karakter İsmi:", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["lblCharName"], "center", false)
	guiSetFont(gui["lblCharName"], "default-bold-small") 
	
	gui["txtCharName"] = guiCreateEdit(52, 40, 151, 23, "", false, gui["_root"])
	guiEditSetMaxLength(gui["txtCharName"], 32767)
	guiSetFont(gui["txtCharName"], "default-bold")
	
	gui["lblCharNameExplanation"] = guiCreateLabel(9, 65, 240, 80,"Seçtiğiniz isim bi ünlü ismi veya\ntroll bir isim olamaz.", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["lblCharNameExplanation"], "center", false)

	gui["lblCharDescExplanation"] = guiCreateLabel(10, 245, 231, 61, "", false, gui["_root"])
	--guiLabelSetHorizontalAlign(gui["lblCharDescExplanation"], "left", false)
	--guiLabelSetVerticalAlign(gui["lblCharDescExplanation"], "center")
	
	gui["lblGender"] = guiCreateLabel(105, 125, 46, 13, "Cinsiyet", false, gui["_root"])
	guiSetFont(gui["lblGender"], "default-bold-small")
	guiLabelSetHorizontalAlign(gui["lblGender"], "left", false)
	guiLabelSetVerticalAlign(gui["lblGender"], "center")
	gui["rbMale"] = guiCreateRadioButton(70, 141, 51, 17, "Erkek", false, gui["_root"])
	gui["rbFemale"] = guiCreateRadioButton(130, 141, 82, 17, "Kadın", false, gui["_root"])
	guiRadioButtonSetSelected ( gui["rbMale"], true)
	addEventHandler("onClientGUIClick", gui["rbMale"], newCharacter_updateGender, false)
	addEventHandler("onClientGUIClick", gui["rbFemale"], newCharacter_updateGender, false)
	
	gui["lblSkin"] = guiCreateLabel(310, 20, 80, 16, "Tip Seç: ", false, gui["_root"])
	guiSetFont(gui["lblSkin"], "default-bold-small")
	guiLabelSetHorizontalAlign(gui["lblSkin"], "left", false)
	guiLabelSetVerticalAlign(gui["lblSkin"], "center")
	
	gui["btnPrevSkin"] = guiCreateButton(220, 40, 111, 23, "<-- Önceki tip", false, gui["_root"])
	addEventHandler("onClientGUIClick", gui["btnPrevSkin"], newCharacter_updateGender, false)
	gui["btnNextSkin"] = guiCreateButton(340, 40, 111, 23, "Sonraki tip -->", false, gui["_root"])
	addEventHandler("onClientGUIClick", gui["btnNextSkin"], newCharacter_updateGender, false)
	
	gui["lblRace"] = guiCreateLabel(116, 92, 111, 16, "Irk: ", false, gui["_root"])
	--guiLabelSetVerticalAlign(gui["lblRace"], "center")
	guiSetFont(gui["lblRace"], "default-bold-small") 
	
	gui["chkBlack"] =  guiCreateCheckBox ( 38, 108, 55, 15, "Siyah", true, false, gui["_root"] )
	addEventHandler("onClientGUIClick", gui["chkBlack"] , newCharacter_raceFix, false)
	gui["chkWhite"] =  guiCreateCheckBox ( 98, 108, 55, 15, "Beyaz", false, false, gui["_root"] )
	addEventHandler("onClientGUIClick", gui["chkWhite"] , newCharacter_raceFix, false)
	gui["chkAsian"] =  guiCreateCheckBox ( 158, 108, 55, 15, "Asyalı", false, false, gui["_root"] )
	addEventHandler("onClientGUIClick", gui["chkAsian"] , newCharacter_raceFix, false)
	
	gui["lblHeight"] = guiCreateLabel(220, 75, 111, 16, "Boy", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["lblHeight"], "left", false)
	guiLabelSetVerticalAlign(gui["lblHeight"], "center")
	
	gui["scrHeight"] =  guiCreateScrollBar ( 320, 75, 130, 16, true, false, gui["_root"])
	addEventHandler("onClientGUIScroll", gui["scrHeight"], newCharacter_updateScrollBars, false)
	guiSetProperty(gui["scrHeight"], "StepSize", "0.02")

	gui["lblWeight"] = guiCreateLabel(220, 95, 111, 16, "Kilo", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["lblWeight"], "left", false)
	guiLabelSetVerticalAlign(gui["lblWeight"], "center")
	
	gui["scrWeight"] =  guiCreateScrollBar ( 320, 95, 130, 16, true, false, gui["_root"])
	addEventHandler("onClientGUIScroll", gui["scrWeight"], newCharacter_updateScrollBars, false)
	guiSetProperty(gui["scrWeight"], "StepSize", "0.01")
	
	gui["lblAge"] = guiCreateLabel(220, 115, 111, 16, "Yaş", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["lblAge"], "left", false)
	guiLabelSetVerticalAlign(gui["lblAge"], "center")
	
	gui["scrAge"] =  guiCreateScrollBar ( 320, 115, 130, 16, true, false, gui["_root"])
	addEventHandler("onClientGUIScroll", gui["scrAge"], newCharacter_updateScrollBars, false)
	guiSetProperty(gui["scrAge"], "StepSize", "0.0125")
	
	gui["chkLegal"] =  guiCreateCheckBox ( 70, 162, 51, 17, "Legal", false, false, gui["_root"] )
	addEventHandler("onClientGUIClick", gui["chkLegal"] , karakter_tip, false)
	gui["chkIllegal"] =  guiCreateCheckBox ( 130, 162, 82, 17, "İllegal", false, false, gui["_root"] )
	addEventHandler("onClientGUIClick", gui["chkIllegal"] , karakter_tip, false)
	
	gui["btnCancel"] = guiCreateButton(220, 160, 235, 20, "İptal", false, gui["_root"])
	addEventHandler("onClientGUIClick", gui["btnCancel"], newCharacter_cancel, false)
	
	gui["btnCreateChar"] = guiCreateButton(220, 136, 235, 20, "Karakteri Oluştur", false, gui["_root"])
	addEventHandler("onClientGUIClick", gui["btnCreateChar"], newCharacter_attemptCreateCharacter, false)
	newCharacter_changeSkin()
	newCharacter_updateScrollBars()
end

function karakter_tip()
	guiCheckBoxSetSelected ( gui["chkLegal"], false )
	guiCheckBoxSetSelected ( gui["chkIllegal"], false )
	if (source == gui["chkLegal"]) then
		guiCheckBoxSetSelected ( gui["chkLegal"], true )
	elseif (source == gui["chkIllegal"]) then
		guiCheckBoxSetSelected ( gui["chkIllegal"], true )
	end
end

function newCharacter_raceFix()
	guiCheckBoxSetSelected ( gui["chkAsian"], false )
	guiCheckBoxSetSelected ( gui["chkWhite"], false )
	guiCheckBoxSetSelected ( gui["chkBlack"], false )
	if (source == gui["chkBlack"]) then
		guiCheckBoxSetSelected ( gui["chkBlack"], true )
	elseif (source == gui["chkWhite"]) then
		guiCheckBoxSetSelected ( gui["chkWhite"], true )
	elseif (source == gui["chkAsian"]) then
		guiCheckBoxSetSelected ( gui["chkAsian"], true )
	end
	
	curskin = 1
	newCharacter_changeSkin(0)
end

function newCharacter_updateGender()
	local diff = 0
	if (source == gui["btnPrevSkin"]) then
		diff = -1
	elseif (source == gui["btnNextSkin"]) then
		diff = 1
	else
		curskin = 1
	end
	newCharacter_changeSkin(diff)
end

function newCharacter_updateLanguage()

	if source == gui["btnLanguagePrev"] then
		if languageselected == 1 then
			languageselected = call( getResourceFromName( "language-system" ), "getLanguageCount" )
		else
			languageselected = languageselected - 1
		end
	elseif source == gui["btnLanguageNext"] then
		if languageselected == call( getResourceFromName( "language-system" ), "getLanguageCount" ) then
			languageselected = 1
		else
			languageselected = languageselected + 1
		end
	end

	guiSetText(gui["lblLanguageDisplay"], tostring(call( getResourceFromName( "language-system" ), "getLanguageName", languageselected )))
end

function newCharacter_updateScrollBars()
	local scrollHeight = tonumber(guiGetProperty(gui["scrHeight"], "ScrollPosition")) * 100
	scrollHeight = math.floor((scrollHeight / 2) + 150)
	guiSetText(gui["lblHeight"], "Boy: "..scrollHeight.." CM")
	guiSetFont(gui["lblHeight"], "default-bold-small")
	
	local scrWeight = tonumber(guiGetProperty(gui["scrWeight"], "ScrollPosition")) * 100
	scrWeight = math.floor(scrWeight + 40)
	guiSetText(gui["lblWeight"], "Ağırlık: "..scrWeight.." KG")
	guiSetFont(gui["lblWeight"], "default-bold-small")
	
	local scrAge = tonumber(guiGetProperty(gui["scrAge"], "ScrollPosition")) * 100
	scrAge = math.floor( (scrAge * 0.8 ) + 18 )
	guiSetText(gui["lblAge"], "Yaş: "..scrAge.."")
	guiSetFont(gui["lblAge"], "default-bold-small")
end

function newCharacter_changeSkin(diff)
	local array = newCharacters_getSkinArray()
	local skin = 0
	if (diff ~= nil) then
		curskin = curskin + diff
	end
	
	if (curskin > #array or curskin < 1) then
		curskin = 1
		skin = array[1]
	else
		curskin = curskin
		skin = array[curskin]
	end
	
	if skin ~= nil then
		setElementModel(dummyPed, tonumber(skin))
	end
end

function newCharacters_getSkinArray()
	local array = { }
	if (guiCheckBoxGetSelected( gui["chkBlack"] )) then -- BLACK
		if (guiRadioButtonGetSelected( gui["rbMale"] )) then -- BLACK MALE
			array = blackMales
		elseif (guiRadioButtonGetSelected( gui["rbFemale"] )) then -- BLACK FEMALE
			array = blackFemales
		else
			outputChatBox("Select a gender first!", 0, 255, 0)
		end
	elseif ( guiCheckBoxGetSelected( gui["chkWhite"] ) ) then -- WHITE
		if ( guiRadioButtonGetSelected( gui["rbMale"] ) ) then -- WHITE MALE
			array = whiteMales
		elseif ( guiRadioButtonGetSelected( gui["rbFemale"] ) ) then -- WHITE FEMALE
			array = whiteFemales
		else
			outputChatBox("Select a gender first!", 0, 255, 0)
		end
	elseif ( guiCheckBoxGetSelected( gui["chkAsian"] ) ) then -- ASIAN
		if ( guiRadioButtonGetSelected( gui["rbMale"] ) ) then -- ASIAN MALE
			array = asianMales
		elseif ( guiRadioButtonGetSelected( gui["rbFemale"] ) ) then -- ASIAN FEMALE
			array = asianFemales
		else
			outputChatBox("Select a gender first!", 0, 255, 0)
		end
	end
	return array
end

function newCharacter_cancel(hideSelection)
	guiSetInputEnabled(false)
	destroyElement(dummyPed)
	destroyElement(gui["_root"])
	gui = {}
	curskin = 1
	dummyPed = nil
	languageselected = 1
	if hideSelection ~= true then
		Characters_showSelection()
	end
	clearChat()
end

function newCharacter_attemptCreateCharacter()
	local characterName = guiGetText(gui["txtCharName"])
	local nameCheckPassed, nameCheckError = checkValidCharacterName(characterName) 
	if not nameCheckPassed then
		LoginScreen_showWarningMessage( "Karakter isminde hata bulundu:\n".. nameCheckError )
		return
	end
	
	local race = 0
	if (guiCheckBoxGetSelected(gui["chkBlack"])) then
		race = 0
	elseif (guiCheckBoxGetSelected(gui["chkWhite"])) then
		race = 1
	elseif (guiCheckBoxGetSelected(gui["chkAsian"])) then
		race = 2
	else
		LoginScreen_showWarningMessage( "Karakter Tipini Seçmedin" )
		return
	end
	
	local gender = 0
	if (guiRadioButtonGetSelected( gui["rbMale"] )) then
		gender = 0
	elseif (guiRadioButtonGetSelected( gui["rbFemale"] )) then
		gender = 1
	else
		LoginScreen_showWarningMessage( "Karakter Cinsiyeti Seçmedin" )
		return
	end
	
	local skin = getElementModel( dummyPed )
	if not skin then
		LoginScreen_showWarningMessage( "Karakter Tipi Seçmedin" )
		return
	end
	
	local scrollHeight = guiScrollBarGetScrollPosition(gui["scrHeight"])
	scrollHeight = math.floor((scrollHeight / 2) + 150)
	
	local scrWeight = guiScrollBarGetScrollPosition(gui["scrWeight"])
	scrWeight = math.floor(scrWeight + 50)
	
	local scrAge = guiScrollBarGetScrollPosition(gui["scrAge"])
	scrAge = math.floor( (scrAge * 0.8 ) + 18 )

	if languageselected == nil then
		LoginScreen_showWarningMessage( "Karakterin Dilini Seçmedin" )
		return
	end
	
	local tip = 0
	if (guiCheckBoxGetSelected(gui["chkLegal"])) then
		tip = 0
	elseif (guiCheckBoxGetSelected(gui["chkIllegal"])) then
		tip = 1
	else
		LoginScreen_showWarningMessage( "Karakterin legal mi, illegal mi?(Zorunlu)" )
		return
	end
		
	
	guiSetEnabled(gui["btnCancel"], false)
	guiSetEnabled(gui["btnCreateChar"], false)
	guiSetEnabled(gui["_root"], false)
	triggerServerEvent("accounts:characters:new", getLocalPlayer(), characterName, race, gender, skin, scrollHeight, scrWeight, scrAge, languageselected, tip )
end

function newCharacter_response(statusID, statusSubID)
	if (statusID == 1) then
		LoginScreen_showWarningMessage( "Bir hata olustu!/nTekrar deneyin, olmazsa forumden bir Admin ile konusun!/nError ACD"..tostring(statusSubID) )
	elseif (statusID == 2) then
		if (statusSubID == 1) then
			LoginScreen_showWarningMessage( "Bu Karakter İsmi Kullanılmakta" )
		else
			LoginScreen_showWarningMessage( "Bir hata olustu!/n Tekrar deneyin, olmazsa forumden bir Admin ile konusun!/nError ACD"..tostring(statusSubID) )
		end
	elseif (statusID == 3) then
		newCharacter_cancel(true)
		triggerServerEvent("accounts:characters:spawn", getLocalPlayer(), statusSubID)
		return
	end
	
	guiSetEnabled(gui["btnCancel"], true)
	guiSetEnabled(gui["btnCreateChar"], true)	
	guiSetEnabled(gui["_root"], true)
	
end
addEventHandler("accounts:characters:new", getRootElement(), newCharacter_response)