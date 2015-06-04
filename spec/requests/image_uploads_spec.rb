require 'rails_helper'

RSpec.describe 'Image uploads:', type: :request do
  feature "Uploading images", js: true do
    background do
      visit root_path
      click_button "Anonymize yourself!"
    end

    feature "via local file" do
      
      scenario 'with an invalid file' do
        expect do
          attach_file :image_file,
                      File.join(Rails.root, '/spec/fixtures/files/text.txt')
          click_button "Upload"
        end.not_to change(Image, :count)
        expect(page).to have_button "Anonymize yourself!"
      end

      scenario "with a valid file" do
        expect do
          attach_file :image_file,
                      File.join(Rails.root, '/spec/fixtures/files/image.jpg')
          click_button "Upload"
        end.to change(Image, :count).by(1)
        image = Image.last
        expect(page).to have_css "img[src*='#{image.file}']"
      end
    end

    feature "via URL" do
      
      scenario 'with invalid URL' do
        VCR.use_cassette('image upload invalid url') do
          expect do
            fill_in 'image_remote_file_url', with: 'http://i.imgur.com/oRp2I8o'
            click_button 'Fetch'
          end.not_to change(Image, :count)
        end
        expect(page).to have_button "Anonymize yourself!"
      end

      scenario 'with valid URL' do
        VCR.use_cassette('image upload valid url') do
          expect do
            fill_in "image_remote_file_url", with: "http://i.imgur.com/oRp2I8o.jpg"
            click_button 'Fetch'
          end.to change(Image, :count).by(1)
        end
        image = Image.last
        expect(page).to have_css "img[src*='#{image.file}']"
      end
    end
  end
end
