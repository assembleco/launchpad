class Launch < ApplicationRecord
  def self.running
    self.
      where.not(launched_at: nil).
      where(cleaned_up_at: nil)
  end

  def self.go(address, params = {})
    address_pair =
      begin
        [params.fetch(:package_channel), params.fetch(:hierarch_channel)]
      rescue
        self.choose_address_pair
      end

    self.create(
      user_address: address,
      package_channel: address_pair[0],
      hierarch_channel: address_pair[1],
      launched_at: Time.current,
    )
  end

  def self.choose_address_pair
    launches = Launch.running.pluck(:package_channel, :hierarch_channel)

    p launches
    [1030, 1031]
  end

  def land
    update(cleaned_up_at: Time.current)
  end
end
