class Organization < ApplicationRecord
  validates :name, presence: true
  validates :kind, presence: true
  validates :inn, presence: true
  validates :ogrn, presence: true
end
