class Tag < ApplicationRecord

    has_many :taggings
    has_many :deeds, through: :taggings
end
