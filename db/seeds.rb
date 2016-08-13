
CSV.open('./db/pokemon_names_with_type.csv').each do |row|
  s = Species.new(name: row[1])
  types = row[2].split(",").map{ |t| t.scan(/\w+/)[0]}
  types.each do |type|
    Type.create(name: type)
    s.types << Type.find_by(name: type)
  end
  s.save
end

CSV.open('./db/charge_moves.csv').each do |row|
  Move.create(name: row[0], move_type: 'charge_move')
end

CSV.open('./db/quick_moves.csv').each do |row|
  Move.create(name: row[0], move_type: 'quick_move')
end


#create user
u = User.create(username: 'test', email: "test@email.com")
# create user wish list for user 
u.user_wish_list = UserWishList.new 
u.user_wish_list.pokemons << Pokemon.create(species: Species.find(1))
u.user_wish_list.pokemons << Pokemon.create(species: Species.find(2))
u.save

#create a cart for user
u.cart = Cart.create
u.password = 'test'
u.save

u.pokemons.create(name:"Pikachu", cp: 100, species: Species.find_by(name: 'Pikachu'))
u.pokemons.create(name:"Wartortle", cp: 50, species: Species.find_by(name: 'Wartortle'))


def randmonlize
  (1..151).to_a.sample
end 
def randmonlize_price
  (500..3000).to_a.sample
end

l =  Listing.new
l.pokemon = Pokemon.first
l.wishlist = Wishlist.create
l.wishlist.pokemons << Pokemon.create(species: Species.find(10))
l.wishlist.pokemons << Pokemon.create(species: Species.find(151))
l.wishlist.pokemons << Pokemon.create(species: Species.find(50))
l.wishlist.pokemons << Pokemon.create(species: Species.find_by(name: 'Wartortle'))
l.wishlist.save
l.price = 1000
l.save


l =  Listing.new
l.pokemon = Pokemon.last
l.wishlist = Wishlist.create
l.wishlist.pokemons << Pokemon.create(species: Species.find(33))
l.wishlist.pokemons << Pokemon.create(species: Species.find(48))
l.wishlist.pokemons << Pokemon.create(species: Species.find(77))
l.wishlist.save
l.price = 2000
l.save

10.times do 
  l =  Listing.new
  l.pokemon = Pokemon.create(species: Species.find(randmonlize))
  l.wishlist = Wishlist.create
  l.wishlist.pokemons << Pokemon.create(species: Species.find_by(name: "Pikachu"))
  4.times do 
    l.wishlist.pokemons << Pokemon.create(species: Species.find(randmonlize))
  end
  l.price = randmonlize_price
  l.save
end


