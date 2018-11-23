function Sale(attributes) {
  this.id = attributes.id;
  this.earnings = attributes.earnings;
  this.total = attributes.total;
  this.quantity = attributes.quantity;
  this.productColor = attributes['product-color'];
  this.productTitle = attributes['product-title'];
  this.commission = attributes.commission;
  this.isFree = attributes['is-free'];
}

Sale.prototype.renderSaleDiv = function() {
  return Sale.template(this);
}

Sale.success = function(data) {
  let sale = new Sale(data.data.attributes.data.sale);
  let product = new EmployeeProduct(data.data.attributes.data.product);
  let saleDiv = sale.renderSaleDiv();
  product.updateSoldProducts();
  $('#sales_header').after(saleDiv);
  $('.earnings').text(data.data.attributes.data['total-earnings']);
  closeForm($('.button'), 'New Sale');
}

Sale.failure = function(data) {
  let errors = Object.keys(data.errors);
  if ($.inArray('product_id', errors) >= 0) {
    $('#sale-product-label').addClass('field_with_errors');
  } else {
    $('#sale-product-label').removeClass('field_with_errors');
  }
  if ($.inArray('quantity', errors) >= 0) {
    $('#sale-quantity-label').addClass('field_with_errors');
  } else {
    $('#sale-quantity-label').removeClass('field_with_errors');
  }
}

Sale.handleResponse = function(data) {
  let respData = data;
  if ($.isEmptyObject(data.errors)) {
    Sale.success(respData);
  } else {
    Sale.failure(respData);
  }
}

Sale.formSubmitListener = function() {
  $('#new_sale').on('submit', function(e) {
    e.preventDefault();
    let $form = $(this);
    let values = $form.serialize();
    let posting = $.post('/sales', values);
    posting.success(Sale.handleResponse);
  })
}

Sale.ready = function() {
  Sale.templateSource = $('#sale-template').html();
  Sale.template = Handlebars.compile(Sale.templateSource);
  Sale.formSubmitListener();
}

$(document).on('turbolinks:load', function() {
  if ($('#sale-template').length > 0) {
    Sale.ready();
  }
})
