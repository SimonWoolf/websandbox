class ProfilesController < ApplicationController
  helper :versions

  before_action :get_profile, only: [:show, :edit, :create, :update, :destroy, :history]

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
    @profile.save
    redirect_to profile_path(@profile)
  end

  def update
    @profile.update(params[:profile].permit(:html))
    redirect_to profile_path(@profile)
  end

  def destroy
    @profile.destroy
    redirect_to '/'
  end

  def history
    @versions = @profile.versions
  end

  private
  def get_profile
    if params[:id] # route /users/:user_id/profile
      @profile = User.find(params[:user_id]).profile
    elsif user_signed_in? # routes /profile
      @profile = current_user.profile || (current_user.profile = new_profile)
    else #guest
      @profile = new_profile
    end
  end

  def new_profile
    Profile.new(html: '<p>Here is an editable html element</p>')
  end

end
