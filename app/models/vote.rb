class Vote < ApplicationRecord
  belongs_to :ice_cream, counter_cache: true
  belongs_to :user
end
