class Image < ActiveRecord::Base
  validates_presence_of :file
  mount_uploader :file, ImageUploader
end
