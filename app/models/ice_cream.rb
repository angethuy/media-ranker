class IceCream < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  CATEGORIES =  %w[scoop shape stick]

  scope :top_within_category, -> (category) { 
    where(category: category)
    .order("name ASC") #currently ordered by name
    # .where(COUNT(votes) > 0)
  }

end
