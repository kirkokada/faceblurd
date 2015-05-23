class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new()
    set_image_file
    if @image.save
      respond_to do |format|
        format.html { redirect_to edit_image_path(@image) }
        format.js
      end
    else
      flash[:error] = "Please select a file source."
      respond_to do |format|
        format.js { render 'shared/display_flash_messages' }
      end
    end
  end

  def edit
    find_image
  end

  def update
    find_image
    faces = params[:faces].split(',').each_slice(4).to_a
    faceblocker = FaceBlocker.new(image: @image, faces: faces)
    faceblocker.blur
    redirect_to @image
  end

  def show
    find_image
    session[:image_id] = @image.id
  end

  def destroy
    find_image
    image.destroy
    redirect_to root_path
  end

  def auth_callback
    image = Image.friendly.find(session[:image_id])
    image_file = image.file.read
    auth = request.env["omniauth.auth"]
    i = Imgur.new(auth['credentials']['token'])
    if i.upload(image_file)
      redirect_to i.link
    else
      flash[:error] = 'Image upload failed'
      redirect_to image
    end
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

    def find_image
      @image = Image.friendly.find(params[:id])
    end
end
