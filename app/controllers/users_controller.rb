class UsersController < ApplicationController

  get '/create_user' do 
    erb :'/users/signup'
  end
  
  get '/login' do
    erb :'/users/login'
  end
  
  post '/users/login' do 
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id 
      redirect "/users/#{@user.id}"
    else
      redirect '/users/login'
    end
  end
  
  get '/users/:id' do 
    @user = User.find_by_id(params[:id])
    erb :"/users/show"
  end
  
  post '/users' do 
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id

      redirect to "/users/#{@user.id}"
    else
      redirect to '/create_user'
    end
  end
  
  get '/logout' do
    session.clear
    redirect '/'
  end
end