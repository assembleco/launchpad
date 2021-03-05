class LaunchesController < ApplicationController
  def new
    render json: params.permit(
      :domain,
      :package_channel,
      :hierarch_channel,
    ).to_h.merge({ launched: "no" })
  end
end
