class PostsController < ApplicationController

  # get '/posts' do
  #   "You are logged in as #{session[:username]}"
  # end
  
  # post '/sessions' do
  #   session[:username] = params[:username]
  #   redirect '/posts'
  # end

  get '/posts' do
    "A list of publicly available posts"
  end

  get '/posts/new' do
    # Checking if they are logged in
    if !logged_in?
      redirect "/login" # Redirecting if they aren't
    else
      "A new post form" # rendering if they are
    end
  end

  get 'posts/:id/edit' do
    # Checking if they are logged in
    if !logged_in?
      redirect "/login" # Redirecting if they aren't
    else
      # how do I find the post that only the author user is allowed to edit
      post = Post.find(params[:id])
      if post.user_id == current_user.id
        "An edit post form #{current_user.id} is editing #{}" # rendering if they are
      else
          redirect '/posts'
      end
    end
  end
end