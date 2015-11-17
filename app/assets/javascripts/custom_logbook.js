/**
 * @author Pete
 */

$(document).ready(function(){
	$('.blocktimefield').keyup(function(){
		var bTime = $(this).val();
		if(validateBlockTime($(this), bTime)) {
			$(this).parent().parent().next().find('input').focus();
		}
	})
})

function validateBlockTime(input, bTime){
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
