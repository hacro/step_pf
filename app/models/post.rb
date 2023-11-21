class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    belongs_to :spot_type
    has_many :favorites, dependent: :destroy

    validates :location, presence: true

    def get_image(width,height)
        image.variant(resize_to_limit: [width, height])
    end
    def favorited_by(user)
        favorites.exsits?(user_id: user.id)
    end
end
