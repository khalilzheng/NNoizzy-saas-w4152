require 'rails_helper'

RSpec.describe "Sounds HTML index", type: :request do
  it "redirects HTML requests to root (controller has no HTML index)" do
    get sounds_path  
    expect(response).to have_http_status(302).or have_http_status(301)
 
    expect(response.headers["Location"]).to match(/\/($|focus)/)
  end
end
