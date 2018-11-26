function ManagerEmployee(attributes) {
  this.name = attributes.name;
  this.revenue = attributes.revenue;
  this.url = attributes.url;
}

ManagerEmployee.renderEmptyEmployeeDiv = function() {
  return ManagerEmployee.emptyEmployeeTemplate();
}

ManagerEmployee.prototype.renderEmployeeDiv = function() {
  return ManagerEmployee.employeeTemplate(this);
}

ManagerEmployee.loadEmployees = function() {
  let employeeId = $('.manager-body')[0].dataset.id;
  $.get('/users/' + employeeId, function(data) {
    let employees = data.data.attributes['manager-data'].employees;
    if (employees.length > 0) {
      for (const employee of employees) {
        let employeeObj = new ManagerEmployee(employee);
        let employeeDiv = employeeObj.renderEmployeeDiv();
        $('#employee-container').append(employeeDiv);
      }
    } else {
      let emptyEmployeeDiv = ManagerEmployee.renderEmptyEmployeeDiv();
      $('#employee-container').append(emptyEmployeeDiv);
    }
  });
}

ManagerEmployee.ready = function() {
  ManagerEmployee.employeeTemplateSource = $('#manager-employee-template').html();
  ManagerEmployee.employeeTemplate = Handlebars.compile(ManagerEmployee.employeeTemplateSource);
  ManagerEmployee.emptyEmployeeTemplateSource = $('#manager-empty-employee-template').html();
  ManagerEmployee.emptyEmployeeTemplate = Handlebars.compile(ManagerEmployee.emptyEmployeeTemplateSource);
  ManagerEmployee.loadEmployees();
}

$(document).on('turbolinks:load', function() {
  if ($('#manager-employee-template').length > 0) {
    ManagerEmployee.ready();
  }
});
