class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :board

  # user_idとboard_idの組み合わせが一意であることを確認(同じuser_idとboard_idの組み合わせが複数回出現しないようにする)
  validates :user_id, uniqueness: { scope: :board_id }
end
