require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "top_session"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      # if @current_user
      #   @current_user
      # else
      #   @current_user = User.find_by(id: session[:user_id])
      # end
      @current_user ||= User.find_by(id: session[:user_id]) # => THIS DOES THE SAME THING AS THE IF-ELSE STATEMENT ABOVE, SHORTHAND NOTATION
    end
    
    def login(username, password)
      @user = User.find_by(:username => params[:username])
      if @user != nil && @user.password == params[:password]
        session[:user_id] = @user.id
        redirect to '/login'
      end
      erb :error
    end
  end


  get '/login' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb :login
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end
