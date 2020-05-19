class AddForeignKeysToVotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :ice_cream, foreign_key: true
    add_reference :votes, :user, foreign_key: true
  end
end
