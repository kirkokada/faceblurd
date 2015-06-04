require 'file_size_validator'
class Image < ActiveRecord::Base
  extend FriendlyId
  validates :file, presence: true, file_size: { maximum: 0.5.megabytes.to_i }
  mount_uploader :file, ImageUploader
  friendly_id :random_string, use: :slugged

  private

  def random_string
    [*('a'..'z'), *('0'..'9')].sample(8).join
  end
end
