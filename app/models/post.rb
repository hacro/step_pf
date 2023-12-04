class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    belongs_to :spot_type
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :location, presence: true

    def get_image(width,height)
        image.variant(resize_to_limit: [width, height])
    end
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end

    def self.search(search)
        if search != ""
            Post.where('location LIKE(?)', "%#{search}%")
        else
            Post.includes(:user)
        end
    end

    def self.favorited_posts(user)
        includes(:favorites)
        where(favorites: {user_id: user.id})
        order(created_at: :desc)
    end
end
