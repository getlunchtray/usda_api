class Api::V1::ReleasesController < ApplicationController
  def index
    expose({
      latest_release: Release.first.version
    }) 
  end
end
