class ApplicationController < ActionController::Base

  include ApplicationHelper

  helper_method :current_user, :logged_in?, :require_login, :current_user_is_manager?, :has_employees?, :is_current_users_profile?, :is_current_users_employee?, :is_employees_manager?, :is_managers_profile?

end
