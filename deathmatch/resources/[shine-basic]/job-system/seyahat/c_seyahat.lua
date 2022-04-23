﻿-- ROTA --
local SeyahatMarker = 0
local SeyahatCreatedMarkers = {}
local SeyahatRota = {
	{ 2425.515625, -2089.640625, 12.575072288513, false },
	{ 2416.4091796875, -2023.1298828125, 12.484232902527, false },
	{ 2416.3232421875, -1945.0517578125, 12.456970214844, false },
	{ 2415.9951171875, -1841.8955078125, 12.457621574402, false },
	{ 2416.3154296875, -1748.8876953125, 12.456658363342, false },
	{ 2422.501953125, -1734.7802734375, 12.528128623962, false },
	{ 2545.833984375, -1735.021484375, 12.457767486572, false },
	{ 2627.3564453125, -1734.9130859375, 10.119202613831, false },
	{ 2642.54296875, -1724.31640625, 9.8079605102539, false },
	{ 2645.6162109375, -1672.26171875, 9.8333606719971, false },
	{ 2654.5966796875, -1659.71875, 9.7875556945801, false },
	{ 2745.5029296875, -1659.7333984375, 12.104863166809 , false },
	{ 2844.1748046875, -1660.0615234375, 9.7891731262207, false },
	{ 2878.921875, -1650.287109375, 9.9511938095093, false },
	{ 2913.333984375, -1549.1865234375, 9.9495277404785, false },
	{ 2927.494140625, -1462.4736328125, 9.9527645111084, false },
	{ 2917.234375, -1327.890625, 9.9495611190796, false },
	{ 2890.5537109375, -1117.8603515625, 9.9496450424194, false },
	{ 2893.4873046875, -952.7158203125, 9.9496307373047, false },
	{ 2897.654296875, -729.427734375, 9.9180374145508, false },
	{ 2899.03515625, -553.388671875, 11.430426597595, false },
	{ 2864.8408203125, -448.1572265625, 8.7837381362915, false },
	{ 2842.3681640625, -375.2578125, 7.145658493042, false },
	{ 2815.1611328125, -285.603515625, 7.667986869812, false },
	{ 2794.615234375, -254.8828125, 9.1934356689453, false },
	{ 2841.0732421875, -192.8662109375, 15.276151657104, false },
	{ 2856.083984375, -134.576171875, 20.269718170166, false },
	{ 2884.1650390625, -85.2568359375, 20.679258346558, false },
	{ 2875.0087890625, 12.166015625, 16.677816390991, false },
	{ 2781.16796875, 46.30859375, 19.95922088623, false },
	{ 2650.068359375, 45.8671875, 25.276523590088, false },
	{ 2553.431640625, 44.03125, 25.411956787109, false },
	{ 2484.1240234375, 44.263671875, 25.40958404541, false },
	{ 2417.771484375, 43.9892578125, 25.411924362183, false },
	{ 2392.224609375, 23.7744140625, 25.411334991455, false },
	{ 2392.2666015625, -16.3271484375, 25.409427642822, false },
	{ 2387.6943359375, -28.189453125, 25.410089492798, false },
	{ 2355.0712890625, -25.6357421875, 25.411149978638, false },
	{ 2342.39453125, -38.294921875, 25.410522460938, false },
	{ 2341.876953125, -89.2890625, 25.410810470581, false },
	{ 2309.9453125, -96.6103515625, 25.411712646484, false },
	{ 2265.0712890625, -86.146484375, 25.575929641724, true, false },
	{ 2233.798828125, -96.2080078125, 25.410884857178, false },
	{ 2226.021484375, -42.56640625, 25.410329818726, false },
	{ 2279.240234375, -30.7880859375, 25.41215133667, false },
	{ 2296.697265625, -17.142578125, 25.405973434448, false },
	{ 2291.501953125, 40.4609375, 25.41397857666, false },
	{ 2258.2978515625, 44.0068359375, 25.410617828369, false },
	{ 2214.5634765625, 43.875, 25.409189224243, false },
	{ 2150.0068359375, 44.2236328125, 25.410406112671, false },
	{ 2080.9462890625, 44.240234375, 25.405055999756, false },
	{ 1975.90625, 42.984375, 31.286632537842, false },
	{ 1894.9111328125, 48.171875, 34.045295715332, false },
	{ 1787.8798828125, 89.091796875, 33.506652832031, false },
	{ 1656.8916015625, 133.5400390625, 29.74686050415, false },
	{ 1542.341796875, 115.6376953125, 28.523815155029, false },
	{ 1526.1728515625, 113.392578125, 28.677059173584, false },
	{ 1513.9482421875, 142.7626953125, 30.523740768433, false },
	{ 1465.8701171875, 176.716796875, 25.181280136108, false },
	{ 1395.7265625, 205.0283203125, 18.521154403687, false },
	{ 1229.4453125, 281.1640625, 18.557542800903, false },
	{ 1219.7802734375, 299.60546875, 18.628549575806, true, false },
	{ 1209.861328125, 310.51171875, 18.481220245361, false },
	{ 1222.236328125, 338.087890625, 18.483964920044, false },
	{ 1219.74609375, 355.8837890625, 18.483156204224, false },
	{ 1154.919921875, 395.642578125, 23.618556976318, false },
	{ 1091.1962890625, 447.2919921875, 23.176837921143, false },
	{ 1040.4453125, 472.6259765625, 19.149278640747, false },
	{ 1029.2763671875, 489.6123046875, 18.957229614258, false },
	{ 1046.162109375, 519.2890625, 18.957401275635, false },
	{ 1106.333984375, 572, 18.958930969238, false },
	{ 1140.9853515625, 560.0361328125, 18.957252502441, false },
	{ 1285.9423828125, 488.44140625, 18.957326889038, false },
	{ 1400.03125, 431.134765625, 18.946176528931, false },
	{ 1506.52734375, 388.7509765625, 18.95703125, false },
	{ 1608.6494140625, 379.6005859375, 18.957197189331, false },
	{ 1776.4638671875, 382.7685546875, 18.269521713257, false },
	{ 1918.4765625, 352.181640625, 19.506690979004, false },
	{ 1997.5498046875, 345.5146484375, 26.847858428955, false },
	{ 2043.509765625, 275.154296875, 24.442110061646, false },
	{ 2121.4677734375, 244.830078125, 14.64478969574, false },
	{ 2224.96875, 220.0830078125, 13.703846931458, false },
	{ 2312.052734375, 211.4814453125, 24.363300323486, false },
	{ 2343.939453125, 217.7783203125, 25.41046333313, false },
	{ 2345.916015625, 273.875, 25.41037940979, false },
	{ 2347.2421875, 355.615234375, 25.510953903198, false },
	{ 2374.2783203125, 399.6494140625, 27.711204528809, false },
	{ 2413.3408203125, 355.345703125, 31.59942817688, false },
	{ 2332.599609375, 327.21484375, 31.738750457764, false },
	{ 2117.279296875, 323.365234375, 33.09033203125, false },	
	{ 1982.0439453125, 313.7138671875, 32.946399688721, false },
	{ 1796.6474609375, 279.3740234375, 19.335794448853, false },
	{ 1727.4296875, 295.591796875, 17.362819671631, false },
	{ 1704.06640625, 381.296875, 29.110500335693, false },
	{ 1737.51171875, 481.927734375, 28.909711837769, false },
	{ 1743.759765625, 497.056640625, 28.205680847168, false },
	{ 1752.421875, 521.3623046875, 26.840677261353, false },
	{ 1782.669921875, 621.07421875, 19.713846206665, false },
	{ 1808.4443359375, 814.89453125, 9.9110870361328, false },
	{ 1809.4716796875, 892.791015625, 8.7730512619019, false },
	{ 1809.2666015625, 1106.8544921875, 5.8087339401245, false },
	{ 1809.568359375, 1301.9013671875, 5.8088278770447, false },
	{ 1809.2880859375, 1506.1923828125, 5.8090119361877, false },
	{ 1814.7802734375, 1579.3388671875, 5.8115921020508, false },
	{ 1866.86328125, 1662.1689453125, 9.0943965911865, false },
	{ 1879.396484375, 1700.6240234375, 9.7638292312622, false },
	{ 1870.90234375, 1715.8681640625, 9.9119644165039, false },
	{ 1777.1630859375, 1715.7783203125, 12.435573577881, false },
	{ 1735.173828125, 1715.80078125, 9.7902193069458, false },
	{ 1721.8828125, 1712.3154296875, 9.981951713562, false },
	{ 1716.4052734375, 1696.8984375, 9.7265453338623, false },
	{ 1735.505859375, 1651.4697265625, 8.6834278106689, false },
	{ 1736.68359375, 1632.9609375, 8.1019010543823, false },
	{ 1723.7158203125, 1585.091796875, 9.4283542633057, false },
	{ 1727.7734375, 1539.80859375, 9.7464056015015, false },
	{ 1716.9375, 1468.5380859375, 9.7519416809082, false },
	{ 1711.3466796875, 1412.705078125, 9.5735731124878, false },
	{ 1723.380859375, 1367.5185546875, 9.5723028182983, true, false },
	{ 1726.3720703125, 1287.908203125, 9.7453031539917, false },
	{ 1733.7333984375, 1273.146484375, 9.8259449005127, false },
	{ 1831.46875, 1270.7626953125, 11.562410354614, false },
	{ 1928.4873046875, 1270.9619140625, 9.7462005615234, false },
	{ 2027.8154296875, 1271.0234375, 9.7463274002075, false },
	{ 2056.7041015625, 1271.5234375, 9.7477025985718, false },
	{ 2068.953125, 1318.693359375, 9.7518110275269, false },
	{ 2069.0966796875, 1404.45703125, 9.7464609146118, false },
	{ 2068.9716796875, 1439.3525390625, 9.7462663650513, false },
	{ 2052.0009765625, 1454.0361328125, 9.7472314834595 , false },
	{ 2008.0068359375, 1455.5390625, 9.7462797164917, false },
	{ 1844.9443359375, 1455.30078125, 10.628030776978, false },
	{ 1769.06640625, 1455.1513671875, 11.94667339325, false },
	{ 1735.4541015625, 1453.17578125, 9.8311204910278, false },
	{ 1722.396484375, 1459.6708984375, 9.8109350204468, false },
	{ 1726.8271484375, 1481.6103515625, 9.7416076660156, true, false },
	{ 1729.353515625, 1491.8173828125, 9.7462015151978, false },
	{ 1738.46484375, 1623.125, 8.0884771347046, false },
	{ 1720.01953125, 1699.70703125, 9.7299337387085, false },
	{ 1751.880859375, 1710.875, 10.770741462708, false },
	{ 1863.6904296875, 1711.083984375, 9.7444114685059, false },
	{ 1876.2958984375, 1744.8515625, 9.6165866851807, false },
	{ 1813.3330078125, 1854.291015625, 5.8110790252686, false },
	{ 1809.865234375, 2026.93359375, 2.9940474033356, false },
	{ 1811.0087890625, 2326.904296875, 5.4375071525574, false },
	{ 1765.35546875, 2557.671875, 12.252526283264, false },
	{ 1560.48046875, 2488.6240234375, 6.2792453765869, false },
	{ 1347.4140625, 2475.8037109375, 5.8823518753052, false },
	{ 1120.37890625, 2496.5546875, 9.6876649856567, false },
	{ 984.6005859375, 2577.416015625, 9.7285709381104, false },
	{ 755.650390625, 2660.5576171875, 16.427089691162, false },
	{ 476.78515625, 2662.380859375, 52.414413452148, false },
	{ 388.509765625, 2707.4091796875, 59.772720336914, false },
	{ 226.2685546875, 2752.248046875, 58.839179992676, false },
	{ 97.7294921875, 2699.4873046875, 51.414920806885, false },
	{ -145.236328125, 2638.078125, 62.859184265137, false },
	{ -206.265625, 2638.0263671875, 62.106990814209, false },
	{ -237.642578125, 2599.0244140625, 61.632141113281, true, false },
	{ -220.0673828125, 2618.5478515625, 61.839874267578, false },
	{ -244.3408203125, 2636.6796875, 61.701202392578, false },
	{ -244.3408203125, 2636.6796875, 61.701202392578, false },
	{ -522.3095703125, 2718.1640625, 65.108428955078, false },
	{ -615.6826171875, 2758.97265625, 59.096393585205, false },
	{ -880.25, 2728.271484375, 44.926918029785, false },
	{ -1040.6513671875, 2709.98828125, 44.941741943359, false },
	{ -1213.4462890625, 2688.8125, 45.154697418213, false },
	{ -1329.259765625, 2648.5087890625, 49.174423217773, false },
	{ -1355.0224609375, 2656.7080078125, 50.417877197266, false },
	{ -1427.0986328125, 2721.62890625, 61.717597961426, false },
	{ -1561.8232421875, 2735.8486328125, 59.924880981445, false },
	{ -1681.7578125, 2729.3876953125, 60.665111541748, false },
	{ -1824.44140625, 2692.0849609375, 54.501804351807, false },
	{ -1871.4501953125, 2653.6923828125, 51.725738525391, false },
	{ -2008.6005859375, 2626.6455078125, 49.965682983398, false },
	{ -2156.23828125, 2673.98828125, 52.576416015625, false },
	{ -2385.38671875, 2674.7119140625, 58.481407165527, false },
	{ -2582.287109375, 2671.9267578125, 72.162094116211, false },
	{ -2773.7880859375, 2412.9609375, 86.607002258301, false },
	{ -2753.451171875, 2346.80078125, 72.330764770508, false },
	{ -2706.2138671875, 2363.3349609375, 70.014854431152, false },
	{ -2636.607421875, 2499.9287109375, 28.204748153687, false },
	{ -2524.36328125, 2441.9169921875, 16.606906890869, false },	
	{ -2486.896484375, 2426.900390625, 15.318771362305, false },
	{ -2376.7177734375, 2420.9921875, 7.5232753753662, false },
	{ -2305.4365234375, 2372.1015625, 4.5848693847656, false },
	{ -2262.46875, 2295.609375, 3.8947560787201, true, false },
	{ -2275.484375, 2355.9853515625, 4.0620670318604, false },
	{ -2355.46875, 2411.9794921875, 5.9594464302063, false },
	{ -2488.484375, 2430.55078125, 15.428342819214, false },
	{ -2524.4140625, 2448.966796875, 16.894432067871, false },
	{ -2657.7626953125, 2498.0322265625, 31.678133010864, false },
	{ -2750.384765625, 2356.7099609375, 72.426025390625, false },
	{ -2766.763671875, 2332.4287109375, 71.299201965332, false },
	{ -2717.3505859375, 2233.2109375, 55.311996459961, false },
	{ -2691.796875, 2148.212890625, 54.541999816895, false },
	{ -2691.5205078125, 1937.486328125, 63.043090820313, false },
	{ -2691.943359375, 1764.74609375, 67.259254455566, false },
	{ -2691.28125, 1594.62109375, 63.197185516357, false },
	{ -2690.955078125, 1368.7744140625, 54.586212158203, false },
	{ -2691.876953125, 1251.5322265625, 54.58810043335, false },
	{ -2672.9609375, 1189.8544921875, 54.587112426758, false },
	{ -2541.3642578125, 1093.7314453125, 54.735851287842, false },
	{ -2526.431640625, 1069.37890625, 57.9665184021, false },
	{ -2529.9306640625, 987.2392578125, 77.324577331543, false },
	{ -2529.119140625, 912.5751953125, 63.985126495361, false },
	{ -2528.251953125, 868.4833984375, 56.788024902344, false },
	{ -2528.443359375, 797.3251953125, 48.668048858643, false },
	{ -2529.505859375, 691.46875, 26.984939575195, false },
	{ -2528.5283203125, 597.77734375, 19.431030273438, false },
	{ -2505.857421875, 561.0126953125, 13.623788833618, false },
	{ -2367.421875, 562.33203125, 23.901559829712, false },
	{ -2237.0439453125, 562.03515625, 34.172939300537, false },
	{ -2022.314453125, 562.873046875, 34.175773620605, false },
	{ -2007.8349609375, 543.251953125, 34.173862457275, false },
	{ -2007.7646484375, 470.310546875, 34.172718048096, false },
	{ -2007.931640625, 384.484375, 34.174179077148, false },
	{ -2007.486328125, 301.0439453125, 33.857933044434, false },
	{ -2009.0390625, 215.4853515625, 26.708251953125, false },
	{ -1997.1533203125, 189.9736328125, 26.697193145752, false },
	{ -1989.9541015625, 148.1748046875, 26.696401596069, true, false },
	{ -1997.7177734375, 109.16015625, 26.611968994141, false },
	{ -2009.5126953125, 42.484375, 31.296756744385, false },
	{ -2009.310546875, -53.5673828125, 34.239570617676, false },
	{ -2007.57421875, -246.8125, 34.741516113281, false },
	{ -2010.62890625, -286.5498046875, 34.39262008667, false },
	{ -2027.0791015625, -317.49609375, 34.315635681152, false },
	{ -2029.43359375, -339.3447265625, 34.419330596924, false },
	{ -2022.595703125, -361.419921875, 34.615001678467, false },
	{ -1956.9970703125, -395.2099609375, 39.091533660889, false },
	{ -1922.755859375, -491.96875, 37.316703796387, false },
	{ -1914.0517578125, -582.427734375, 37.309009552002, false },
	{ -1913.150390625, -782.7744140625, 44.015979766846, false },
	{ -1908.9033203125, -816.4375, 44.027767181396, false },
	{ -1895.7294921875, -808.4697265625, 44.027694702148, false },
	{ -1894.623046875, -741.248046875, 43.567642211914, false },
	{ -1886.513671875, -678.033203125, 40.385444641113, false },
	{ -1884.1591796875, -594.1796875, 23.60569190979, false },
	{ -1822.02734375, -583.53515625, 15.41299533844, false },
	{ -1767.5517578125, -587.7216796875, 15.412089347839, false },
	{ -1765.5517578125, -592.39453125, 15.399426460266, false },
	{ -1764.541015625, -656.3330078125, 19.472612380981, false },
	{ -1708.412109375, -751.4453125, 37.162227630615, false },
	{ -1536.947265625, -818.2294921875, 54.470794677734, false },
	{ -1390.814453125, -819.3125, 80.488746643066, false },
	{ -1275.3349609375, -801.0478515625, 68.232887268066, false },
	{ -1238.322265625, -779.1513671875, 63.936305999756, false },
	{ -1196.603515625, -732.5576171875, 57.381927490234, false },
	{ -1152.853515625, -595.58203125, 34.06725692749, false },
	{ -1083.7275390625, -481.142578125, 32.605445861816, false },
	{ -1011.2802734375, -443.068359375, 35.325576782227, false },
	{ -993.603515625, -440.3623046875, 35.140560150146, false },
	{ -963.349609375, -446.857421875, 33.209083557129, false },
	{ -806.236328125, -456.3623046875, 16.925987243652, false },
	{ -668.6083984375, -409.63671875, 18.434650421143, false },
	{ -555.404296875, -394.615234375, 19.360553741455, false },
	{ -433.9345703125, -442.1806640625, 16.07426071167, false },
	{ -405.4375, -551.841796875, 15.065070152283, false },
	{ -398.0458984375, -676.55859375, 16.263536453247, false },
	{ -356.115234375, -771.0234375, 29.013628005981, false },
	{ -439.7802734375, -924.41015625, 25.036956787109, false },
	{ -506.91796875, -1027.22265625, 23.467273712158, false },
	{ -514.3115234375, -1033.5263671875, 23.327501296997, false },
	{ -563.7490234375, -1060.6865234375, 22.839113235474, true, false },
	{ -581.6123046875, -1099.1494140625, 22.73299407959, false },
	{ -579.828125, -1147.3779296875, 21.459133148193, false },
	{ -613.27734375, -1211.021484375, 20.352384567261, false },
	{ -654.9873046875, -1343.423828125, 18.160036087036, false },
	{ -658.0146484375, -1440.25390625, 18.818008422852, false },
	{ -664.6845703125, -1578.2548828125, 22.825315475464, false },
	{ -681.8544921875, -1683.634765625, 33.811042785645, false },
	{ -714.8662109375, -1692.76953125, 48.113384246826, false },
	{ -716.4052734375, -1594.78125, 53.72204208374, false },	
	{ -711.9375, -1417.2880859375, 59.359844207764, false },
	{ -720.1650390625, -1298.87109375, 63.718067169189, false },
	{ -759.953125, -1290.9716796875, 71.994842529297, false },
	{ -766.064453125, -1422.8115234375, 84.635429382324, false },
	{ -762.15625, -1546.056640625, 92.372772216797, false },
	{ -766.70703125, -1696.6318359375, 96.301467895508, false },
	{ -850.7802734375, -1847.001953125, 89.958831787109, false },
	{ -957.7744140625, -1902.890625, 80.179824829102, false },
	{ -979.3779296875, -1927.2568359375, 79.408042907715, false },
	{ -1036.2626953125, -2035.9453125, 60.177516937256, false },
	{ -1120.6162109375, -2196.892578125, 31.737710952759, false },
	{ -1188.46875, -2439.0859375, 53.170875549316, false },
	{ -1138.7666015625, -2568.9033203125, 70.20645904541, false },
	{ -1025.56640625, -2617.0986328125, 81.496994018555, false },
	{ -907.3212890625, -2581.5322265625, 89.75749206543, false },
	{ -777.5751953125, -2459.474609375, 73.145057678223, false },
	{ -667.142578125, -2232.3486328125, 10.053582191467, false },
	{ -549.375, -2166.5400390625, 43.584842681885, false },
	{ -382.265625, -2189.970703125, 48.595470428467, false },
	{ -254.0693359375, -2050.705078125, 33.518085479736, false },
	{ -274.2529296875, -1918.6533203125, 26.725229263306, false },
	{ -250.5771484375, -1743.44140625, 3.4465811252594, false },
	{ -196.73046875, -1638.52734375, 2.2268636226654, false },
	{ -100.94921875, -1628.029296875, 2.5306298732758, false },
	{ -25.9921875, -1551.3076171875, 1.2461369037628, false },
	{ 15.32421875, -1530.4765625, 3.0953533649445, false },
	{ 90.25390625, -1546.5634765625, 5.1230711936951, false },
	{ 153.2451171875, -1586.9091796875, 11.645913124084, false },
	{ 251.6572265625, -1693.4892578125, 8.1488618850708, false },
	{ 375.2080078125, -1719.1328125, 6.4279546737671, false },
	{ 478.55078125, -1726.5810546875, 10.081457138062, false },
	{ 646.02734375, -1751.6572265625, 12.410237312317, false },
	{ 844.83984375, -1786.5458984375, 12.927068710327, false },
	{ 993.939453125, -1806.8935546875, 13.208464622498, false },
	{ 1037.3603515625, -1787.2978515625, 12.753346443176, false },
	{ 1039.232421875, -1731.6015625, 12.541501998901, false },
	{ 1064.1943359375, -1714.904296875, 12.541152954102, false },
	{ 1151.013671875, -1714.6455078125, 12.942531585693, false },
	{ 1172.0810546875, -1724.4326171875, 12.783326148987, false },
	{ 1156.4599609375, -1737.2294921875, 12.703537940979, false },
	{ 1084.1611328125, -1739.2587890625, 12.670010566711, false },
	{ 1069.708984375, -1764.0888671875, 12.54109287262, true, false },
	{ 1099.509765625, -1742.4775390625, 12.548300743103, false },
	{ 1161.7109375, -1743.6162109375, 12.471928596497, false },
	{ 1171.5517578125, -1747.4765625, 12.47315788269, false },
	{ 1172.810546875, -1797.0419921875, 12.472708702087, false },
	{ 1173.2705078125, -1839.96484375, 12.479656219482, false },
	{ 1198.5830078125, -1854.5517578125, 12.466752052307, false },
	{ 1293.234375, -1853.8125, 12.460026741028, false },
	{ 1311.34375, -1846.765625, 12.460690498352, false },
	{ 1314.984375, -1816.2177734375, 12.457203865051, false },
	{ 1314.9501953125, -1682.0751953125, 12.457609176636, false },
	{ 1314.740234375, -1576.95703125, 12.457524299622, false },
	{ 1353.8095703125, -1464.3193359375, 12.458002090454, false },
	{ 1359.9208984375, -1330.173828125, 12.465238571167, false },
	{ 1360.109375, -1204.2255859375, 17.04026222229, false },
	{ 1360.8515625, -1118.7021484375, 22.782970428467, false },
	{ 1370.431640625, -1058.6220703125, 25.671306610107, false },
	{ 1376.6396484375, -977.0302734375, 31.287244796753, false },
	{ 1378.365234375, -945.873046875, 33.260475158691, false },
	{ 1337.8974609375, -925.1396484375, 34.712066650391, false },
	{ 1217.0400390625, -931.9365234375, 41.725238800049, false },
	{ 1169.70703125, -939.6181640625, 41.929187774658, false },
	{ 1162.3642578125, -938.65625, 42.034252166748, false },
	{ 1157.564453125, -862.9375, 45.715717315674, false },
	{ 1187.3095703125, -674.63671875, 60.746143341064, false },
	{ 1234.27734375, -557.6630859375, 40.120426177979, false },
	{ 1258.9091796875, -459.8642578125, 11.28978729248, false },
	{ 1259.9501953125, -420.029296875, 1.667014837265, false },
	{ 1230.1845703125, -416.005859375, 3.5794544219971, false },
	{ 1064.166015625, -442.302734375, 48.619155883789, false },
	{ 832.5087890625, -572.427734375, 15.261360168457, false },
	{ 828.0244140625, -589.70703125, 15.26172542572, false },
	{ 799.5712890625, -592.083984375, 15.263372421265, false },
	{ 793.4208984375, -561.072265625, 15.261644363403, false },
	{ 789.08984375, -530.166015625, 15.264890670776, false },
	{ 737.3017578125, -528.8193359375, 15.26265335083, false },
	{ 727.6171875, -524.79296875, 15.255014419556, false },
	{ 723.5595703125, -494.61328125, 15.262412071228, false },
	{ 685.7060546875, -482.4677734375, 15.262968063354, false },
	{ 667.7783203125, -466.337890625, 15.410860061646, true, false },
	{ 654.541015625, -454.1923828125, 15.41344165802, false },
	{ 639.5771484375, -470.474609375, 15.261141777039, false },
	{ 675.5029296875, -487.5048828125, 15.263589859009, false },
	{ 712.66015625, -487.4775390625, 15.262475013733, false },
	{ 718.896484375, -512.0009765625, 15.262488365173, false },
	{ 728.6982421875, -530.900390625, 15.256653785706, false },
	{ 770.4853515625, -532.38671875, 15.26179599762, false },
	{ 824.970703125, -533.369140625, 15.26210308075, false },
	{ 830.2939453125, -552.0322265625, 15.262296676636, false },	
	{ 839.142578125, -566.6328125, 15.285717010498, false },
	{ 892.43359375, -556.7734375, 21.202131271362, false },
	{ 998.32421875, -476.9423828125, 48.72607421875, false },
	{ 1079.90234375, -443.90234375, 46.550243377686, false },
	{ 1223.76953125, -421.3291015625, 4.5984749794006, false },
	{ 1250.00390625, -418.16796875, 1.7409896850586, false },
	{ 1253.3037109375, -459.4892578125, 11.369780540466, false },
	{ 1235.8515625, -533.056640625, 33.235240936279, false },
	{ 1187.513671875, -662.3759765625, 60.122596740723, false },
	{ 1158.5078125, -743.75390625, 59.489669799805, false },
	{ 1152.2919921875, -844.9833984375, 48.979793548584, false },
	{ 1156.3740234375, -927.3798828125, 42.082664489746, false },
	{ 1163.9130859375, -942.7529296875, 42.026920318604, false },
	{ 1222.380859375, -940.708984375, 41.690570831299, false },
	{ 1346.3896484375, -938.0107421875, 33.981002807617, false },
	{ 1406.87890625, -947.21875, 34.35733795166, false },
	{ 1497.767578125, -960.908203125, 35.241230010986, false },
	{ 1577.669921875, -969.533203125, 37.066181182861, false },
	{ 1636.1708984375, -976.9580078125, 37.184009552002, false },
	{ 1812.6552734375, -1008.9599609375, 35.449840545654, false },
	{ 1945.5224609375, -1028.1484375, 32.284996032715, false },
	{ 2044.041015625, -1035.6943359375, 34.164016723633, false },
	{ 2100.62109375, -1067.38671875, 25.489044189453, false },
	{ 2210.0322265625, -1124.1484375, 24.704504013062, false },
	{ 2296.50390625, -1151.68359375, 25.760507583618, false },
	{ 2300.9052734375, -1196.3349609375, 23.780897140503, false },
	{ 2301.208984375, -1312.07421875, 22.90368270874, false },
	{ 2301.642578125, -1366.865234375, 22.928899765015, false },
	{ 2308.1572265625, -1385.7490234375, 22.939651489258, false },
	{ 2337.8203125, -1391.1162109375, 22.920383453369, false },
	{ 2340.3056640625, -1525.8974609375, 22.909311294556, false },
	{ 2339.9873046875, -1578.185546875, 22.861728668213, false },
	{ 2340.490234375, -1652.0712890625, 12.69393825531, false },
	{ 2340.2529296875, -1715.16015625, 12.433861732483, false },
	{ 2344.3076171875, -1730.455078125, 12.458957672119, false },
	{ 2399.587890625, -1733.2900390625, 12.455910682678, false },
	{ 2411.03515625, -1739.720703125, 12.457220077515, false },
	{ 2411.1357421875, -1858.2333984375, 12.45721244812, false },
	{ 2411.125, -1952.1337890625, 12.457547187805, false },
	{ 2411.0888671875, -2045.5478515625, 12.42898273468, false },
	{ 2408.353515625, -2096.6689453125, 12.500594139099, true, true }
}

function SeyahatBasla(cmd)
	if not getElementData(getLocalPlayer(), "SeyahatSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 437
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "SeyahatSoforlugu", true)
			updateSeyahatRota()
			addEventHandler("onClientMarkerHit", resourceRoot, SeyahatRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("seyahatbasla", SeyahatBasla)

function updateSeyahatRota()
	SeyahatMarker = SeyahatMarker + 1
	for i,v in ipairs(SeyahatRota) do
		if i == SeyahatMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(SeyahatCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(SeyahatCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(SeyahatCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function SeyahatRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 437 then
				for _, marker in ipairs(SeyahatCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateSeyahatRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							SeyahatMarker = 0
							triggerServerEvent("SeyahatParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYolcular inidiriliyor/bindiriliyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /Seyahatibusbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlenmiştir, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateSeyahatRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFYolcular indiriliyor/bindiriliyor.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYolcular indirildi/bindirildi, bir sonraki rotadan devam edebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateSeyahatRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function SeyahatBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local SeyahatSoforlugu = getElementData(getLocalPlayer(), "SeyahatSoforlugu")
	if pedVeh then
		if pedVehModel == 437 then
			if SeyahatSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "SeyahatSoforlugu", false)
				for i,v in ipairs(SeyahatCreatedMarkers) do
					destroyElement(v[1])
				end
				SeyahatCreatedMarkers = {}
				SeyahatMarker = 0
				triggerServerEvent("SeyahatBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, SeyahatRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), SeyahatAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("Seyahatibusbitir", SeyahatBitir)

function SeyahatAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 437 and vehicleJob == 10 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 10 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Seyahatibüs mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), SeyahatAntiYabanci)

function SeyahatAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			SeyahatBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), SeyahatAntiAracTerketme)