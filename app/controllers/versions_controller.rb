class VersionsController < ApplicationController
  def previous
    @version = PaperTrail::Version.find(params[:id])
    @version.reify.save!
    redirect_to :back
  end
end
