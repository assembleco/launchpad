class LaunchesController < ApplicationController
  def new
    channels = params.permit(:hierarch_channel, :package_channel).values
    container = Docker::Container.create(
      'Image' => 'assemble/hierarch',
      'ExposedPorts' => channels.values.map{|x| ["#{x}/tcp", {}]}.to_h,
      'HostConfig' => {
        'PortBindings' =>
          channels.values.map{|x|
            ["#{x}/tcp", [{ 'HostPort' => x }]]
          }.to_h
      }
    )
    container.exec(['./my_service'], detach: true)

    render json: params.
      permit(:domain, :package_channel, :hierarch_channel).
      merge({ launched: "no" })
  end
end
