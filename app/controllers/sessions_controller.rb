class SessionsController < ApplicationController

  get '/login' do
    erb :"sessions/new"
  end

  post '/sessions' do
    session[:username] = params[:username]
    redirect '/posts'
  end

  get '/logout' do
    session.clear
  end

end