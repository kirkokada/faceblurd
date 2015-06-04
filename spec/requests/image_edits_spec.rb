require 'rails_helper'

RSpec.describe 'Image edits:', type: :request do

  feature 'blurring a face', js: true do
    context 'when a face is detectable' do
      let!(:image) { FactoryGirl.create :image }
      background do
        visit edit_image_path(image)
      end

      it 'should notify the user' do
        expect(page).to have_content 'Face detected'
      end
    end

    context 'when a face is detectable' do
      let!(:image) { FactoryGirl.create :no_face_image }
      background do
        visit edit_image_path(image)
      end

      it 'should notify the user' do
        expect(page).to have_content 'No faces detected'
      end
    end
  end
end