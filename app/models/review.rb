class Review < ApplicationRecord
  belongs_to :booking 
  has_one :guest, through: :booking
  has_one :guesthouse, through: :booking

  validates :rating, :comment, presence: true
end
