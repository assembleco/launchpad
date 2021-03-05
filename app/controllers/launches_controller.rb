class LaunchesController < ApplicationController
  def new
    render json: params.
      permit(:domain, :package_channel, :hierarch_channel).
      merge({ launched: "no" })
  end
end
