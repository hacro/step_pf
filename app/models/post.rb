class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :spot_types, dependent: :destroy

    validates :location, presence: true
end
