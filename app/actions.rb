# Homepage (Root path)
require 'json'
before do
  if session[:user_id]
    @user = User.find(session[:user_id])
  else
    @user = User.new
    @user.cart = Cart.new 
    session[:user_id] = @user_id
  end
  # if loggedin?
  #   @cart = User.find(session[:user_id]).cart
  # else
  #   begin
  #     @cart = Cart.find(session[:cart_id])
  #   rescue ActiveRecord::RecordNotFound
  #     c = Cart.create
  #     session[:cart_id] = c.id
  #   end
  # end
end

helpers do 
  def loggedin?
    session[:user_id]
  end
end

# Home page
# TODO make a real home page with nice backgound picture, and sign up form, log in, to listings, BONUS play music 

get '/' do
  erb :index
end

# User log in. starts user session. 

post '/login' do 
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    @username = user.username
    redirect '/pokedex#pokedex'
  else
    flash[:notice] = "Username or password you entered is not correct."
    redirect '/'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/profile' do
  @user = User.find(session[:user_id])
  if @user
    erb :'/users/profile'
  else
    redirect '/'
  end
end

get '/profile/wishlist' do
  erb :'users/wishlist'
end

get '/profile/tradelist' do
  erb :'users/tradelist'
end

post '/listings' do
  # flash[:keyword] = params[:keyword]
  redirect "/listings?keyword=#{params[:keyword]}"
end

get '/listings' do
  erb :'listings/index', locals: {keyword: params[:keyword], show_all: "false"}
end

get '/pokedex' do
  erb :'pokemons/pokedex'
end

get '/pokemon/add/:id' do
  # if loggedin?  
    @species = Species.find(params[:id])
     erb :'pokemons/add'
  # else
  #   flash[:notice] = 'Please log in to add pokemon to your profile'
  #   redirect '/pokedex'
  # end
end

# post '/pokemon/add/submit' do
#   @new_pokemon = Pokemon.new(
#     user: User.find(params[:user_id]),
#     species: Species.find(params[:species_id]), 
#     name: params[:name], 
#     cp: params[:cp], 
#     quick_move: Move.find_by(name: params[:quick_move]),
#     charge_move: Move.find_by(name: params[:charge_move]) 
#     )
#   @new_pokemon.save
#   redirect '/pokedex'
# end 

# # button from pokedex, to add to wishlist 

# post '/pokemon/wish_list' do
#   if loggedin?
#     pokemon = Pokemon.new
#     pokemon.user_wish_list = UserWishList.find_by(user_id: session[:user_id])
#     pokemon.species = Species.find(params[:id])
#     pokemon.save   
#   else
#     flash[:notice] = 'Please log in to add pokemon to your wish list'    
#   end
#   redirect '/pokedex'
# end 

post '/listings/add_to_cart' do 
  listings = @user.cart.listings
  if listings.select{|l|l.id.to_s == params[:listing_id]}.empty?
    @user.cart.listings << Listing.find(params[:listing_id])
    redirect '/carts'
  else
    redirect '/listings'    
  end

end

delete '/cart/listing' do
  @cart.listings.delete(Listing.find(params[:listing_id]))
  redirect :'/carts/show'
end

get '/carts' do
  @cart = @user.cart 
  erb :'/carts/show'
end

# post '/checkout' do
#   binding.pry
#   listing = Listing.find(params[:listing_id])
#   seller = listing.user 
#   seller_pokemon = listing.pokemon
#   buyer = User.find(params[:buyer_id])
#   price = listing.price
#   # buyer_pokemon = Pokemon.find(params[:buyer_pokemon_id])


#   if buyer.wallet >= price
#     buyer.wallet -= price
#     buyer.save
#     seller.wallet += price
#     seller.save
#     seller_pokemon.user = buyer 
#     seller_pokemon.save
#     # buyer_pokemon.user = seller
#     listing.status = 'completed' 
#     listing.save
#     result = listing.attributes
#     result["message"]="Success"
#     json result
#     # redirect '/carts'
#   else #transaction failed
#     # do something
#   end
# end