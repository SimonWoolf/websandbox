module ProfileHelper
  def viewing_someone_elses_profile?
    if user_signed_in?
      @profile != current_user.profile
    else
      !@profile.user.nil? # not your guest profile
    end
  end
end
