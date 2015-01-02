class Postgis < ActiveRecord::Migration
  def change
    def up
      execute "CREATE EXTENSION IF NOT EXISTS postgis;"
    end
  end
end
