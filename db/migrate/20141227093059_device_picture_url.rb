class DevicePictureUrl < ActiveRecord::Migration
  def change
    add_column :devices, :profile_url, :string
  end
end
