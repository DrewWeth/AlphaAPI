class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :auth_key

      t.timestamps
    end
  end
end
