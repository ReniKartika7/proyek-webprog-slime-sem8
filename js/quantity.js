String.prototype.getDecimals || (String.prototype.getDecimals = function(){

}), jQuery(document).on("click", ".button-plus, .button-minus", function(){
    var a = jQuery(this).closest(".quantity-button").find(".input-qty");
    var b = jQuery(this).closest(".row").find(".total");
    var price = jQuery(this).closest(".quantity-button").find(".snack-price");
    var price_val = parseFloat(price.val());
    var a_value = parseFloat(a.val());
    var a_max = parseFloat(a.attr("max"));
    var a_min = parseFloat(a.attr("min"));
    var a_step = a.attr("step");

    if(a_max != a_min){
        a_value && "" !== a_value && "NaN" !== a_value || (a_value = 0), 
        "" !== a_max && "NaN" !== a_max || (a_max = ""), 
        "" !== a_min && "NaN" !== a_min || (a_min = 0), 
        "any" !== a_step && "" !== a_step && void 0 !== a_step && "NaN" !== parseFloat(a_step) || (a_step = 1), 
        jQuery(this).is(".button-plus") ? a_max && a_value >= a_max ? a.val(a_max) : a.val((a_value + parseFloat(a_step)).toFixed(a_step.getDecimals())) : a_min && a_value <= a_min ? a.val(a_min) : a_value > 0 && a.val((a_value - parseFloat(a_step)).toFixed(a_step.getDecimals())), 
        a.trigger("change");
    }

    if(b.text() !== ""){
        b.text("Rp" + (price_val * a.val()).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1."));

        var snackPrice = $(".snack-price");
        var inputQty = $(".input-qty");
        var subTotal = 0;
        for(var i = 0; i < snackPrice.length; i++){
            subTotal = subTotal + parseFloat($(snackPrice[i]).val()) * parseFloat($(inputQty[i]).val());
        }
        var c = $(".total-price-value");
        c.text("Rp" + subTotal.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1."));
        
        var http = new XMLHttpRequest();
        http.open("POST", "doUpdateCart.jsp", true);
        http.setRequestHeader("Content-type","application/x-www-form-urlencoded");

        var snackId = jQuery(this).closest(".quantity-button").find(".snack-id");

        var params = "snackId=" + snackId.val() +
                    "&qty=" + a.val() ;
        
        http.send(params);
    }

    
});