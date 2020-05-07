class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      # usersテーブルのidとfollow_idを紐づけるよ、ってこと
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      # user_idとfollow_idが重複して保存されないようにする記述
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
