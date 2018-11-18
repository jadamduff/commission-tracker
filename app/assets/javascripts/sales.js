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

Sale.formSubmitListener = function() {
  $(document).on('submit', '#new_sale', function(e) {
    e.preventDefault();
    let $form = $(this);
    let values = $form.serialize();
    let posting = $.post('/sales', values);

    posting.success(Sale.success);
  })
}

Sale.prototype.renderSaleDiv = function() {
  return Sale.template(this);
}

Sale.success = function(data) {
  console.log(data);
  let sale = new Sale(data.data.attributes.data.sale);
  console.log(sale);
  let saleDiv = sale.renderSaleDiv();
  $('#sales_header').after(saleDiv);
}

Sale.ready = function() {
  Sale.templateSource = $('#sale-template').html();
  Sale.template = Handlebars.compile(Sale.templateSource);
  Sale.formSubmitListener();
}

$(function() {
  Sale.ready();
})
