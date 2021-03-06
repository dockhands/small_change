class User < ApplicationRecord
    has_many :deeds, dependent: :destroy    
    has_many :funds, dependent: :destroy
    has_many :funded_deeds, through: :funds, source: :deed 
    has_many :comments, dependent: :destroy
    has_secure_password 
    has_one_attached :image

    has_many :uninteresteds, dependent: :destroy
    has_many :unintereseted_deeds, through: :uninteresteds, source: :deed

    has_many :ratings, dependent: :destroy
    has_many :rated_deeds, through: :ratings, source: :deed

    geocoded_by :address
    after_validation :geocode
    reverse_geocoded_by :latitude, :longitude

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :username, presence: true, uniqueness: true
    validates :wallet, presence: true
    validates :city, presence: true

    validates :email, presence: true, 
        uniqueness: true,
        format: VALID_EMAIL_REGEX

    def full_name
        "#{first_name.capitalize} #{last_name.capitalize}".strip
    end

    def address
        [city].compact.join(', ')
    end


    extend FriendlyId
    friendly_id :full_name, use: [:slugged, :history, :finders]

end
