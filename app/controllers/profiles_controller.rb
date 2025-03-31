class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    @profiles = Profile.all
  end

  def show
    @profiles = Profile.find(params[:id])
    @profile = current_user.profile
  end

  def new
    @profile = Profile.new
  end

  def edit
    @profile = current_user.profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    @profile.username = current_user.id

    if @profile.save
      redirect_to @profile, notice: "Profile was successfully created"
    else
      render :new
    end
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile was successfully updated"
    end
  end

  def destroy
    @profile.destroy
    redirect_to "home#index"
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:username, :favourite_movie, :favourite_genre, :user_id, :image)
  end
end
