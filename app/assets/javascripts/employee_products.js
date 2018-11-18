let productsSoldIds = [];

function EmployeeProduct(attributes) {
  this.id = attributes.id;
  this.color = attributes.color;
  this.title = attributes.title;
  this.numberSold = attributes.numberSold;
  this.price = attributes.price;
  this.commission = attributes.commission;
  this.isFree = attributes.isFree;
}

EmployeeProduct.getSoldProductsIds = function() {
  if ($('.employee_product').length > 0) {
    for (const product of $('.employee_product')) {
      productsSoldIds.push(parseInt(product.dataset.productId));
    }
  }
  console.log(productsSoldIds);
}

EmployeeProduct.checkEmpty = function() {
  if ($('#productsSoldEmpty').length > 0) {
    $('#productsSoldEmpty').remove();
  }
}

EmployeeProduct.updateProductsSold = function() {
  EmployeeProduct.checkEmpty();
}
