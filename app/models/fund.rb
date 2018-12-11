class Fund < ApplicationRecord
  belongs_to :user
  belongs_to :deed

  #A user can only "FUND" a "DEED" once 
  validates :deed_id, uniqueness: {scope: :user_id, message: "has already been funded"}
end
