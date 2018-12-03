class Deed < ApplicationRecord
   
    belongs_to :user 
    has_many :comments, dependent: :destroy
    has_many :funds, dependent: :destroy
    has_many :users, through: :funds

    has_many :ratings, dependent: :destroy
    has_many :users, through: :ratings


    has_many :taggings, :dependent => :destroy
    has_many :tags, through: :taggings

    has_many :uninteresteds, dependent: :destroy
    has_many :users, through: :uninterests

    has_one_attached :image
    has_one_attached :completed_image


    validates :title, presence: true, 
    uniqueness: true,
    length: { maximum: 60}
    validates :body, presence: true,
    length: { minimum: 20, maximum: 500 }
    validates :money_required, presence: true
    validates :city, presence: true

    geocoded_by :address
    after_validation :geocode
    reverse_geocoded_by :latitude, :longitude

    include AASM 
    aasm do 
        state :not_fully_funded, initial: true 
        state :fully_funded

        event :meets_required_funding do 
            transitions from: :not_fully_funded, to: :fully_funded 
        end 
    end 

    def self.viewable 
        where(assm_state: :funded)
    end 


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

    def self.uniniterested_with(name)
        Uninterested.find_by_name!(name).deeds
    end

    def address
        [city].compact.join(', ')
    end

    def percent_funded
      ((BigDecimal(funds.count)/BigDecimal(money_required))*100).floor
    end

    extend FriendlyId
    friendly_id :title, use: [:slugged, :history, :finders]
end
