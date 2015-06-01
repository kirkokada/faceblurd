FactoryGirl.define do
  factory :image do
    file Rack::Test::UploadedFile.new(
      File.open(
        File.join(
          Rails.root, 
          '/spec/fixtures/files/image.jpg'
        )
      )
    )
  end
end