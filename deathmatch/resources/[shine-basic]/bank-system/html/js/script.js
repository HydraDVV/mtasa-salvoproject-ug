//var kadi = document.getElementById("rkadi").value;
//var mail = document.getElementById("mail").value;
//mta.triggerEvent("htmllogin:sign" , kadi , sifre , sifre2 , mail)

			window.addEventListener('message', function(event) {
				if (event.data.type === "openGeneral"){
		     	         $('#waiting').show();
		     	         $('body').addClass("active");
				} else if(event.data.type === "balanceHUD") {
						$('.username1').html(event.data.player);
						$('.money').html(event.data.player);
						$('.curbalance').html(event.data.balance);
				} else if (event.data.type === "closeAll"){
		     	         $('#waiting, #general, #transferUI, #withdrawUI, #depositUI, #topbar').hide();
		     	         $('body').removeClass("active");
				}
				else if (event.data.type === "result") {
					if (event.data.t == "success")
						$("#result").attr('class', 'alert-green');
					else
						$("#result").attr('class', 'alert-orange');
					$("#result").html(event.data.m).show().delay(5000).fadeOut();
				}
			});

    		$('.btn-sign-out').click(function(){
	            //$('#general, #waiting, #transferUI, #withdrawUI, #depositUI, #topbar').hide();
	            //$('body').removeClass("active");
	            //$.post('http://new_banking/NUIFocusOff', JSON.stringify({}));
	            mta.triggerEvent("banka:cik")
	        })
	        $('.back').click(function(){
	            $('#depositUI, #withdrawUI, #transferUI, #vadeUI').hide();
	            $('#general').show();
	        })
	        $('#deposit').click(function(){
	            $('#general').hide();
	            $('#depositUI').show();
	        })
	        $('#withdraw').click(function(){
	            $('#general').hide();
	            $('#withdrawUI').show();
	        })
	        $('#transfer').click(function(){
	            $('#general').hide();
	            $('#transferUI').show();
	        })
	        $('#vade').click(function(){
	            $('#general').hide();
	            $('#vadeUI').show();
	        })
	        $('#fingerprint-content').click(function(){
	            $('.fingerprint-active, .fingerprint-bar').addClass("active")
	            setTimeout(function(){
		  		$('#general').css('display', 'block')
					$('#topbar').css('display', 'flex')
					$('#waiting').css('display', 'none')
					$('.fingerprint-active, .fingerprint-bar').removeClass("active")
				}, 1400);
	        })
	        $("#deposit1").submit(function(e) {
		        e.preventDefault(); // Prevent form from submitting
		        $.post('http://new_banking/deposit', JSON.stringify({
		            amount: $("#amount").val()
		        }));
				$('#depositUI').hide();
				$('#general').show();

				var miktar2 = document.getElementById("amount").value;			
				mta.triggerEvent("banka:parayatir" , miktar2)
			});
			$("#transfer1").submit(function(e) {
		        e.preventDefault(); // Prevent form from submitting
		        $.post('http://new_banking/transfer', JSON.stringify({
					to: $("#to").val(),
		            amountt: $("#amountt").val()
		        }));
				$('#transferUI').hide();
				$('#general').show();
				
				var miktar3 = document.getElementById("amountt").value;
				var kisi = document.getElementById("to").value;

				mta.triggerEvent("banka:transfer" , miktar3 , kisi)

			});
			$("#withdraw1").submit(function(e) {
				e.preventDefault(); // Prevent form from submitting
		        $.post('http://new_banking/withdrawl', JSON.stringify({
		            amountw: $("#amountw").val()
		        }));
				$('#withdrawUI').hide();
				$('#general').show();
				//var miktar = $("#amountw").value;
				var miktar = document.getElementById("amountw").value;

				mta.triggerEvent("banka:paracek" , miktar)

			});
			document.onkeyup = function(data){
		        if (data.which == 27){
		            $('#general, #waiting, #transferUI, #withdrawUI, #depositUI, #topbar').hide();
		            $('body').removeClass("active");
		            $.post('http://new_banking/NUIFocusOff', JSON.stringify({}));
		        }
		    }