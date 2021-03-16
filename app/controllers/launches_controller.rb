require 'docker'

class LaunchesController < ApplicationController
  def new
    launch = Launch.go(request.remote_ip)
    channels = [launch.package_channel, launch.hierarch_channel]

    environ = {
      'Cmd' => ['yarn', 'go'],
      'Image' => 'assemble/hierarch',
      'Env' => [
        "DOMAIN=#{"0.0.0.0"}",
        "PACKAGE_CHANNEL=#{launch.package_channel}",
        "HIERARCH_CHANNEL=#{launch.hierarch_channel}",
      ],
      'ExposedPorts' => channels.map{|x| ["#{x}/tcp", {}]}.to_h,
      'HostConfig' => {
        'PortBindings' =>
        channels.map{|x| ["#{x}/tcp", [{ 'HostPort' => x.to_s }]] }.to_h
      }
    }

    container = Docker::Container.create(environ)
    container.start
    launch.update(package_handle: container.id)

    response = container.exec(['node', 'hierarch'], detach: true)

    render json: {
      launched: "yes",
      handle: launch.package_handle,
      response: response,
    }
  end
end
