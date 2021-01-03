class SessionsController < ApplicationController

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    binding.pry
    if user
      # log them in
      # redirect
    else

    end
  end

  get '/logout' do
    session.clear
  end

end