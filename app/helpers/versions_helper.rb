module VersionsHelper
  def linkprevious
    if @profile.versions.any? && !@profile.versions.last.object.nil?
      link_to 'Previous', previous_version_path(@profile.versions(true).last), method: :post, html: {class: "success button verbtns"}
    else
      'Previous'
    end
  end
end
