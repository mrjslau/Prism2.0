class Residence < ApplicationRecord
  belongs_to :identity, optional: true
  belongs_to :building, optional: true
  validates :identity, presence: true, uniqueness: true
  validates :building, presence: true
end
