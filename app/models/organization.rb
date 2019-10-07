class Organization < ApplicationRecord
  validates :name, presence: true
  validates :kind, presence: true
  validates :inn, presence: true, numericality: { only_integer: true }
  validates :ogrn, presence: true, numericality: { only_integer: true }

  has_many :devices
  has_and_belongs_to_many :clients

  include PgSearch::Model
  pg_search_scope :search_by, against: %i[name inn ogrn], using: {
                                tsearch: { prefix: true },
                              }
  def self.search(query)
    return [] unless query
    search_by("#{query}")
  end
end
