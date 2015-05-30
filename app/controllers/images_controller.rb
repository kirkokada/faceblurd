class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    set_image_file
    if @image.save
      redirect_to edit_image_path(@image)
    else
      flash[:error] = 'Please select a file source.'
      render :new
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
    @image.destroy
    redirect_to root_path
  end

  def auth_callback
    imgur = Imgur.new(imgur_auth_token)
    if imgur.upload(read_image_file)
      redirect_to imgur.link
    else
      redirect_to image, error: 'Image uplaod failed.'
    end
  end

  private

  def imgur_auth_token
    request.env['omniauth.auth']['credentials']['token']
  end

  def read_image_file
    Image.friendly.find(session[:image_id]).file.read
  end

  def set_image_file
    return unless params[:image]
    @image = Image.new
    set_image_from_url
    set_image_from_file
  end

  def set_image_from_url
    return unless params[:image][:remote_file_url]
    @image.remote_file_url = params[:image][:remote_file_url]
  end

  def set_image_from_file
    return unless params[:image][:file]
    @image.file = params[:image][:file]
  end

  def find_image
    @image = Image.friendly.find(params[:id])
  end
end
