class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :fullname, presence: true, length: { minimum: 5 }
  validates :phone, presence: true,
                    numericality: { only_integer: true },
                    uniqueness: { case_sensitive: false }
end
