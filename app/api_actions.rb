require 'json'

namespace '/api' do
  namespace '/user/:user_id' do

    get '/wishlist' do

      user = User.find(params[:user_id])

      species_array = user.user_wish_list.pokemons.map{|p| 
        puts p.id
        puts p.name
        puts p.species
        p.species.id.to_s}
      json species_array
    end

    post '/wishlist' do
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

    post '/pokemons' do

      @new_pokemon = Pokemon.new(
        user: User.find(params[:user_id]),
        species: Species.find(params[:species_id]), 
        name: params[:name], 
        cp: params[:cp], 
        quick_move: Move.find_by(name: params[:quick_move]),
        charge_move: Move.find_by(name: params[:charge_move]) 
        )
      @new_pokemon.save
      json @new_pokemon.attributes
    end

    delete '/pokemons' do
      p = Pokemon.find(params[:pokemon_id])
      p.user = nil
      p.save
      user = User.find(params[:user_id])
      pokemon_array = user.pokemons.map{|p|p.id.to_s}
      json pokemon_array
    end

    put '/pokemons' do
      pokemon = Pokemon.find(params[:pokemon_id])
      pokemon.name = params[:name]
      pokemon.cp = params[:cp]
      pokemon.quick_move = Move.find_by(name: params[:quick_move])
      pokemon.charge_move = Move.find_by(name: params[:charge_move])

      pokemon.save
      result = pokemon.attributes
      result["quick_move"] = pokemon.quick_move ? pokemon.quick_move.name : ""
      result["charge_move"] = pokemon.charge_move ? pokemon.charge_move.name : ""
      json result
    end

    post '/listings' do
      if loggedin?
        user = User.find(params[:user_id])
        if user.listings.select{|l|l.pokemon.id.to_s == params[:pokemon_id]}.empty?
          listing = Listing.new()
          listing.pokemon = Pokemon.find(params[:pokemon_id])
          listing.wishlist = Wishlist.new()
          listing.user = user
          if params[:wish_list] && params[:wish_list].is_a?(Array)
            params[:wish_list].each do |p_id|
              listing.wishlist.pokemons << Pokemon.create(species: Species.find(p_id))
            end
          end

          listing.price = params[:price] || "0"
          if listing.save
            puts "successfully saved listing"
            json listing.attributes
          else
            puts "failed to save listing"
            json({message: "failed to save listing"})
          end
        else
          json({message: "This pokemon is already listed in trade listing"})
        end
      else
        flash[:notice] = "Please Login or register to proceed."
        json({message: "Please Login or register to proceed."})
      end
    end

    delete '/listings'do
      Listing.destroy(params[:listing_id])
      user = User.find(params[:user_id])
      listings = user.listings.map{|l|l.id.to_s}
      json listings
    end

    post '/checkout'do
      if loggedin?
        listing = Listing.find(params[:listing_id])
        seller = listing.user 
        seller_pokemon = listing.pokemon
        buyer = User.find(params[:buyer_id])
        price = listing.price
        # buyer_pokemon = Pokemon.find(params[:buyer_pokemon_id])


        if buyer.wallet >= price
          buyer.wallet -= price
          buyer.save
          seller.wallet += price
          seller.save
          seller_pokemon.user = buyer 
          seller_pokemon.save
          # buyer_pokemon.user = seller
          listing.status = 'completed' 
          listing.save
          result = listing.attributes
          result["message"]="Success"
          json result
        else #transaction failed
          # do something
          result = {}
          result["message"]="You are out of money"
          json result
        end
      else
        flash[:notice] = "Please Login or register to proceed."
        json({message: "Please Login or register to proceed."})
      end
    end

    post '/checkout_with_pokemon' do
      if loggedin?
        listing = Listing.find(params[:listing_id])
        seller = listing.user 
        seller_pokemon = listing.pokemon
        buyer = User.find(params[:buyer_id])
        buyer_pokemon = Pokemon.find(params[:buyer_pokemon_id])
        buyer_pokemon.user = seller
        buyer_pokemon.save
        seller_pokemon.user = buyer 
        seller_pokemon.save
        # buyer_pokemon.user = seller
        listing.status = 'completed' 
        listing.save
        result = listing.attributes
        result["message"]="Success"
        json result
      else
        flash[:notice] = "Please Login or register to proceed."
        json({message: "Please Login or register to proceed."})
      end
    end
  end

end