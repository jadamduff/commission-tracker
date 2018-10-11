class ManagerEmployee < ApplicationRecord
  belongs_to :user
  belongs_to :employee, :class_name => "User"
end
