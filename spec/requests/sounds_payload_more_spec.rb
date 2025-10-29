require 'rails_helper'

RSpec.describe "Sounds payload (DB present)", type: :request do
  before do
  
    s1 = Sound.new(
      id: 456,
      name: "",                                
      file_url: "/sounds/rain.mp3",
      is_curated: true
    )
    s1.save!(validate: false)             

   
    Sound.create!(
      name: "Ocean",
      file_url: "/sounds/ocean.mp3",
      is_curated: true
    )
  end

  it "returns array with id numeric, name fallback to filename when blank, and required keys" do
    get "/sounds", as: :json
    expect(response).to have_http_status(:ok)
    arr = JSON.parse(response.body)
    expect(arr).to be_an(Array)

    arr.each do |h|
      expect(h.keys).to include("id", "name", "file_url", "is_curated")
      expect(h["id"]).to be_a(Integer)
    end

    rain = arr.find { |h| h["file_url"] == "/sounds/rain.mp3" }
    expect(rain["id"]).to eq(456)        
    expect(rain["name"]).to eq("Rain")    
    expect(rain["is_curated"]).to eq(true)

    ocean = arr.find { |h| h["file_url"] == "/sounds/ocean.mp3" }
    expect(ocean["name"]).to eq("Ocean")  
  end
end
