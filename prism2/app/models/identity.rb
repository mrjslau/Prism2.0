# Identity model, it has personal code as primary key
class Identity < ApplicationRecord
  has_many :criminal_records
  belongs_to :person
end
