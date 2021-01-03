class UsersController < ApplicationController
  # already added to config.ru

  # Signup

  # load form
  get '/signup' do
    erb :'/users/new'
  end

  # process form + create user
  post '/signup' do
    # creating the user AND logging them in
    # if username or pw empty
    user = User.new(params[:user])
    if user.save
      # redirect
      session[:user_id] = user.id # if true, then login user
      redirect to "/users/#{user.id}"
    else      
      # binding.pry
      @errors = user.errors.full_messages.join(" - ")
      erb :"users/new" # if false, then render instead of redirect so that you don't loose access to the error instances
    end
  end

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    # binding.pry
    if user && user.authenticate(params[:user][:password])
      # log them in
      session[:user_id] = user.id
      # redirect
      redirect to "/phones"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users' do 
    redirect to "/users/#{current_user.id}"
  end

  get '/users/:id/edit' do
    @user = User.find(params[:id])
    erb :'/users/edit'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  patch '/users/:id/edit' do
    @user = User.find(params[:id])
    @user.update(params[:user])
    redirect "/users/#{@user.id}"
  end
end