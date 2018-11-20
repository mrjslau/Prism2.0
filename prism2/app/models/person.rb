# Person model, it has identity, location, belongings
# and criminal records
class Person < ApplicationRecord
  has_one :identity
end
