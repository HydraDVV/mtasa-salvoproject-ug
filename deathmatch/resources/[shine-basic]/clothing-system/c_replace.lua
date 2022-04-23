function replaceModels()
	--Fishing Rod
	local txd = engineLoadTXD("models/rod.txd")
    engineImportTXD(txd, 16442 )
	local dff = engineLoadDFF("models/rod.dff", 16442)
    engineReplaceModel(dff, 16442)
	
	--Helmet
    local txd = engineLoadTXD("models/pro.txd")
    engineImportTXD(txd, 2799)
    local dff = engineLoadDFF("models/pro.dff", 2799)
    engineReplaceModel(dff, 2799)
   
    --Gas Mask
    local txd = engineLoadTXD("models/gasmask.txd")
    engineImportTXD(txd, 3890)
    local dff = engineLoadDFF("models/gasmask.dff", 3890)
    engineReplaceModel(dff, 3890)
	
	--Dufflebag
    local txd = engineLoadTXD("models/dufflebag.txd")
    engineImportTXD(txd, 3915)
    local dff = engineLoadDFF("models/dufflebag.dff", 3915)
    engineReplaceModel(dff, 3915)
	
	--Kevlar Vest
    local txd = engineLoadTXD("models/kevlar.txd")
    engineImportTXD(txd, 3916)
    local dff = engineLoadDFF("models/kevlar.dff", 3916)
    engineReplaceModel(dff, 3916)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
     function()
         replaceModels()
         setTimer (replaceModels, 1000, 1)
end
)