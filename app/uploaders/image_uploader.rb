# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  # Override the directory where uploaded files will be stored.
  def store_dir
    "images/"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
