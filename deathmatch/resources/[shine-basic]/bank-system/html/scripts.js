var state = true;
function tabAyar(TAB){
	if (state) {
		var elementler = document.querySelectorAll('.tab');
		for (var i = 0; i < elementler.length; i++) {
			elementler[i].setAttribute("class", "tab");
		}
		document.getElementById("PNL1").setAttribute("class", "pnl-disabled");
		document.getElementById("PNL2").setAttribute("class", "pnl-disabled");
		document.getElementById("PNL"+TAB.getAttribute("data-tab-id")).removeAttribute("class");
		TAB.setAttribute("class", "tab active");
	}
}
function panelAc(ID){
	document.getElementById(ID).setAttribute("style", "display: block");
	document.getElementById("PNLBank").setAttribute("style", "opacity: .5;");
	document.getElementById("BTNParaCek").setAttribute("disabled", "true");
	document.getElementById("BTNParaYatir").setAttribute("disabled", "true");
	document.getElementById("BTNParaGonder").setAttribute("disabled", "true");
	state = false;
}
function PNLKapat(ID) {
	document.getElementById(ID).removeAttribute("style");
	document.getElementById("PNLBank").removeAttribute("style");
	document.getElementById("BTNParaCek").removeAttribute("disabled");
	document.getElementById("BTNParaYatir").removeAttribute("disabled");
	document.getElementById("BTNParaGonder").removeAttribute("disabled");
	state = true;
}
function paraCek(){
	var MIKTAR = document.getElementById("TXTCekilecekMiktar").value;
	mta.triggerEvent('paraCek', MIKTAR); // CLIENTSIDE EVENT ÇALIŞTIRIR.
	document.getElementById("TXTCekilecekMiktar").value = "";
	PNLKapat('PNLParaCek');
}
function paraYatir(){
	var MIKTAR = document.getElementById("TXTYatirilacakMiktar").value;
	mta.triggerEvent('paraYatir', MIKTAR); // CLIENTSIDE EVENT ÇALIŞTIRIR.
	document.getElementById("TXTYatirilacakMiktar").value = "";
	PNLKapat('PNLParaYatir');
}
function paraGonder(){
	var MIKTAR = document.getElementById("TXTGonderilecekMiktar").value;
	var ID = document.getElementById("TXTGonderilecekID").value;
	var SEBEP = document.getElementById("TXTGonderilecekSebep").value;
	mta.triggerEvent('paraGonder', MIKTAR, ID, SEBEP); // CLIENTSIDE EVENT ÇALIŞTIRIR.
	document.getElementById("TXTGonderilecekMiktar").value = "";
	document.getElementById("TXTGonderilecekID").value = "";
	document.getElementById("TXTGonderilecekSebep").value = "";
	PNLKapat('PNLParaGonder');
}
function bankakapat(){
	mta.triggerEvent("bankakapat");
}

function change(el, dat) {
    $('.' + el).text(dat);
}