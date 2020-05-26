class IceCream < ApplicationRecord
  
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  CATEGORIES =  %w[scoop shape stick]

  validates :name, presence: true, uniqueness: {scope: :category, 
    message: "%{value} already exists in that category." }
  validates :category, presence: true, inclusion: { in: CATEGORIES,
    message: "%{value} is not a valid category" }

  scope :by_category, -> (category) {
      where(category: category).
      order('id ASC')
  }

  scope :ranked_within_category, -> (category) { 
    where(category: category).
    order('votes_count DESC')
  }

  scope :topmost, -> { order('votes_count DESC').first }

end
