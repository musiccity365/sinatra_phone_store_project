class UsersController < ApplicationController

  get '/users' do
    @users = user.all
    erb :'/users/index'
  end

  get '/users/new' do
    @phones = Phone.all
    erb :'/users/new'
  end

  post '/users' do
    @user = User.create(params[:user])
    if !params["phone"]["name"].empty?
      @user.phones << Phone.create(name: params["phone"]["name"])
      # When using the shovel operator, ActiveRecord instantly fires update SQL
      # without waiting for the save or update call on the parent object,
      # unless the parent object is a new record.
    end
    redirect "/users/#{@user.id}"
  end

  get '/users/:id/edit' do
    @user = User.find(params[:id])
    @phones = Phone.all
    erb :'/users/edit'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  patch '/users/:id' do
    @user = User.find(params[:id])
    @user.update(params[:user])

    if !params["phone"]["name"].empty?
      @user.phones << Phone.create(name: params["phone"]["name"])
    end

    redirect "/users/#{@user.id}"
  end
end