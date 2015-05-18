class Image < ActiveRecord::Base
  extend FriendlyId
  validates_presence_of :file
  mount_uploader :file, ImageUploader
  friendly_id :random_string, use: :slugged

  private 

    def random_string
      [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
    end
end
