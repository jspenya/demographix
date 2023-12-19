class Offer < ApplicationRecord
  validates :title, :target_type, presence: true
end
