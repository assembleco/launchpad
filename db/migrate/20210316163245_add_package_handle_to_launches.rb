class AddPackageHandleToLaunches < ActiveRecord::Migration[6.1]
  def change
    add_column :launches, :package_handle, :string
  end
end
