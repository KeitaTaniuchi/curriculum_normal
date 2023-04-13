class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :last_name, presence: true, length: { maximum: 525 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }
end
