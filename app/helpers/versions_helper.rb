module VersionsHelper
  def linkrevert(text, version)
    if @profile.versions.any? && !@profile.versions.last.object.nil?
      link_to text, revert_version_profile_path(version), method: :post, class: "button verbtns"
    else
      'Previous'
    end
  end
end
