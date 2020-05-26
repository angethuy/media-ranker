class IceCream < ApplicationRecord
  
  has_many :votes
  has_many :users, through: :votes

  CATEGORIES =  %w[scoop shape stick]

  validates :name, presence: true, uniqueness: {scope: :category, 
    message: "%{value} already exists in that category." }
  validates :category, presence: true, inclusion: { in: CATEGORIES,
    message: "%{value} is not a valid category" }

    

  scope :top_within_category, -> (category) { 
    where(category: category)
    .order("name ASC") #currently ordered by name
    # .where(COUNT(votes) > 0)
  }

  def self.by_category(category) 
    ice_creams_in_category = IceCream.where(category: category)
  end

end
