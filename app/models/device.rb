class Device < ActiveRecord::Base
  validates :auth_key, presence: true
end
