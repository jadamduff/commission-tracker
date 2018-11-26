let formVisible = false;

function loadManager() {
  let managerId = $('.manager-body')[0].dataset.id;
  $.get('/users/' + managerId, function(data) {
    let products = data.data.attributes['manager-data'].products;
    ManagerProduct.loadProducts(products);
  });
}

function loadEmployee() {
  let employeeId = $('.employee-body')[0].dataset.id;
  $.get('/users/' + employeeId, function(data) {
    let sales = data.data.attributes['employee-data'].sales;
    Sale.loadSales(sales);
  });
}

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
  $('#new_product div').removeClass('field_with_errors');
  $('.form_box_md_container_popup').show().animate({
    opacity: 1
  }, 75).hide();
  formVisible = false;
}

$(document).on('turbolinks:load', function() {

  let formTether;
  let buttonText = $('.button').text();

  if ($('.manager-body').length > 0) {
    loadManager();
  } else {
    loadEmployee();
  }

  if ($('.button').length > 0) {
    formTether = new Tether({
      element: $('.form_box_md_container_popup'),
      target: $('.button'),
      attachment: 'top right',
      targetAttachment: 'bottom right'
    });
  }

  $('.form_box_md_container_popup').hide();

  $('.button').on('click', function(e) {
    console.log(formVisible);
    if (formVisible === false) {
      openForm($('.button'));
    } else {
      closeForm($('.button'), buttonText);
    }
  });
})
