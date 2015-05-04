class ImagesController < ApplicationController
  def new
    uploader.download!(params[:image_url])
    @image_url = uploader.url
  end

  private

  def uploader
    @uploader ||= ImageUploader.new
  end
end
