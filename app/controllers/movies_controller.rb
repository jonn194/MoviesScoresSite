class MoviesController < ApplicationController
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index ]
  def index
    @movies = Movie.all
  end
  def show
    @movies = Movie.find(params[:id])
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
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
    params.require(:movie).permit(:title, :description, :director, :genre, :movie_length, :rating, :user_id, :image)
  end
end
