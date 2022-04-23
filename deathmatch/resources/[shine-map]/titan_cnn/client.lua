--By Reventon

function AracYukle6490()
    local txd = engineLoadTXD ('Dosyalar/1.txd')
    engineImportTXD(txd,6490)
    local dff = engineLoadDFF('Dosyalar/2.dff',6490)
    engineReplaceModel(dff,6490)
end
addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),AracYukle6490)

--By Reventon