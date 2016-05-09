class Api::V1::ReleasesController < Api::V1::BaseController 
  def index
    expose({
      latest_release: Release.first.version
    }) 
  end
end
