# Homepage (Root path)
get '/' do
  erb :index
end

post '/login' do 
  user = User.find_by(username: params[:username])
  if user.password == params[:password]
    session[:user_id] = user.id
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