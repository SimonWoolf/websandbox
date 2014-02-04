class ProfileController < ApplicationController
  before_action :get_profile, only: [:show, :edit, :update, :destroy, :answer]

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
    @profile = profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:parameters_of_profile_go_here)
  end
end
