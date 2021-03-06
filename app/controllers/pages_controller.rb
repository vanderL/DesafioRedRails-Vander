class PagesController < ApplicationController
  def index
  end

  def home
    following = Array.new
      for @f in current_user.following do
        following.push(@f.id)
      end
  
      @posts = Post.where("user_id IN (?)", following)
    @newPost = Post.new
  end

  def profile
   # grab the username from the URL as :id
    if (User.find(params[:id]))
      @username = User.find(params[:id])
    else 
      # redirect to 404 (root for now)
      redirect_to root_path, :notice=> "User not found!" 
    end
    @posts = Post.all.where("user_id = ?", User.find(params[:id]))
    @newPost = Post.new
    @toFollow = User.all.last(5)
  end

  def explore
     @posts = Post.all
     @newPost = Post.new
     @toFollow = User.all.last(5)
  end
end
