class ParseToken < ActiveRecord::Migration
  def change
    add_column :devices, :parse_token, :string
  end
end
