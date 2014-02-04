class ProfilesController < ApplicationController
  before_action :get_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.save
    redirect_to profile_path(@profile)
  end

  def update
    redirect_to profile_path(@profile)
  end

  def destroy
    @profile.destroy
    redirect_to '/'
  end

  private
  def get_profile
    if params[:id] # route /users/:user_id/profile
      @profile = User.find(params[:user_id]).profile
    elsif user_signed_in? # routes /profile
      @profile = current_user.profile
    else #guest
      @profile = User.new.profile
    end
  end

  def profile_params
    params.require(:profile).permit(:parameters_of_profile_go_here)
  end
end
