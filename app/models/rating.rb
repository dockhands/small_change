class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :deed

  validates :deed_id, uniqueness: {scope: :user_id}

  validates :score, {
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5
    }
  }
end
