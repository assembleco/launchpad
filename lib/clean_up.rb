require 'docker'

class CleanUp
  def self.go(hard = false)
    running_launches = Launch.where(cleaned_up_at: nil)
    processes = Docker::Container.all

    running_launches.each do |launch|
      launch_process = processes.select {|x| x.id == launch.package_handle }

      launch.update!(cleaned_up_at: Time.current) if !launch_process

      begin
        launch_process.kill
        launch_process.delete if hard
        launch.update!(cleaned_up_at: Time.current)
      rescue
        puts "Error cleaning up #{launch.package_handle}"
      ensure
        # launch.update!(cleaned_up_at: Time.current)
      end
    end
  end
end
