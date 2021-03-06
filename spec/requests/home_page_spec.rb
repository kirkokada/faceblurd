require 'rails_helper'

RSpec.describe 'Pages |', type: :request do
  describe 'Home page' do
    subject { page }
    before { visit root_path }

    it { should have_title 'Faceblurd' }
    it { should have_content 'Faceblurd' }
    it { should have_button 'Anonymize' }
  end
end
