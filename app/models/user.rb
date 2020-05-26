class User < ApplicationRecord
  has_many :votes
  has_many :ice_creams, through: :votes

  validates :name, presence: true, uniqueness: true

end
