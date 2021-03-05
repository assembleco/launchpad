class LaunchesController < ApplicationController
  def new
    vars = params.permit(
      :domain,
      :package_channel,
      :hierarch_channel,
    ).slice(
      :domain,
      :package_channel,
      :hierarch_channel,
    ).merge({ launched: "no" })

    puts vars
    render json: vars
  end
end
