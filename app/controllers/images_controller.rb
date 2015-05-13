class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new()
    if params[:image][:remote_file_url]
      @image.remote_file_url = params[:image][:remote_file_url]
    elsif params[:image][:file]
      @image.file = params[:image][:file]
    end
    if @image.save
      redirect_to edit_image_path(@image)
    else
      render :new
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    faces = params[:faces].split(',').each_slice(4).to_a
    faceblocker = FaceBlocker.new(image: @image, faces: faces)
    faceblocker.blur
    redirect_to @image
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def uploader
    @uploader ||= ImageUploader.new
  end
end
