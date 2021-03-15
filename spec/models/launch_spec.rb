require 'rails_helper'

RSpec.describe Launch do
  describe ".go" do
    it "chooses a couple open channels and re-uses closed ones" do
      launches = [
        Launch.go("192.168.1.1", package_channel: 1024, hierarch_channel: 1025),
        Launch.go("192.168.1.2", package_channel: 1026, hierarch_channel: 1027),
        Launch.go("192.168.1.3", package_channel: 1028, hierarch_channel: 1029),
      ]
      launch = Launch.go("192.168.1.4")

      expect(Launch.running.count).to eq(4)
      expect(launch.package_channel).to eq 1030
      expect(launch.hierarch_channel).to eq 1031
      expect(launch.user_address).to eq "192.168.1.4"

      launches.each { |l| l.land }

      second_launch = Launch.go("192.168.1.5")

      expect(second_launch.package_channel).to eq 1024
      expect(second_launch.hierarch_channel).to eq 1025
    end
  end
end
