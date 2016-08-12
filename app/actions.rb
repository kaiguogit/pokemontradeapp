# Homepage (Root path)

# before do
#   if loggedin?
#     @cart = User.find(session[:user_id]).cart
#   else
#     begin
#       @cart = Cart.find(session[:cart_id])
#     rescue ActiveRecord::RecordNotFound
#       c = Cart.create
#       session[:cart_id] = c.id
#     end
#   end
# end

helpers do 
  def loggedin?
    session[:user_id]
  end
end

get '/' do
  erb :index
end

post '/login' do 
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    @username = user.username
    redirect '/profile'
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

post '/search' do
  # flash[:keyword] = params[:keyword]
  redirect "/search?keyword=#{params[:keyword]}"
end

get '/search' do
  erb :'listings/index', locals: {keyword: params[:keyword], show_all: "false"}
end

get '/pokedex' do
  erb :'pokemons/pokedex'
end

get '/pokemon/add/:id' do
  @species = Species.find(params[:id])
  erb :'pokemons/add'
end

post '/pokemon/add/submit' do
  @new_pokemon = Pokemon.new(
    user: User.find(params[:user_id]),
    species: Species.find(params[:species_id]), 
    name: params[:name], 
    cp: params[:cp], 
    quick_move: Move.find_by(name: params[:quick_move]),
    charge_move: Move.find_by(name: params[:charge_move]) 
    )
  @new_pokemon.save
  redirect '/pokedex'
end 

post '/pokemon/wishlist' do

end



post '/profile/wish_list' do

end 

post '/listings/add_to_cart' do 
  @cart.listings << Listing.find(params[:listing_id])
  redirect '/carts/show'
end

delete '/cart/listing' do
  @cart.listings.delete(Listing.find(params[:listing_id]))
  redirect :'/carts/show'
end

get '/carts/show' do
  erb :'/carts/show'
end

