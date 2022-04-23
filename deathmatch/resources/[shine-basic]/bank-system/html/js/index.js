var un = "";
var pw = "";
var page = "";

$('.to').on('click', function() {
    show($(this).attr("data-to"));
    return false;
});



var un = "";
var pw = "";
var page = "";

$('.to').on('click', function() {
    show($(this).attr("data-to"));
    return false;
});





function checkQuestions() {
	var right = 0;
	var wrong = 0;
	$.each([ 1, 2, 3, 4, 5, 6, 7, 8 ], function( index, value ) {
		if($('#answer' + value + questAnswers[value]).is(":checked")) {
			right++;
		} else {
			wrong++;
		}
	});
	mta.triggerEvent("check-quest", right, wrong);
}





function show(to){
	page = to;
	$(".box").hide();
	$("#" + to).show();
	if(to == "cüzdan"){
		$("#Lusername").removeAttr("readonly");
	}
}

show("cüzdan");
$(".box").css("z-index", "1");


function checkQuestions() {
	var right = 0;
	var wrong = 0;
	$.each([ 1, 2, 3, 4, 5, 6, 7, 8 ], function( index, value ) {
		if($('#answer' + value + questAnswers[value]).is(":checked")) {
			right++;
		} else {
			wrong++;
		}
	});
	mta.triggerEvent("check-quest", right, wrong);
}





