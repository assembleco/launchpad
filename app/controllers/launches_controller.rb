require 'docker'

class LaunchesController < ApplicationController
  def new
    p = params.permit(:domain, :package_channel, :hierarch_channel)
    channels = p.slice(:hierarch_channel, :package_channel)

    container = Docker::Container.create(
      'Cmd' => ['yarn', 'go'],
      'Image' => 'assemble/hierarch',
      'Env' => [
        "DOMAIN=#{p[:domain]}",
        "HIERARCH_CHANNEL=#{p[:hierarch_channel]}",
        "PACKAGE_CHANNEL=#{p[:package_channel]}",
      ],
      'ExposedPorts' => channels.values.map{|x| ["#{x}/tcp", {}]}.to_h,
      'HostConfig' => {
        'PortBindings' =>
        channels.values.map{|x| ["#{x}/tcp", [{ 'HostPort' => x.to_s }]] }.to_h
      }
    )
    container.start
    puts 'running'

    sleep 10
    response = []

    response << container.logs(stdout: true)
    puts 'logs:'
    puts response[-1]

    response << container.exec(['node', 'hierarch'], detach: true)
    puts 'logs:'
    puts response[-1]

    render json: p.merge({ launched: "yes", response: response })
  end
end
