// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// Order is important! Dependencies have to be required before the dependant.
//
//= require jquery
//= require jquery_ujs
//= require subscriptions
//= require scrollreveal
//= require jquery.card
//= require toastr
//= require dojo
//= require js.cookie

// Stripe Coupon Discounts calculations
function hasPromo()
{
  return Cookies.get("promo") !== undefined;
}

function discountedPrice(price)
{
  var discount;
  if (discount = Cookies.get("promo_percent_off"))
  {
    price = price * (1 - (discount/100));
  }

  // otherwise, no discount, price remains same

  // return formatted price
  return (Math.round(price * 100)/100).toFixed(2);
}
