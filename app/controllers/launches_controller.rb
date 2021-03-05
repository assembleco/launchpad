class LaunchesController < ApplicationController
  def new
    render json: { launched: "no" }
  end
end
