class Deed < ApplicationRecord
   
    belongs_to :user 

    has_many :funds, dependent: :destroy
    has_many :users, through: :funds

    has_many :taggings
    has_many :tags, through: :taggings
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

    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end
      
    def all_tags
        self.tags.map(&:name).join(", ")
    end

    def self.tagged_with(name)
        Tag.find_by_name!(name).deeds
    end


    extend FriendlyId
    friendly_id :title, use: [:slugged, :history, :finders]
end
