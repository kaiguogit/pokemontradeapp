# Homepage (Root path)
get '/' do
  erb :index
end

post '/login' do 
  user = User.find_by(username: params[:username])
  if user.password == params[:password]
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
