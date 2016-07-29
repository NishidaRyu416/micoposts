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
end
