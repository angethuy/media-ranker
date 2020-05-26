class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :ice_creams, through: :votes

  validates :name, presence: true, uniqueness: true

end
