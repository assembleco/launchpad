class LaunchesController < ApplicationController
  def new
    container = Docker::Container.create(
      'Image' => 'assemble/hierarch',
      'ExposedPorts' => { '1234/tcp' => {} },
      'HostConfig' => {
        'PortBindings' => {
          '1234/tcp' => [{ 'HostPort' => '1234' }]
        }
      }
    )
    container.exec(['./my_service'], detach: true)

    render json: params.
      permit(:domain, :package_channel, :hierarch_channel).
      merge({ launched: "no" })
  end
end
