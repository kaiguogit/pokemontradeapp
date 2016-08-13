require 'json'

namespace '/api' do
  get '/user/:user_id/wishlist' do

    user = User.find(params[:user_id])

    species_array = user.user_wish_list.pokemons.map{|p| 
      puts p.id
      puts p.name
      puts p.species
      p.species.id.to_s}
    json species_array
  end

  post '/user/:user_id/wishlist' do
    user = User.find(params[:user_id])
    species_array = user.user_wish_list.pokemons.map{|p|p.species.id.to_s}
    species_id = params[:species_id]
    if species_array.include?(species_id)
      user.user_wish_list.pokemons = user.user_wish_list.pokemons.reject{|pokemon| pokemon.species.id.to_s == params[:species_id]}
    else
      user.user_wish_list.pokemons << Pokemon.create(species: Species.find(params[:species_id]))
    end
    user.save
    species_array = user.user_wish_list.pokemons.map{|p|p.species.id.to_s}
    json species_array
  end
end