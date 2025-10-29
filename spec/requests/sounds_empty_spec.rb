require 'rails_helper'

RSpec.describe "Sounds (empty state)", type: :request do
  it "returns an empty array when no curated sounds exist" do
    Sound.delete_all
    get "/sounds.json"
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to eq([])
  end
end
