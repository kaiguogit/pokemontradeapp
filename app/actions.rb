# Homepage (Root path)

before do
  if loggedin?
    @cart = User.find(session[:user_id]).cart
  else
    session[:cart_id] ||= Cart.create
    @cart = Cart.find(session[:cart_id])
  end
end

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


post '/profile/add_pokemon' do
  # @new_pokemon = Pokemon.new (name: params[:name], cp: params[:cp],)
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

