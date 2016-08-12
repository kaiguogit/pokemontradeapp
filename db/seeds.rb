
CSV.open('./db/pokemon_names.csv').each do |row|
  Species.create(name: row[1])
end

#create user
u = User.create(username: 'test', email: "test@email.com")
#create a cart for user
u.cart.create
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
