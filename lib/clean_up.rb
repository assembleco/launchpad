require 'docker'

class CleanUp
  def self.go(hard = false)
    launched_programs = Launch.where(cleaned_up_at: nil)
    processes = Docker::Container.all

    launched_programs.each do |program|
      process = processes.find {|x| x.id == program.package_handle }

      if !process
        program.update!(cleaned_up_at: Time.current)
      else
        begin
          process.kill
          process.delete if hard
          program.update!(cleaned_up_at: Time.current)
        rescue
          puts "Error cleaning up #{program.package_handle}"
        ensure
          # program.update!(cleaned_up_at: Time.current)
        end
      end
    end
  end
end
