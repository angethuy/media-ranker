class Vote < ApplicationRecord
  belongs_to :ice_cream, counter_cache: true
  belongs_to :user

  def get_user
    return User.find_by(id: user_id)
  end

  def get_ice_cream
    ice_cream = IceCream.find_by(id: ice_cream_id)
    return ice_cream ? ice_cream : "nil"
  end
end
