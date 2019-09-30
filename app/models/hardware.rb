class Hardware < ApplicationRecord
  validates :name, presence: true
  validates :kind, presence: true
  validates :number, presence: true, numericality: { only_integer: true }

  has_many :organizations
end
