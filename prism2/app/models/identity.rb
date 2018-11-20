# Identity model, it has personal code as primary key
class Identity < ApplicationRecord
  belongs_to :person
end
