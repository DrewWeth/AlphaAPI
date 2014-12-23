class PostIndex < ActiveRecord::Migration
  def change
    add_index :posts, :created_at, :name => 'post_created_at_index'
    
  end
end
