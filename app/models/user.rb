class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :avatar, AvatarUploader

  has_many :boards, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  # throughオプションによりbookmark_boards経由でboardsにアクセスできるようになる
  # 「@user.bookmark_boards」のように記述できる
  # user.bookmarks.map(&:board)と同じ意味
  has_many :bookmark_boards, through: :bookmarks, source: :board

  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  # sorceryの公式ドキュメントに書かれているバリデーション
  # https://github.com/Sorcery/sorcery/wiki/Simple-Password-Authentication
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def own?(object)
    id == object.user_id
  end

  # bookmark_boardsに引数のboardが含まれているかを返す
  def bookmark?(board)
    bookmark_boards.include?(board)
  end

  # cuurent_userがブックマークしているboardの配列に引数のboardを入れる
  def bookmark(board)
    bookmark_boards << board
  end

  # 引数のboardのidをもつbookmarkをbookmark_boardsから削除する
  def unbookmark(board)
    bookmark_boards.destroy(board)
  end
end
