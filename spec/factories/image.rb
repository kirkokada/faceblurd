FactoryGirl.define do
  factory :image do
    file Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'spec', 'fixtures', 'files', 'image.jpg')
    )
  end

  factory :no_face_image, class: Image do
    file Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'spec', 'fixtures', 'files', 'blurred.jpg')
    )
  end
end