class PhonesController < ApplicationController
  
  # New - loads a form
  get '/phones/new' do
    erb :"phones/new"
  end

  # Create - processes the form and creates a phone
  post '/phones' do
    # binding.pry
    phone = current_user.phones.create(params) # all keys in params hash match column name, so you can check this line in binding.pry 
    redirect "/phones" # only get requests will render views directly
  end

  # Index - loads all the phones
  get '/phones' do
    @phones = Phone.all
    erb :"phones/index"
  end

  # Show - get details on individual phone
  get '/phones/:id' do
    @phone = Phone.find_by(id: params[:id]) #params hash is only accessible in controllers
    if @phone
      erb :"phones/show"
    else
      redirect "/phones"
    end
  end
  
  # Edit - loading a form to edit a phone
  get '/phones/:id/edit' do
    @phone = Phone.find_by(id: params[:id])
    # binding.pry
    if @phone.user == current_user
      erb :"phones/edit"
    else
      redirect to "/phones"
    end
  end

  # Update
  patch "/phones/:id/edit" do
    @phone = Phone.find_by(id: params[:id])
    @phone.update(params[:phone])
    redirect to "/phones/#{@phone.id}"
  end

  # Delete
  delete "/phones/:id" do
    @phone = Phone.find_by(id: params[:id])
    @phone.destroy
    redirect to "/phones"
  end
end