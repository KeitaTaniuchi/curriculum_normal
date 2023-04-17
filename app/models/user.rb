class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  # sorceryの公式ドキュメントに書かれているバリデーション
  # https://github.com/Sorcery/sorcery/wiki/Simple-Password-Authentication
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
