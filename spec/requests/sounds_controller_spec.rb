
require "rails_helper"

RSpec.describe "SoundsController", type: :request do
  before do
    Sound.create!(name: "Rain",  file_url: "/rain.mp3",  is_curated: true)
    Sound.create!(name: "Ocean", file_url: "/ocean.mp3", is_curated: true)
  end

  it "redirects html requests (no HTML index)" do
    get sounds_path             
    expect(response).to have_http_status(:found)   # 
    expect(response).to redirect_to(root_path)      

    follow_redirect!                               
    expect(response).to have_http_status(:ok)     
 
    expect(response.body).to include("Instant Start").or include("Current:").or include("Noizzy")
  end

  it "returns curated sounds as JSON with required keys" do
    get sounds_path(format: :json)
    expect(response).to have_http_status(:ok)
    data = JSON.parse(response.body)
    expect(data).to be_an(Array)
    expect(data).not_to be_empty
    data.each do |h|
      expect(h.keys).to include("id", "name", "file_url", "is_curated")
    end
  end
end
