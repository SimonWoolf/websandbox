class ProfilesController < ApplicationController
  helper :versions

  before_action :get_profile, only: [:show, :edit, :create, :update, :destroy, :history]
  before_filter :authenticate_user!, only: [:update, :create, :destroy]

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
    render json: {status: 'success'}
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
    if params[:user_id] # route /users/:user_id/profile
      @profile = User.find(params[:user_id]).profile
    elsif user_signed_in? # routes /profile
      @profile = current_user.profile || (current_user.profile = new_profile)
    else #guest
      @profile = new_profile
    end
  end

  def new_profile
    Profile.new(html: '<p id="test_element">Here is an editable html element</p>')
  end

  def authenticate_user!
    if editing_your_own_page?
      super
    elsif params[:user_id]
      flash[:error] = "Can only edit your own or your friends' pages"
      redirect_to user_profile_path(params[:user_id])
    end
  end

  def editing_your_own_page?
    (params[:user_id] && # routes /users/:user_id/profile
      User.find(params[:user_id]) == current_user) ||
      !params[:user_id] # route /profile
  end
end
