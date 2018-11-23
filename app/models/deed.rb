class Deed < ApplicationRecord
   
    belongs_to :user 

    has_many :funds, dependent: :destroy
    has_many :users, through: :funds



    has_one_attached :image


    validates :title, presence: true, 
    uniqueness: true,
    length: { maximum: 60}
    validates :body, presence: true,
    length: { minimum: 20, maximum: 500 }
    validates :money_required, presence: true
    validates :location, presence: true

    def funded_by?(user)
        funds.find_by_user_id(user.id).present?
    end


    extend FriendlyId
    friendly_id :title, use: [:slugged, :history, :finders]
end
