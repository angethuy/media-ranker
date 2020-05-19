require 'csv'

ICE_CREAM_FILE = Rails.root.join('db', 'seed_data', 'ice_cream_seeds.csv')
puts "Loading raw ice cream data from #{ICE_CREAM_FILE}"

ice_cream_failures = []
CSV.foreach(ICE_CREAM_FILE, :headers => true) do |row|
  ice_cream = IceCream.new
  ice_cream.id = row['id']
  ice_cream.name = row['name']
  ice_cream.category = row['category']
  ice_cream.brand = row['brand']
  ice_cream.base_flavor = row['base_flavor']
  ice_cream.description = row['description']
  successful = ice_cream.save
  if !successful
    ice_cream_failures << ice_cream
    puts "Failed to save ice cream: #{ice_cream.inspect}"
  else
    puts "Created ice cream: #{ice_cream.inspect}"
  end
end

puts "Added #{IceCream.count} ice_cream records"
puts "#{ice_cream_failures.length} ice_creams failed to save"



USER_FILE = Rails.root.join('db', 'seed_data', 'user_seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.id = row['id']
  user.name = row['name']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"



VOTE_FILE = Rails.root.join('db', 'seed_data', 'votes_seeds.csv')
puts "Loading raw vote data from #{VOTE_FILE}"

vote_failures = []
CSV.foreach(VOTE_FILE, :headers => true) do |row|
  vote = Vote.new
  vote.id = row['id']
  vote.value = row['value']
  vote.ice_cream_id = row['ice_cream_id']
  vote.user_id = row['user_id']
  
  successful = vote.save
  if !successful
    vote_failures << vote
    puts "Failed to save vote: #{vote.inspect}"
  else
    puts "Created vote: #{vote.inspect}"
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
