/**
 * @author Pete
 */

$(document).ready(function(){
	$('.blocktimefield').keyup(function(){
		var bTime = $(this).val();
		if(validateBlockTime($(this), bTime) && validKeys()) {
			$(this).parent().parent().next().find('input').focus();
		}
	})
})

function validKeys(){
	if((event.shiftKey && event.keyCode == 9) || (event.keyCode == 9) || (event.shiftKey)){
		return false;
	}
	return true;
}

function validateBlockTime(input, bTime){
	return false; //TODO is this needed?
		if(bTime.length < 4) return false;

        var th = parseInt(bTime.substring(0, 2));
        var tm = parseInt(bTime.substring(2, 4));

        if(th > 23 | tm > 59){
            input.css("color", "red");
            return false;
        } else {
            input.css("color","");
        }
        return true;
}
