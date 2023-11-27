class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォローしているユーザーのuser_id
  has_many :relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  # フォロワーのuser_id
  has_many :reverse_of_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーとフォロワーの表示をするための記述↓
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def active_for_authentication?
    super && (is_withdrawal == false)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_fill: [width, height])
  end

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

  # フォローした時の処理
  def follow(user)
    self.relationships.create(followed_id: user.id)

  end
  # フォローを外す時の処理
  def  unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
  # フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end
  


  validates :name, presence: true, length: { minimum: 2 }
end
