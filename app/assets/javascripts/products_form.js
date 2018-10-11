//= require jquery
//= require jquery_ujs

$(document).ready(function() {
  console.log('worked');

  $('.color_box').click(function() {
    var hexColor = rgb2hex($(this).css('backgroundColor'))
    $('#product_color').val(hexColor);
  });

  var hexDigits = new Array
        ("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");

  //Function to convert rgb color to hex format
  function rgb2hex(rgb) {
   rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
   return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
  }

  function hex(x) {
    return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
   }

});
