class Post < ActiveRecord::Base
  validates :content, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :device_id, presence: true
  
  belongs_to :device
end
