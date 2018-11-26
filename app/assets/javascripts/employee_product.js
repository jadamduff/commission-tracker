let productsSoldIds = [];

function EmployeeProduct(attributes) {
  this.id = attributes.id;
  this.color = attributes.color;
  this.title = attributes.title;
  this.numberSold = attributes['number-sold'];
  this.price = attributes.price;
  this.commission = attributes.commission;
  this.isFree = attributes['is-free'];
}

EmployeeProduct.getSoldProductsIds = function() {
  if ($('.employee_product').length > 0) {
    for (const product of $('.employee_product')) {
      productsSoldIds.push(parseInt(product.dataset.productId));
    }
  }
}

EmployeeProduct.checkEmpty = function() {
  if ($('#productsSoldEmpty').length > 0) {
    $('#productsSoldEmpty').remove();
  }
}

EmployeeProduct.prototype.updateSoldProducts = function() {
  if ($.inArray(this.id, productsSoldIds) >= 0) {
    let $productDiv = $('#employee-product-' + this.id);
    $productDiv.find('.display-number-sold').text(this.numberSold + " Sold");
  } else {
    let html = EmployeeProduct.template(this);
    $('.body_right').append(html);
  }
}

EmployeeProduct.ready = function() {
  EmployeeProduct.templateSource = $('#employee-product-template').html();
  EmployeeProduct.template = Handlebars.compile(EmployeeProduct.templateSource);
  EmployeeProduct.getSoldProductsIds();
}

$(document).on('turbolinks:load', function() {
  if ($('#employee-product-template').length > 0) {
    EmployeeProduct.ready();
  }
});
