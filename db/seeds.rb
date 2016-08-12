
CSV.open('./db/pokemon_names.csv').each do |row|
  Species.create(name: row[1])
end

CSV.open('./db/charge_moves.csv').each do |row|
  Move.create(name: row[0], move_type: 'charge_move')
end

CSV.open('./db/quick_moves.csv').each do |row|
  Move.create(name: row[0], move_type: 'quick_move')
end

u = User.create(username: 'test', email: "test@email.com")
u.password = 'test'
u.save

u.pokemons.create(name:"Pikachu", cp: 100, species: Species.find_by(name: 'Pikachu'))
u.pokemons.create(name:"Wartortle", cp: 50, species: Species.find_by(name: 'Wartortle'))



l =  Listing.new
l.pokemon = Pokemon.first
l.pokemon_trade = Pokemon.last
l.price = 1000
l.save


l =  Listing.new
l.pokemon = Pokemon.last
l.pokemon_trade = Pokemon.first
l.price = 2000
l.save



