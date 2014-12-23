class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content, :default => ""
      t.float :latitude
      t.float :longitude
      t.integer :views, :default => 0
      t.integer :ups, :default => 0
      t.integer :downs, :default => 0
      t.float :radius, :default => 5
      t.integer :device_id, :default => 1, :null => false

      t.timestamps
    end
  end
end
