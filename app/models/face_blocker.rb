require 'rmagick'

class FaceBlocker
  attr_reader :image, :faces, :file_path

  def initialize(params={})
    @file_path = Rails.root + params[:image].file.path
    @image = Magick::Image.read(file_path)[0]
    @faces = params[:faces]
  end

  def blur
    faces.each do |face|
      face.map!(&:to_i)
      face_pixels = image.dispatch(face[0], face[1], face[2], face[3], "RGB")
      face_image = Magick::Image.constitute(face[2], face[3], "RGB", face_pixels)
      image.composite!(face_image.blur_image(0, 10), face[0], face[1], Magick::OverCompositeOp)
      image.write(file_path)
    end
  end
end