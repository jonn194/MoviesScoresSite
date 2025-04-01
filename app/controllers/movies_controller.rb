class MoviesController < ApplicationController
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    # @movies = Movie.all
    @movies = Movie.search_by_title(params[:search])

    @movies.each do |m|
      unless m.reviews.blank?
        tempRating = 0
        m.reviews.each do |r|
          tempRating += r.rating
        end
        m.rating = tempRating/m.reviews.size
      end
    end
  end
  def show
    @movie = Movie.find(params[:id])
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
    @users = User.all

    unless @reviews.blank?
      tempRating = 0
      @reviews.each do |r|
        tempRating += r.rating
      end
      @movie.rating = tempRating/@reviews.size
    end
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if movie_params[:image].blank?
      @movie.errors.add(:base, "Please upload an image")
      render :new
    else
      if @movie.save
        redirect_to @movie, notice: "Movie was successfully created"
      else
        render :new
      end
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated"
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :director, :genre, :movie_length, :rating, :user_id, :image, :search)
  end
end
