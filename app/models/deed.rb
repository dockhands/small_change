class Deed < ApplicationRecord
    validates :title, presence: true, 
    uniqueness: true,
    length: { maximum: 60}
    validates :body, presence: true,
    length: { minimum: 20, maximum: 500 }
    validates :money_required, presence: true
    validates :location, presence: true





    belongs_to :user 
    has_one_attached :image

    extend FriendlyId
    friendly_id :title, use: [:slugged, :history, :finders]
end
