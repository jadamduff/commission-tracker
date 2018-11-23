function ManagerProduct(attributes) {
  this.id = attributes.id;
  this.color = attributes.color;
  this.title = attributes.title;
  this.price = attributes.price;
  this.commission = attributes.commission;
  this.saleCount = attributes['sale-count'];
  this.revenue = attributes.revenue;
  this.isFree = attributes['is-free'];
}

ManagerProduct.prototype.renderProductDiv = function() {
  return ManagerProduct.template(this);
}

ManagerProduct.success = function(data) {
  console.log(data);
  let product = new ManagerProduct(data.data.attributes.data);
  let productDiv = product.renderProductDiv();
  $('#manager_products_header').after(productDiv);
  closeForm($('.button'), 'New Product');
}

ManagerProduct.failure = function(data) {
  let errors = Object.keys(data.errors);
  if ($.inArray('title', errors) >= 0) {
    $('#product-title-label').addClass('field_with_errors');
  } else {
    $('#product-title-label').removeClass('field_with_errors');
  }
  if ($.inArray('price', errors) >= 0) {
    $('#product-price-label').addClass('field_with_errors');
  } else {
    $('#product-price-label').removeClass('field_with_errors');
  }
  if ($.inArray('commission', errors) >= 0) {
    $('#product-commission-label').addClass('field_with_errors');
  } else {
    $('#product-commission-label').removeClass('field_with_errors');
  }
  if ($.inArray('color', errors) >= 0) {
    $('#product-color-label').addClass('field_with_errors');
  } else {
    $('#product-color-label').removeClass('field_with_errors');
  }
}

ManagerProduct.handleResponse = function(data) {
  let respData = data;
  if ($.isEmptyObject(data.errors)) {
    ManagerProduct.success(respData);
  } else {
    ManagerProduct.failure(respData);
  }
}

ManagerProduct.rgbConverter = function(rgb) {
  var rgbvals = /rgb\((.+),(.+),(.+)\)/i.exec(rgb);
  var rval = parseInt(rgbvals[1]);
  var gval = parseInt(rgbvals[2]);
  var bval = parseInt(rgbvals[3]);
  return '#' + (
    rval.toString(16) +
    gval.toString(16) +
    bval.toString(16)
  ).toUpperCase();
}

ManagerProduct.formColorPicker = function() {
  $(document).on('click', '.color_box', function() {
    console.log('clicked');
    $('#product_color').val(ManagerProduct.rgbConverter($(this).css('background-color')));
  });
}

ManagerProduct.formSubmitListener = function() {
  console.log('worked');
  $('#new_product').on('submit', function(e) {
    e.preventDefault();
    let $form = $(this);
    let values = $form.serialize();
    let posting = $.post('/products', values);
    posting.success(ManagerProduct.handleResponse);
  })
}


ManagerProduct.ready = function() {
  ManagerProduct.templateSource = $('#manager-product-template').html();
  ManagerProduct.template = Handlebars.compile(ManagerProduct.templateSource);
  ManagerProduct.formColorPicker();
  ManagerProduct.formSubmitListener();
}

$(document).on('turbolinks:load', function() {
  if ($('#manager-product-template').length > 0) {
    ManagerProduct.ready();
  }
})
