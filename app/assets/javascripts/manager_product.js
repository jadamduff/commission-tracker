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

ManagerProduct.loadProducts = function(products) {
  if (products.length > 0) {
    for (const product of products) {
      let productObj = new ManagerProduct(product);
      let productDiv = productObj.renderProductDiv();
      $('#manager_products_header').after(productDiv);
    }
  } else {
    let productDiv = ManagerProduct.renderEmptyProductDiv();
    $('#manager_products_header').after(productDiv);
  }
}

ManagerProduct.loadHotProducts = function() {
  let userId = $('#hot_products_container')[0].dataset.id;
  $.get('/hot_products', function(data) {
    console.log(data);
    let productsArr = data.data
    if (productsArr.length > 0) {
      for (const product of productsArr) {
        let productObj = new ManagerProduct(product.attributes.data);
        let productDiv = productObj.renderProductDiv();
        $('#hot_products_container').append(productDiv);
      }
    } else {
      let emptyDiv = ManagerProduct.renderEmptyHotProductsDiv();
      $('#hot_products_container').append(emptyDiv);
    }
  })
}

ManagerProduct.prototype.renderProductDiv = function() {
  return ManagerProduct.template(this);
}

ManagerProduct.renderEmptyProductDiv = function() {
  return ManagerProduct.emptyTemplate();
}

ManagerProduct.renderEmptyHotProductsDiv = function() {
  return ManagerProduct.emptyHotProductTemplate();
}

ManagerProduct.success = function(data) {
  console.log(data);
  let product = new ManagerProduct(data.data.attributes.data);
  let productDiv = product.renderProductDiv();
  $('#empty-manager-product-div').remove();
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
 rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
 return (rgb && rgb.length === 4) ? "#" +
  (("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
  ("0" + parseInt(rgb[3],10).toString(16)).slice(-2)).toUpperCase() : '';
}

ManagerProduct.formColorPicker = function() {
  $(document).on('click', '.color_box', function() {
    console.log('clicked');
    $('#product_color').val(ManagerProduct.rgbConverter($(this).css('background-color')));
  });
}

ManagerProduct.formSubmitListener = function() {
  $('#new_product').on('submit', function(e) {
    e.preventDefault();
    let $form = $(this);
    let values = $form.serialize();
    let posting = $.post('/products', values);
    posting.success(ManagerProduct.handleResponse);
  })
}

ManagerProduct.hotProductsReady = function() {
  ManagerProduct.emptyHotProductTemplateSource = $('#manager-hot-product-empty-template').html();
  ManagerProduct.emptyHotProductTemplate = Handlebars.compile(ManagerProduct.emptyHotProductTemplateSource);
  ManagerProduct.loadHotProducts();
}

ManagerProduct.ready = function() {
  ManagerProduct.templateSource = $('#manager-product-template').html();
  ManagerProduct.template = Handlebars.compile(ManagerProduct.templateSource);
  ManagerProduct.emptyTemplateSource = $('#manager-empty-product-template').html();
  ManagerProduct.emptyTemplate = Handlebars.compile(ManagerProduct.emptyTemplateSource);
  ManagerProduct.formColorPicker();
  ManagerProduct.formSubmitListener();
}

$(document).on('turbolinks:load', function() {
  if ($('#manager-product-template').length > 0) {
    ManagerProduct.ready();
  }
  if ($('#manager-hot-product-empty-template').length > 0) {
    ManagerProduct.hotProductsReady();
  }
})
