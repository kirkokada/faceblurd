class Imgur
  include HTTMultiParty
  attr_accessor :token, :link
  base_uri 'https://api.imgur.com/3'

  def initialize(token)
    @token = token
  end

  def upload(image_file)
    response = self.class.post(
      '/image',
      headers: { 'Authorization' => "Bearer #{token}" },
      query: { 'image' => image_file, 'type' => 'file' })
    if response['success']
      self.link =  'https://imgur.com/' + response['data']['id']
    else
      return false
    end
  end
end
