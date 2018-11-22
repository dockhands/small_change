class User < ApplicationRecord

   

    has_many :deeds, dependent: :destroy    
    has_secure_password 


    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, 
        uniqueness: true,
        format: VALID_EMAIL_REGEX

    def full_name
        "#{first_name.capitalize} #{last_name.capitalize}".strip
    end


    extend FriendlyId
    friendly_id :full_name, use: [:slugged, :history, :finders]

end
