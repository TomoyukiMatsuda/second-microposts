class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 140 }
  validates :age, presence:true, length: { maximum: 3 }
  has_secure_password

  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship',foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :like_microposts, through: :favorites, source: :micropost

  # フォローする
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # アンフォローする
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  # フォローしているuserを取得
  def following?(other_user)
    self.followings.include?(other_user)
  end

  # フォローユーザ＋自分の投稿を取得
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end

  # お気に入りする
  def like(micropost)
    self.favorites.find_or_create_by(micropost_id: micropost.id)
  end

  # お気に入りを外す
  def unlike(micropost)
    favorite = self.favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end

  # お気に入り済かどうか確認する
  def already_likes?(micropost)
    self.like_microposts.include?(micropost)
  end
end
