class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :deed

  validates :deed_id, uniqueness: {scope: :user_id}
end
