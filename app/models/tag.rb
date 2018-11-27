class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :deeds, through: :taggings
end
