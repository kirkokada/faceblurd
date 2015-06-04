require 'rmagick'

class FaceBlocker
  attr_reader :image, :faces, :file_path

  def initialize(params = {})
    @file_path = Rails.root + params[:image].file.path
    @image = Magick::Image.read(file_path)[0]
    @faces = params[:faces]
  end

  def blur
    faces.each do |face|
      face.map!(&:to_i)
      face_image = constitute_image(face, get_face_pixels(face))
      overlay_blurred_image(face, face_image)
      image.write(file_path)
      image.destroy!
    end
  end

  private

  def get_face_pixels(coords)
    image.dispatch(coords[0], coords[1], coords[2], coords[3], 'RGB')
  end

  def constitute_image(coords, pixels)
    Magick::Image.constitute(coords[2], coords[3], 'RGB', pixels)
  end

  def overlay_blurred_image(coords, overlay)
    image.composite!(overlay.blur_image(0, 10),
                     coords[0],
                     coords[1],
                     Magick::OverCompositeOp)
  end
end
