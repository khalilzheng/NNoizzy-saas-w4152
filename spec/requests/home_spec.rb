 
require "rails_helper"

RSpec.describe "Home", type: :request do
  it "renders index with curated names when records exist" do
    Sound.create!(name: "Rain",  file_url: "/rain.mp3",  is_curated: true)
    Sound.create!(name: "Ocean", file_url: "/ocean.mp3", is_curated: true)

    get "/home"
    expect(response).to have_http_status(:ok)
 
    expect(response.body).to include("Rain").and include("Ocean")
  end

  it "renders fallback curated list when DB empty" do
    Sound.delete_all

    get "/home"
    expect(response).to have_http_status(:ok)
 
    expect(response.body).to include("Rain", "Ocean", "Fan")
  end
end
