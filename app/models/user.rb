
class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :location, absence: true,
                       on: :create
  validates :location, allow_blank: true, 
                       length: { minimum: 2, maximum: 20 }, 
                       on: :update
                       
  validates :profile, absence: true, #入力を許さない
                       on: :create
  validates :profile, allow_blank: true,  #空文字のときバリデーションスキップ
                       length: { minimum: 2, maximum: 100 }, 
                       on: :update
                       
  has_secure_password
  
  has_many :microposts
  
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
<<<<<<< HEAD
  
  #つぶやき取得
=======
>>>>>>> c10986ae3dac31e4d50560afb8fcde3451dc2d7e
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end

