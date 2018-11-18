$(document).on('turbolinks:load', function() {

  let formTether;
  let formVisible = false;
  let buttonText = $('.button').text();

  if ($('.button').length > 0) {
    formTether = new Tether({
      element: $('.form_box_md_container_popup'),
      target: $('.button'),
      attachment: 'top right',
      targetAttachment: 'bottom right'
    });
  }

  $('.form_box_md_container_popup').hide();

  $(document).on('click', '.button', function(e) {
    if (formVisible === false) {
      $(this).addClass('activated');
      $(this).text('Cancel');
      $('.form_box_md_container_popup').show().animate({
        opacity: 1
      }, 75);
      formVisible = true;
    } else {
      $('form')[0].reset();
      $(this).removeClass('activated');
      $(this).text(buttonText);
      $('.form_box_md_container_popup').show().animate({
        opacity: 1
      }, 75).hide();
      formVisible = false;
    }
  });

  getSoldProductsIds();

  console.log('worked');

})
