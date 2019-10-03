class Hardware < ApplicationRecord
  validates :name, presence: true
  validates :kind, presence: true
  validates :number, presence: true,
                     numericality: { only_integer: true },
                     uniqueness: { case_sensitive: false }

  belongs_to :organization, required: false
end
