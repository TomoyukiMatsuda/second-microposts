class Relationship < ApplicationRecord
  belongs_to :user # , class_name: 'User' が省略されてる
  # Usersテーブルのfollow_idと紐づける記述
  belongs_to :follow, class_name: 'User'
end
