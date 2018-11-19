let formVisible = false;

function openForm(button) {
  button.addClass('activated');
  button.text('Cancel');
  $('.form_box_md_container_popup').show().animate({
    opacity: 1
  }, 75);
  formVisible = true;
}

function closeForm(button, text) {
  $('form')[0].reset();
  button.removeClass('activated');
  button.text(text);
  $('#new_sale div').removeClass('field_with_errors');
  $('.form_box_md_container_popup').show().animate({
    opacity: 1
  }, 75).hide();
  formVisible = false;
}

$(document).on('turbolinks:load', function() {

  let formTether;
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
      openForm($(this));
    } else {
      closeForm($(this), buttonText);
    }
  });
})
