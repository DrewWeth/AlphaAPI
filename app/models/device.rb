class Device < ActiveRecord::Base
  validates :auth_key, presence: true

  has_many :posts
end
