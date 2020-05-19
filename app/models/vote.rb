class Vote < ApplicationRecord
  belongs_to :ice_cream
  belongs_to :user
end
