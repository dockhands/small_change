class Tagging < ApplicationRecord
  belongs_to :deed
  belongs_to :tag
end
