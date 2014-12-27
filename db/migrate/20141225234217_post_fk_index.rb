class PostFkIndex < ActiveRecord::Migration
  def change
    add_index :posts, :device_id, :name => 'post_device_foreign_key_index'

  end
end
