addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('obje.txd',true)
engineImportTXD(txd, 1925)
local dff = engineLoadDFF('obje.dff', 0)
engineReplaceModel(dff, 1925)
local col = engineLoadCOL('obje.col')
engineReplaceCOL(col, 1925)
engineSetModelLODDistance(1925, 555)
end)



-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/
-- YouTube : https://youtube.com/channel/UCjpEfStfcZEvs0Nhn9TFimw/

-- Discord : https://discord.gg/DzgEcvy