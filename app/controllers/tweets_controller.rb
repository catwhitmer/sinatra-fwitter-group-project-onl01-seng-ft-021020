class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :tweets
    else
      redirect to "/users/login"
    end
  end
  
  get '/tweets/new' do 
    erb :'/tweets/new'
  end
  
  post '/tweets' do 
    if logged_in?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect :'tweets/new'
    end
  end
  
  get '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show'
  end
  
  get '/tweets/:id/edit' do 
    @tweet = Tweet.find_by_id(params[:id])
      if logged_in?
        erb :'/tweets/edit'
      else 
        redirect :'/users/login'
      end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
      if logged_in? && !params[:content].empty?
        @tweet.update(content: params[:content])
      
        redirect "/tweets/#{@tweet.id}"
      else 
        redirect :'/'
    end
  end
  
  delete '/tweets/:id' do
    if logged_in? && current_user
    @tweet = Tweet.find_by_id(params[:id])
      if @tweet.destroy
        redirect '/tweets'
      else 
        redirect '/tweets'
      end
    end
  end
end