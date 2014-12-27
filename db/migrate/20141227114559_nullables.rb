class Nullables < ActiveRecord::Migration
  def change
    change_column :devices, :profile_url, :string, :default => "empty", :null => false

  end
end
