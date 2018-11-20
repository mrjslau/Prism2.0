# All our models inherit from ApplicationRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
