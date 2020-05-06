class Micropost < ApplicationRecord
  # userモデルとの関連付けによりユーザとの紐付けなしにはMicropostができない
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }
end
