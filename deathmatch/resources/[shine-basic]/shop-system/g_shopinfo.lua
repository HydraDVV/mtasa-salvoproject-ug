--- clothe shop skins
blackMales = {296, 297, 268, 269, 270, 271, 272, 7, 16, 17, 18, 20, 21, 22, 24, 25, 28, 35, 67, 79, 80, 83, 84, 102, 103, 104, 105, 106, 107, 134, 136, 142, 143, 144, 156, 163, 166, 168, 176, 180, 182, 183, 185, 220, 221, 222, 249, 253, 260, 262 }
whiteMales = {299, 291, 292, 293, 294, 295, 2, 17, 23, 26, 27, 29, 30, 32, 33, 34, 35,  37, 38, 43, 44, 47, 48, 52, 53, 58, 59, 60, 62, 68, 70, 72, 73, 81, 82, 94, 95, 96, 97, 99, 100, 101, 108, 109, 110, 111, 112, 113, 114, 115, 116, 120, 121, 122, 124, 125, 126, 127, 128, 132, 133, 135, 137, 146, 147, 153, 154, 155, 158, 159, 160, 161, 162, 164, 165, 170, 171, 173, 174, 175, 177, 179, 181, 184, 186, 187, 188, 189, 202, 204, 209, 212, 213, 217, 223, 230, 234, 235, 236, 240, 241, 242, 247, 248, 250, 252, 254, 255, 258, 259, 261, 264, 272 }
asianMales = {290, 49, 57, 58, 59, 60, 117, 118, 120, 121, 122, 123, 170, 186, 187, 203, 210, 227, 228, 229, 294}
blackFemales = {9, 11, 12, 13, 40, 41, 63, 64, 69, 76, 91, 139, 148, 190, 195, 207, 215, 218, 219, 238, 243, 244, 245, 256 }
whiteFemales = {9, 12,  38, 39, 40, 41, 53, 55, 56, 64, 75, 77, 85, 87, 88, 89, 90, 91, 92, 93, 130, 131, 138, 140, 145, 150, 151, 152, 157, 172, 178, 192, 193, 194, 196, 197, 198, 199, 201, 205, 211, 214, 216, 224, 225, 226, 231, 232, 233, 237, 243, 246, 251, 257, 263 }
asianFemales = {9, 38, 53, 54, 55, 56, 88, 141, 178, 224, 225, 226, 263}
local fittingskins = {[0] = {[0] = blackMales, [1] = whiteMales, [2] = asianMales}, [1] = {[0] = blackFemales, [1] = whiteFemales, [2] = asianFemales}}
-- Removed 9 as a black female
-- these are all the skins
skins = { 2, 268, 269, 270, 271, 272, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 303, 308, 309, 310, 311, 7, 11, 12, 13, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 41, 43, 44, 47, 48, 49,  52, 53, 55, 56, 57, 58, 59, 60, 62, 63, 64, 67, 68, 69, 72, 73, 75, 76, 77, 79, 80, 81, 82, 83, 84, 85, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 178, 179, 180, 181, 182, 183, 184, 185, 186, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 207, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 263, 264 }

g_shops = {
	{ -- 1
		name = "Market",
		description = "",
		image = "general2.png",

		{
			name = "Genel",
		--    { name = "YENİ! Benzin Bidonu", description = "Bidon", price = 200, itemID = 57, itemValue = 0 }, 				
		    --{ name = "YENİ! Balta", description = "Maden kazmanız için mecburi ekipman", price = 200, itemID = 578, itemValue = 12 }, 			
	        --{ name = "Balta", description = "Ormanın kralı ol!", price = 50000, itemID = 115, itemValue = 12 }, 		
			--{ name = "Tamir kiti", description = "/tamirkit", price = 50000, itemID = 10015, itemValue = 0 },	
			--{ name = "Dondurulmuş Pizza", description = "dondurulmuş pizza", price = 200, itemID = 356, itemValue = 0 },	
		--	{ name = "Kasap Bıçağı", description = "Birilerine vurmak saldırmak yasaktır!", price = 2500, itemID = 115, itemValue = 2 },
			--{ name = "Kazma", description = "Kazı yapabileceğiniz bir eşya.", price = 2000, itemID = 578},		
			--{ name = "Çadır", description = "/cadirkur", price = 5000, itemID = 344, itemValue = nil },
			--{ name = "Kömür", description = "madenden çıkmış kömür", price = 5000, itemID = 250, itemValue = nil },
			--{ name = "Odun", description = "Odun", price = 5000, itemID = 251, itemValue = nil },
			--{ name = "Kamp Ateşi", description = "Kamp Ateşi", price = 30, itemID = 252 },
			{ name = "Mangal", description = "etmangali", price = 400, itemID = 176, itemValue = nil },
			{ name = "Çiğ Et", description = "çiğet", price = 15, itemID = 354 },
			{ name = "Sırt Çantası", description = "Makul ölçülerde sırt çantası.", price = 30, itemID = 48 },
--			{ name = "Balyk Oltası", description = "A 7 foot carbon steel fishing rod.", price = 300, itemID = 49 },
			{ name = "Maske", description = "Yüz Maskesi.", price = 500000, itemID = 56 },
			--{ name = "Araç Kit", description = "", price = 500, itemID = 10015 },
		--	{ name = "Fuel Can", description = "A small metal fuel canister.", price = 35, itemID = 57, itemValue = 0 },
		--	{ name = "İlk yardım çantası", description = "Küçük yardım çantası", price = 15, itemID = 70, itemValue = 3 },
			--{ name = "Mini dizüstü bilgisayar", description = "Mini dizüstü bilgisayar", price = 10, itemID = 71, itemValue = 5 },
			--{ name = "Alet Çantası", description = "", price = 5000, itemID = 10014, itemValue = 1 },
			{ name = "Sargı Bezi", description = "", price = 5000, itemID = 10052, itemValue = 1 },
			--{ name = "Not Defteri", description = "50 satırlıkk not defteri.", price = 15, itemID = 71, itemValue = 50 },
			--{ name = "Büyük Not Defteri", description = "125 satırlıkk not defteri.", price = 20, itemID = 71, itemValue = 125 },
			--{ name = "Kask", description = "Motosiklet kullanan insanlar tarafından yaygın olarak kullanılan bir kask.", price = 100, itemID = 90 },
		--	{ name = "Açık Mavi Bandana", description = "Açık Mavi Bandana.", price = 5, itemID = 122 },
		--{ name = "Kırmızı Bandana", description = "Kırmızı Bandana.", price = 5, itemID = 123 },
		--	{ name = "Yeşil Bandana", description = "Yeşil Bandana.", price = 5, itemID = 124 },
		--	{ name = "Mor Bandana", description = "Mor Bandana.", price = 5, itemID = 125 },
		--	{ name = "Mavi Bandana", description = "Mavi Bandana.", price = 5, itemID = 135 },
		--	{ name = "Kahverengi Bandana", description = "Kahverengi Bandana.", price = 5, itemID = 136 },
		--	{ name = "Sigara Paketi", description = "Sigara Paketi", price = 45, itemID = 105, itemValue = 20 },
		--	{ name = "Zippo", description = "Zippo", price = 32, itemID = 107 },
	 		--{ name = "Köpek Maması", description = "Oyun oynamak için bir alet.", price = 500, itemID = 297 },
	 	    --	{ name = "Kart Güvertesi", description = "Oyun oynamak için bir alet.", price = 10, itemID = 77 },
		    { name = "Paraşüt", description = "Paraşüt.", price = 50000, itemID = 115, itemValue = 46 },
            { name = "Beyzbol Sopası", description = "Hit a home run with this.", price = 300000, itemID = 115, itemValue = 5 },
            { name = "Bıçak", description = "To help ya out in the kitchen.", price = 500000, itemID = 115, itemValue = 4 },
			--{ name = "Other", description = "Please Specify", price = 0, itemID = 80 },
		--	{ name = "El Freni", description = "Karanlık alanlarda aydynlatmak için kullanabilece?iniz bir malzeme.", price = 24, itemID = 145 },
		},
		{
			name = "Fast Fod",
		--	{ name = "Yiyecek", description = "Karnınızı doyuracak bir yiyecek..", price = 6, itemID = 8 },
		--	{ name = "İçecek", description = "Susuzluğunuzu giderecek bir içecek..", price = 3, itemID = 9 },
		}
	},
	{ -- 2
		name = "Silah Marketi",
		description = "Silah NPC'si.",
		image = "gun.png",

		{
			name = "Silah Marketi",
		--	{ name = "Marijuana Tohumu", description = "/saksikoy", price = 5000000, itemID = 347 }, 	
			{ name = "Colt-45 Ammo", description = "Colt 45 17'lik  9mm pistol jarjörü", price = 75000, itemID = 116, itemValue = 22, ammo = 17, license = false },
			{ name = "Tec - 9 Ammo", description = "Tec - 9 Mermi", price = 300000, itemID = 116, itemValue = 32, license = false },
			{ name = "Desert Eagle Ammo", description = "Desert Eagle 7'lik jarjör", price = 100000, itemID = 116, itemValue = 24, ammo = 7, license = false },
			{ name = "AK-47 Ammo", description = "100'luk AK-47 Mermisi", price = 1200000, itemID = 116, itemValue = 30, ammo = 100, license = false },
		--	{ name = "Sniper Ammo", description = "10'luk Sniper Mermisi", price = 1500000, itemID = 116, itemValue = 34, ammo = 200, license = false },
			{ name = "M4 Ammo", description = "100'luk M4 Mermisi", price = 1500000, itemID = 116, itemValue = 31, ammo = 100, license = false },
      { name = "MP5 Ammo", description = "MP5 Mermisi", price = 450000, itemID = 116, itemValue = 29, ammo = 30, license = false },	
      { name = "Uzi Ammo", description = "uzi Mermisi", price = 340000, itemID = 116, itemValue = 28, ammo = 50, license = false },	
     -- { name = "Rifle Ammo", description = "Rifle.", price = 9500000, itemID = 116, itemValue = 33, ammo = 15, license = false },
      { name = "Silenced Ammo", description = "Silenced.", price = 200000, itemID = 116, itemValue = 23,ammo = 17, license = false },
     -- { name = "Saved-OFF Ammo", description = "s.off.", price = 5000000, itemID = 116, itemValue = 26, ammo = 200, license = false },
     --  { name = "Combat-Shotgun Ammo", description = "combat.", price = 5000000, itemID = 116, itemValue = 27, ammo = 200, license = false },
    --  { name = "Shotgun Ammo", description = "combat.", price = 5000000, itemID = 116, itemValue = 25, ammo = 200, license = false },   

			--{ name = "Alet çantasi", description = "/duzkontak /kilitkir", price = 2000000, itemID = 10014 }, 
	--		{ name = "Colt-45 Ammo", description = "Colt 45 17'lik  9mm pistol jarjörü", price = 190000, itemID = 116, itemValue = 22, ammo = 50, license = false },
			--{ name = "Tec - 9", description = "Tec - 9", price = 9000000, itemID = 116, itemValue = 32,  ammo = 30, license = true },
		--	{ name = "Tec - 9 Ammo", description = "Tec - 9 Mermi", price = 550000, itemID = 116, itemValue = 32, license = false },
			--{ name = "Desert Eagle Pistol", description = "Desert Eagle.", price = 10000, itemID = 115, itemValue = 24, license = true },
		--	{ name = "Desert Eagle Ammo", description = "Desert Eagle 7'lik jarjör", price = 15000, itemID = 116, itemValue = 24, ammo = 25, license = false },
            --{ name = "Shotgun", description = "Silver Shotgun.", price = 210000, itemID = 115, itemValue = 25, license = true },
		--	{ name = "AK-47 Ammo", description = "10'luk Pompalı Mermisi", price = 900000, itemID = 116, itemValue = 30, ammo = 50, license = false },
			--{ name = "Country Rifle", description = "Country Rifle.", price = 9500000, itemID = 115, itemValue = 33, license = true },
			--{ name = "Sniper Ammo", description = "10'luk Sniper Mermisi", price = 5500000, itemID = 116, itemValue = 34, ammo = 50, license = false },
				--		{ name = "M4 Ammo", description = "10'luk M4 Mermisi", price = 500000, itemID = 116, itemValue = 31, ammo = 50, license = false },
          --  { name  "MP5 Ammo", description = "MP5 Mermisi", price = 200000, itemID = 116, itemValue = 29, ammo = 10, license = false },	
          --  { name = "MP5 Ammo", description = "MP5 Mermisi", price = 420000, itemID = 116, itemValue = 29, ammo = 50, license = false },	
            --{ name = "Uzi Ammo", description = "uzi Mermisi", price = 320000, itemID = 116, itemValue = 28, ammo = 50, license = false },	    		
		}
	},
	{ -- 3
		name = "Yemek NPC'si",
		description = "The least poisoned food and drinks on the planet.",
		image = "food.png",

		{
			name = "Yemek",
			{ name = "Sandviç", description = "Karnınızı doyuracak bir yiyecek!", price = 10, itemID = 8 },
	--		{ name = "Döner", description = "Karnınızı doyuracak bir yiyecek!", price = 3, itemID = 13 },
	--		{ name = "Kokoreç", description = "Karnınızı doyuracak bir yiyecek!", price = 3, itemID = 14 },
	--		{ name = "Tava", description = "Karnınızı doyuracak bir yiyecek!", price = 5, itemID = 1 },
	--		{ name = "Ekmek", description = "Karnınızı doyuracak bir yiyecek!", price = 2, itemID = 108 },
		},
		{
			name = "İçeçek",
			{ name = "Gazoz", description = "Susuzluğunuzu gidericek bir içecek..", price = 5, itemID = 9 },
			{ name = "Su", description = "Susuzluğunuzu gidericek bir içecek.", price = 3, itemID = 15 },
		}
	},
	{ -- 4
		name = "Sigara",
		description = "Aty?tyrmalyk yiyebilece?iniz ve içebilece?iniz me?rubatlar.",
		image = "sex.png",

		{
			name = "Sigaralar",
			{ name = "Murattı", description = "Murattı", price = 1700, itemID = 105, itemValue = 20 },
			{ name = "Wiston Slender Blue", description = "Winston.", price = 1600, itemID = 105, itemValue = 20},
			{ name = "Malbora Red", description = "Malbora Red", price = 1900, itemID = 105, itemValue = 20},
			{ name = "Marlboro Touch ", description = "Malbora Touch.", price = 1800, itemID = 105, itemValue = 20 },
			{ name = "Marlboro Edge", description = "Malbora Edge.", price = 1800, itemID = 105, itemValue = 20},
			{ name = "Camel Black", description = "Camel Black.", price = 1500, itemID = 105 , itemValue = 20},
			{ name = "Kent D Range Blue", description = "Kent", price = 1500, itemID = 105, itemValue = 20 },
			{ name = "Kent Switch", description = "Kent.", price = 1600, itemID = 105 , itemValue = 20},
			{ name = "Tekel 2001", description = "Tekel 2001.", price = 1400, itemID = 105 , itemValue = 20},
			{ name = "Tekel 2000", description = "Tekel 2000", price = 1200, itemID = 105, itemValue = 20 },
			{ name = "Parliament Night Blue ", description = "Parlament Night Blue.", price = 2000, itemID = 105, itemValue = 20 },
			{ name = "Winston Dark Blue", description = "Winston Dark Blue.", price = 1600, itemID = 105, itemValue = 20 },
			{ name = "L&M Blue", description = "LM", price = 1600, itemID = 105 , itemValue = 20},
			{ name = "Pall Mall Blue", description = "Pall Mall Blue.", price = 1300, itemID = 105 , itemValue = 20},
			{ name = "Chesterfield Blue", description = "Chesterfield Blue.", price = 1400, itemID = 105, itemValue = 20 },
			{ name = "Zippo", description = "Zippo", price = 20000, itemID = 107 },
		},
		{
			name = "Skin",
	--		{ name = "Skin 87", description = "Sexy clothes for sexy people.", price = 55, itemID = 16, itemValue = 87 },
	--		{ name = "Skin 178", description = "Sexy clothes for sexy people.", price = 55, itemID = 16, itemValue = 178 },
	--		{ name = "Skin 244", description = "Sexy clothes for sexy people.", price = 55, itemID = 16, itemValue = 244 },
	--		{ name = "Skin 246", description = "Sexy clothes for sexy people.", price = 55, itemID = 16, itemValue = 246 },
	--		{ name = "Skin 257", description = "Sexy clothes for sexy people.", price = 55, itemID = 16, itemValue = 257 },
		}
	},
	{ -- 5
		name = "Skin",
		description = "Yeni Kyyafetler!",
		image = "clothes.png",
		-- Items to be generated elsewhere.
		{
			name = "Clothes fitting you"
		},
		{
			name = "Others"
		}
	},
	{ -- 6
		name = "Dövüş Stilleri",
		description = "<3",
		image = "general.png",

		{
			name = "Metal Stilleri",
			{ name = "Silah Metali", description = "Metal", price = 1000000, itemID = 23103 },
		}
	},
	{ -- 7
		name = "MAÇ GÜNÜ",
		description = "MAÇ GÜNÜ", --"Your one and only stop for supplies.",
		image = "general.png",

		{
			name = "Maç Eşyaları",
			--{ name = "Fenerbahçe Bayrağı", description = "Bayrak.", price = 10000, itemID = 115, itemValue = 6 },
			--{ name = "Fenerbahçe FORMASI", description = "Fenerbahçe Forması", price = 10000, itemID = 16, itemValue = 271 },
			--{ name = "Beşiktaş Bayrağı", description = "Bayrak.", price = 10000, itemID = 115, itemValue = 2 },
           -- { name = "Beşiktaş FORMASI", description = "Beşiktaş Bayrağı.", price = 10000, itemID = 16, itemValue = 272 },
		}
	},
	{ -- 8
		name = "Elektronik",
		description = "Sizin için sadece a?yry derecede pahaly olan en son teknoloji.",
		image = "general.png",

		{
			name = "Elektronik",
			{ name = "Müzik Çalar", description = "Seyyar Muzikçalar.", price = 250, itemID = 54 },
			{ name = "Kamera", description = "Kamera", price = 75, itemID = 115, itemValue = "43::Camera" },
			{ name = "Telefon", description = "Gündelik hayatynyzda kullanabileceğiniz telefon.", price = 75, itemID = 2 },
			{ name = "Radio", description = "Radio.", price = 50, itemID = 6 },
		--	{ name = "Kulaklyk", description = "Yürürken kulaklyk takarak muzik dinleyebilirsiniz.", price = 225, itemID = 88 },
			{ name = "Saat", description = "Kol Saati", price = 25, itemID = 17 },
			{ name = "MP3 Çalar", description = "Beyaz, zarif görünümlü bir MP3 Çalar.", price = 120, itemID = 19 },
			{ name = "Kimya Seti", description = "Küçük bir kimya seti.", price = 2000, itemID = 44 },
			{ name = "GPS", description = "Arabada Kullanabileceğiniz GPS.", price = 300, itemID = 67 },
			{ name = "Tasinabilir GPS", description = "Aracinizi bulmanizi sağlayacak GPS.", price = 800, itemID = 111 },
			{ name = "Tasinabilir TV", description = "TV izlemek için portatif bir TV.", price = 750, itemID = 104 },
			{ name = "Ücretli geçici", description = "Otomobiliniz için: Ücretli geçii yaparken sizi otomatik olarak geçmenizi sağlar.", price = 400, itemID = 118 },
	--		{ name = "Araç Alarmy", description = "Aracynyzy bir alarm ile koruyun.", price = 800, itemID = 130 },
		--	{ name = "El Feneri", description = "Karanlyklary aydynlatmak için kullanabilece?iniz bir alet.", price = 24, itemID = 145 },
		}
	},
	{ -- 9
		name = "İçki",
		description = "Kafayy bulmanyz için bir NPC.",
		image = "general.png",

		{
			name = "Alcohol",
			{ name = "Kırmızı Tuborg", description = "Türkiye'nin en güzel birası.", price = 100, itemID = 58 },
			{ name = "İstanblue Vodka", description = "En iyi arkada?larynyz için- İstanblue Vodka.", price = 250, itemID = 62 },
			{ name = "Chivas Viski", description = "Chivas viski, gerçek lezzet.", price =500 , itemID = 63 },
			{ name = "Redbull", description = "Viskinin yanında içebileceğiniz asitli içecek.", price = 30, itemID = 9 },
			{ name = "Yeni Raki",description= "Sağlığınız için Yeni Rakı için",price=1000, itemID = 62},
		}
	},
	{ -- 10
		name = "Kacakcı",
		description = "New things to learn? Sound like... fun?!",
		image = "general.png",

		{
			name = "Books",
					--	{ name = "Cannabis Sativa", 	description = "Uyusturucu madde", price = 100, itemID = 30, itemValue = 1 },
	--{ name = "Cocaine Alkaloid", 	description = "Uyusturucu madde", price = 5000, itemID = 31, itemValue = 1 },
	--	 	{ name = "Lysgeric Acid", 		description = "Uyusturucu madde", price = 5000, itemID = 32, itemValue = 1 },
	--		{ name = "Unprocessed PSP", 	description = "Uyusturucu madde", price = 5000, itemID = 33, itemValue = 1 },
	--		{ name = "Cocaine", 			description = "Uyusturucu madde", price = 5000, itemID = 34, itemValue = 1 },
	--		{ name = "Drug 2", 				description = "Uyusturucu madde", price = 5000, itemID = 35, itemValue = 1 },
	--		{ name = "Drug 3", 				description = "Uyusturucu madde", price = 5000, itemID = 36, itemValue = 1 },
	--		{ name = "Drug 4", 				description = "Uyusturucu madde", price = 5000, itemID = 37, itemValue = 1 },
	--		{ name = "Marijuana", 			description = "Uyusturucu madde", price = 5000, itemID = 38, itemValue = 1 },
 	--{ name = "Drug 6", 				description = "Uyusturucu madde", price = 5000, itemID = 39, itemValue = 1 },
	--		{ name = "Angel Dust", 			description = "Uyusturucu madde", price = 5000, itemID = 40, itemValue = 1 },
	--		{ name = "LSD", 				description = "Uyusturucu madde", price = 5000, itemID = 41, itemValue = 1 },
	--		{ name = "Drug 9", 				description = "Uyusturucu madde", price = 5000, itemID = 42, itemValue = 1 },
	--		{ name = "PCP Hydrochloride", 	description = "Uyusturucu madde", price = 5000, itemID = 43, itemValue = 1 },
	--		{ name = "Chemistry Set", 		description = "Uyusturucu madde", price = 5000, itemID = 44, itemValue = 1 },
		}
	},
	{ -- 11
		name = "Kahve",
		description = "İçini ısıtacak sıcak bişiler mi içmek istiyorsun?",
		image = "food.png",

		{
			name = "Yiyecek",
			{ name = "Çörek", description = "Sıcak yapılan şeker kaplı çörek", price = 5, itemID = 13 },
			{ name = "Kurabiye", description = "Bir lüks çikolatalı çerezi", price = 5, itemID = 14 },
		},
		{
			name = "İçecek",
			{ name = "Caramel Macchiato", description = "Caramel soslu expresso.", price = 20, itemID = 83, itemValue = 2 },
			{ name = "Schwippes", description = "Soğuk mandalina aromalı bir içecek..", price = 20, itemID = 9, itemValue = 3 },
			{ name = "White Chocolate Mocha", description = "Starbuks'ın en iyi yaptığı kahve.", price = 30, itemID = 83, itemValue = 2 },
			{ name = "Filtre Kahve", description = "Kahve severler için yoğun kahve tadı.", price = 10, itemID = 83, itemValue = 2 },
			{ name = "Caffe Latte", description = "Expresso ve sütün müthiş birleşimi.", price = 20, itemID = 83, itemValue = 2 },
			{ name = "Su", description = "Bir ?i?e su.", price = 1, itemID = 15, itemValue = 2 },
		}
	},
	{ -- 12
		name = "Santa's Grotto",
		description = "Ho-ho-ho, Merry Christmas.",
		image = "general.png",

		{
	--		name = "Christmas Items",
	--		{ name = "Christmas Present", description = "What could be inside?", price = 0, itemID = 94 },
	--		{ name = "Eggnog", description = "Yum Yum!", price = 0, itemID = 91 },
	--		{ name = "Turkey", description = "Yum Yum!", price = 0, itemID = 92 },
	--		{ name = "Christmas Pudding", description = "Yum Yum!", price = 0, itemID = 93 },
		}
	},
	{ -- 13
		name = "Kasap&Maden Mesleği",
		description = "Kasap&Maden Mesleği.",
		image = "general.png",

		{
			name  = "Yiyecek",
			{ name = "Pala", description = "Pala.", price = 3000, itemID = 115, itemValue = 2 },
			{ name = "Kürek", description = "Kürek", price = 100000, itemID = 115, itemValue = 6 },
		}
	},
	{ -- 15
		name = "NPC",
		description = "(( This is just an NPC, not meant to hold any items. ))",
		image = "general.png",

		{
			name = "No items"
		}
	},
	{ -- 16
		name = "Donanym ma?azasy",
		description = "Aletlere mi ihtiyacynyz var?!",
		image = "general.png",

		{
			name = "Elektrikli El Aletleri",
			{ name = "Elektrikli Matkap", description = "Matkap.", price = 50, itemID = 80, itemValue = "Power Drill" },
			{ name = "Motorlu testere", description = "Testere.", price = 65, itemID = 80, itemValue = "Power Saw" },
			{ name = "Pnömatik Tırnak Silaheri", description = "Tyrnak Silaheri.", price = 80, itemID = 80, itemValue = "Pneumatic Nail Gun" },
			{ name = "Pnömatik Boya Tabancası", description = "Boya Tabancasy.", price = 90, itemID = 80, itemValue = "Pneumatic Paint Gun" },
			{ name = "Hava Anahtarı", description = "Hava Anahtary.", price = 80, itemID = 80, itemValue = "Air Wrench" },
			{ name = "Meşale", description = "Me?ale.", price = 80, itemID = 80, itemValue = "Mobile Torch Set" },
			{ name = "Elektrikli kaynakçy", description = "Elektrikli Kaynakçy.", price = 80, itemID = 80, itemValue = "Mobile Electric Welder" },
		},
		{
			name = "El aletleri",
			{ name = "Çekiç", description = "Çekiç.", price = 25, itemID = 80, itemValue = "Iron Hammer" },
			{ name = "Yyldyz tornavida", description = "Yyldyz Tornavida.", price = 5, itemID = 80, itemValue = "Phillips Screwdriver" },
			{ name = "Düz tornavida", description = "Düz Tornavida.", price = 5, itemID = 80, itemValue = "Flathead Screwdriver" },
			{ name = "Robinson Tornavidasy", description = "Robinson Tornavidasy.", price = 6, itemID = 80, itemValue = "Robinson Screwdriver" },
			{ name = "Torx Tornavidasy", description = "Torx Tornavidasy.", price = 8, itemID = 80, itemValue = "Torx Screwdriver" },
			{ name = "Y?ne Burun Pensesi", description = "Y?ne Burun Pensesi.", price = 25, itemID = 80, itemValue = "Needlenose Pliers" },
			{ name = "Levye", description = "Levye.", price = 30, itemID = 80, itemValue = "Iron Crowbar" },
			{ name = "Bijon anahtary", description = "Bijon Anahtary.", price = 25, itemID = 80, itemValue = "Tire Iron" },
			{ name = "Yngiliz anahtary", description = "Yngiliz Anahtary.", price = 7, itemID = 80, itemValue = "Wrench" },
			{ name = "Maymuncuk", description = "Maymuncuk", price = 12, itemValue = "Monkey Wrench" },
			{ name = "Soket Anahtary", description = "Soket Anahtary.", price = 8, itemValue = "Socket Wrench" },
			{ name = "Tork anahtary", description = "Tork Anahtary.", price = 35, itemID = 80, itemValue = "Torque Wrench" },
			{ name = "Vise Grip", decsription = "Vise grip.", price = 12, itemID = 80, itemValue = "Vise Grip" },
			{ name = "Tel kesiciler", decsription = "Tel testere", price = 6, itemID = 80, itemValue = "Wirecutters" },
			{ name = "Kesme Testere", description = "Kesme Testere", price = 40, itemID = 80, itemValue = "Hack Saw" },
		},
		{
			name = "Vidalar ve Çiviler",
			{ name = "Yıldız Vidalar", description = "Yyldyz Vidalar.", price = 3, itemID = 80, itemValue = "Phillips Screws (100)" },
			{ name = "Düz Vidalar", description = "Düz Vidalar.", price = 3, itemID = 80, itemValue = "Flathead Screws (100)" },
			{ name = "Robinson Vidalary", description = "Robinson Vidalar.", price = 3, itemID = 80, itemValue = "Robinson Screws (100)" },
			{ name = "Torx Vidaları", description = "Torx Vidalar.", price = 3, itemID = 80, itemValue = "Torx Screws (100)" },
			{ name = "Demir tırnaklar", description = "Demir Tyrnaklar.", price = 2, itemID = 80, itemValue = "Iron Nails (100)" },
		},
		{
			name = "Di?er Çe?itler.",
			{ name = "Çerçeve", description = "Çerçeve", price = 300, itemID = 147, itemValue = "1" },
			{ name = "Bosch 6 Galon Hava Kompresörü", description = "Hava Kompresörü.", price = 300, itemID = 80, itemValue = "Bosch 6 Gallon Air Compressor" },
			{ name = "Deri eldivenler", description = "Deri Eldivenler.", price = 2, itemID = 80, itemValue = "Leather Gloves" },
			{ name = "Lateks eldiven", description = "Lateks Eldiven.", price = 1, itemID = 80, itemValue = "Latex Gloves" },
			{ name = "Clorox Bleach", description = "Clorox Bleach.", price = 13, itemID = 80, itemValue = "Chlorex Bleach" },
			{ name = "Boya tenekesi", description = "Boya Tenekesi.", price = 10, itemID = 80, itemValue = "Paint Can" },
			{ name = "Araç Kutusu", description = "Araç Kutusu.", price = 20, itemID = 80, itemValue = "Red Metal Toolbox" },
			{ name = "Lastikli Plastik Çöp Kovası", description = "Lastikli Plastik Çöp Kovası.", price = 25, itemID = 80, itemValue = "Rubbermaid Plastic Trashcan" },
		}
	},
	{ -- 17
		name = "Kıyafetler",
		description = "Buradan Kıyafet Satın Alabilirsiniz.",
		image = "general.png",
	},
	{ -- 18
		name = "Tackle Shop",
		description = "All your fishing needs!",
		image = "general.png",

		{
			name  = "Fishing Stuff",
	--		{ name = "Fishing Rod", description = "A sport fishing rod.", price = 150, itemID = 49 },
	--		{ name = "Fishing Bait", description = "A tin of fishing bait.", price = 25, itemID = 74, itemValue = 15 },
		}
	},
	{ -- 19
		name = "Mobilyaci",
		description = "Her yere göre mobilya!",
		image = "general.png",

		{
			name  = "Mobilyalar",
	{ name = "Kasa", description = "Değerli Eşyalarınızı Saklayabilmek İçin Bir Kasa", price = 250, itemID = 60 },
		}
	},
		{ -- 20
		name = "Kornalar",
		description = "Korna almanız için bir npc.",
		image = "general.png",

		{
			name = "Korna",
			{ name = "Korna #1", description = "Havalı korna", price = 50000, itemID = 418 },
			{ name = "Korna #2", description = "Havalı korna", price = 50000, itemID = 419 },
			{ name = "Korna #3", description = "Havalı korna", price = 50000, itemID = 420 },
			{ name = "Korna #4", description = "Havalı korna", price = 50000, itemID = 421 },
			{ name = "Korna #5", description = "Havalı korna", price = 50000, itemID = 422 },
			{ name = "Korna #6", description = "Havalı korna", price = 50000, itemID = 423 },
		}
	},
}

-- some initial updating once you start the resource
function loadLanguages( )
	local shop = g_shops[ 10 ]
	for i = 1, exports['language-system']:getLanguageCount() do
		local ln = exports['language-system']:getLanguageName(i)
		if ln then
			table.insert( shop[1], { name = ln .. " Dictionary", description = "A Dictionary, useful for learning " .. ln .. ".", price = 25, itemID = 69, itemValue = i } )
		end
	end
end

addEventHandler( "onResourceStart", resourceRoot, loadLanguages )
addEventHandler( "onClientResourceStart", resourceRoot, loadLanguages )

-- util

function getItemFromIndex( shop_type, index )
	local shop = g_shops[ shop_type ]
	if shop then
		for _, category in ipairs( shop ) do
			if index <= #category then
				return category[index]
			else
				index = index - #category
			end
		end
	end
end

function getFittingSkins()
	return fittingskins
end


--
local simplesmallcache = {}
function updateItems( shop_type, race, gender )
	if shop_type == 5 then -- clothes shop
		-- one simple small cache it is - prevents us from creating those tables again and again
		
		local c = simplesmallcache[tostring(race) .. "|" .. tostring(gender)]
		if c then
			shop = c
			return
		end
		
		-- load the shop
		local shop = g_shops[shop_type]
		
		-- clear all items
		for _, category in ipairs(shop) do
			while #category > 0 do
				table.remove( category, i )
			end
		end
		
		-- uber complex logic to add skins
		local nat = {}
		local availableskins = fittingskins[gender][race]
		table.sort(availableskins)
		for k, v in ipairs(availableskins) do
			table.insert( shop[1], { name = "Skin " .. v, description = "MTA Skin #" .. v .. ".", price = 50, itemID = 16, itemValue = v, fitting = true } )
			nat[v] = true
		end
		
		local otherSkins = {}
		for gendr = 0, 1 do
			for rac = 0, 2 do
				if gendr ~= gender or rac ~= race then
					for k, v in pairs(fittingskins[gendr][rac]) do
						if not nat[v] then
							table.insert(otherSkins, v)
						end
					end
				end
			end
		end
		table.sort(otherSkins)
		
		for k, v in ipairs(otherSkins) do
			table.insert( shop[2], { name = "Skin " .. v, description = "MTA Skin #" .. v .." - you can NOT wear this.", price = 50, itemID = 16, itemValue = v } )
		end
		-- simplesmallcache[tostring(race) .. "|" .. tostring(gender)] = shop
	elseif shop_type == 14 then
		-- param (race)= vehicle model
		local c = simplesmallcache["vm"]
		if c then
			return
		end
		
		-- remove old data
		for _, category in ipairs(shop) do
			while #category > 0 do
				table.remove( category, i )
			end
		end
		
		for v = 1000, 1193 do
			if vehicle_upgrades[v-999] then
				local str = exports['item-system']:getItemDescription( 114, v )
				
				local p = str:find("%(")
				local vehicleName = ""
				if p then
					vehicleName = str:sub(p+1, #str-1) .. " - "
					str = str:sub(1, p-2)
				end
				table.insert( shop[1], { name = vehicleName .. ( getVehicleUpgradeSlotName(v) or "Lights" ), description = str, price = vehicle_upgrades[v-999][2], itemID = 114, itemValue = v})
			end
		end
		
		simplesmallcache["vm"] = true
	end
end
