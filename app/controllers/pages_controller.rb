class PagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def image
    @image_url = params[:img_url]
  end
end
