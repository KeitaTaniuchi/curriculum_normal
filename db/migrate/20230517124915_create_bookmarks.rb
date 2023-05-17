class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true

      t.timestamps
    end
    # bookmarksテーブルのuser_idとboard_idの組み合わせに対して一意性制約を追加するためのインデックスを作成
    add_index  :bookmarks, [:user_id, :board_id], unique: true
  end
end
