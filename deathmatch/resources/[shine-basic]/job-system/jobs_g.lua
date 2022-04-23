function getJobTitleFromID(jobID)
	if (tonumber(jobID)==1) then
		return "Kargo Şoförü"
	elseif (tonumber(jobID)==2) then
		return "Taksi Şoförü"
	elseif  (tonumber(jobID)==3) then
		return "Otobüs Şoförü"
	elseif (tonumber(jobID)==4) then
		return "Şehir Temizlikçisi"
	elseif (tonumber(jobID)==5) then
		return "Tamirci"
	elseif (tonumber(jobID)==6) then
		return "Çilingir"
	elseif (tonumber(jobID)==7) then
		return "Tup Dağıtım"
	elseif (tonumber(jobID)==8) then
		return "Kaçak Cay"
	elseif (tonumber(jobID)==10) then
		return "Seyahat Şöförü"
	elseif (tonumber(jobID)==12) then
		return "Yol Temizlikçisi"
	elseif (tonumber(jobID)==13) then
		return "Çöpcülük"		
	elseif (tonumber(jobID)==14) then
		return "Beton Taşımacılığı"
	elseif (tonumber(jobID)==15) then
		return "Deniz Taşımacılığı"
		elseif (tonumber(jobID)==16) then
		return "Temizlik"	
	elseif (tonumber(jobID)==18) then
		return "Sigara Kaçakçısı"
	elseif (tonumber(jobID)==19) then
		return "İçki Kaçakçısı"
	elseif (tonumber(jobID)==20) then
		return "Operatör"		
	elseif (tonumber(jobID)==21) then
		return "Minibus"	
	elseif (tonumber(jobID)==22) then
		return "Kamyon"			
    elseif (tonumber(jobID)==25) then
		return "Pizza"		
	elseif (tonumber(jobID)==26) then
		return "Gazete"		
	elseif (tonumber(jobID)==27) then
	    return "Araç Taşımacılığı"
    elseif (tonumber(jobID)==28) then
		return "Ekmek"	
    elseif (tonumber(jobID)==28) then
		return "Kargo"	
	elseif (tonumber(jobID)==29) then
		return "Taksi Şöförü"
	elseif (tonumber(jobID)==30) then
		return "Araç Taşımacılığı"
	elseif (tonumber(jobID)==31) then
			return "Kaçak Et"	
    elseif (tonumber(jobID)==32) then
			return "Tır Şöförü"				
	else
		return "İşsiz"
	end
end