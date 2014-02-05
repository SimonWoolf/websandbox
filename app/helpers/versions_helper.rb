module VersionsHelper
  def linkrevert
    if @profile.versions.any? && !@profile.versions.last.object.nil?
      link_to 'Revert to previous version', revert_version_path(@profile.versions(true).last), method: :post, class: "button verbtns"
    else
      'Previous'
    end
  end
end
