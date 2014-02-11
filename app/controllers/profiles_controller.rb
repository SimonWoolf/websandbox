class ProfilesController < ApplicationController
  helper :versions

  before_action :get_profile, only: [:show, :edit, :create, :update, :destroy, :history]
  before_filter :authenticate_user!, only: [:create, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
  end

  def edit
  end

  def update
    return if logged_in_and_on_strangers_profile? || logged_out_on_existing_profile?

    if @profile.update(params[:profile].permit(:html))
      if user_signed_in?
        flash.now[:notice] = "Saved"
        render json: {status: 'success'} and return
      else
        session[:guestprofile] = @profile.id
        # in javascript: catch 401, show modal
        render nothing: true, status: 401 and return
      end
    end
  end

  def destroy
    @profile.destroy
    redirect_to '/'
  end

  def history
    @versions = @profile.versions
  end

  private
  def logged_in_and_on_strangers_profile?
    user_signed_in? && params[:user_id] && !yours_and_friends_ids.include?(params[:user_id].to_i)
  end

  def yours_and_friends_ids
    [current_user.id] + current_user.friends.map(&:id)
  end

  def logged_out_on_existing_profile?
    !user_signed_in? && params[:user_id]
  end

  def get_profile
    if params[:user_id] # route /users/:user_id/profile
      @profile = User.find(params[:user_id]).profile
    elsif user_signed_in? # routes /profile
      if session[:guestprofile]
        current_user.profile = Profile.find(session[:guestprofile])
        session[:guestprofile] = nil
      end
      @profile = current_user.profile || (current_user.profile = new_profile)
    else #guest
      @profile = new_profile
    end
  end

  def new_profile
    Profile.create(html: '<p id="example_element">Here is an editable html element</p>')
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
