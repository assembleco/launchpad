class CreateLaunches < ActiveRecord::Migration[6.1]
  def change
    create_table :launches do |t|
      t.string :user_address
      t.integer :package_channel
      t.integer :hierarch_channel
      t.timestamp :launched_at
      t.timestamp :cleaned_up_at

      t.timestamps
    end
  end
end
