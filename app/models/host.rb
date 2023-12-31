class Host < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :guesthouse

  validates :name, :lastname, presence: true

  def description
    "#{name} #{lastname} - #{email}"
  end
end
