require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should respond_to :file }
  it { should respond_to :slug }

  describe "#random_string" do
    subject { Image.new.send(:random_string) }
    
    it { should_not match /[\W]/ }

    it { should match /\A\w{8}\z/}
  end
end
