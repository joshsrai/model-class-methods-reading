class PostsController < ApplicationController
  # helper_method :params

  def index
    # provide a list of authors to the view for the filter control
    @authors = Author.all
  
    # filter the @posts list based on user input
    if !params[:author].blank?
      @posts = Post.by_author(params[:author])
      # @posts = Post.where(author: params[:author])
      # moved to parts of it to def self.by_author app/models/post.rb
    elsif !params[:date].blank?
      if params[:date] == "Today"
        @posts = Post.from_today
        # @posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
        # moved to def self.from_today app/models/post.rb
      else
        @posts = Post.old_news
        # @posts = Post.where("created_at <?", Time.zone.today.beginning_of_day)
        # moved to def self.old_news app/models/post.rb
      end
    else
      # if no filters are applied, show all posts
      @posts = Post.all
    end
  end 

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end
