class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new()
    set_image_file
    if @image.save
      redirect_to edit_image_path(@image)
    else
      flash[:error] = "Please select a file source."
      respond_to do |format|
        format.js { render 'shared/display_flash_messages' }
      end
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

  def destroy
    Image.find(params[:id]).destroy
    redirect_to root_url
  end

  private

  def set_image_file
    return unless params[:image]
    if params[:image][:remote_file_url]
      @image.remote_file_url = params[:image][:remote_file_url]
    elsif params[:image][:file]
      @image.file = params[:image][:file]
    end
  end
end
