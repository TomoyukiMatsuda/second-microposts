class Micropost < ApplicationRecord
  # userモデルとの関連付けによりユーザとの紐付けなしにはMicropostができない
  belongs_to :user

  has_many :comments
  
  has_many :favorites
  has_many :liked_users, through: :favorites, source: :user

  validates :content, presence: true, length: { maximum: 255 }
end
