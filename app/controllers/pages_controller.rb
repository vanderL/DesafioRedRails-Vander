class PagesController < ApplicationController
  def index
  end

  def home
  end

  def profile
   # grab the username from the URL as :id
    if (User.find(params[:id]))
      @username = User.find(params[:id])
    else 
      # redirect to 404 (root for now)
      redirect_to root_path, :notice=> "User not found!" 
    end
    
  end

  def explore
  end
end
