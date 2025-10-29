require 'rails_helper'

RSpec.describe "Sounds", type: :request do
  it 'lists curated sounds as JSON' do
    Sound.create!(name: 'Rain', file_url: '/rain.mp3', is_curated: true)
    Sound.create!(name: 'Fan',  file_url: '/fan.mp3',  is_curated: false)

    get '/sounds.json'
    expect(response).to have_http_status(:ok)

    data = JSON.parse(response.body)
    expect(data).to all(include('name', 'file_url', 'is_curated'))
    expect(data.map { |h| h['name'] }).to eq(['Rain']) # 只返回 curated
  end

  it 'returns empty array when no curated sounds' do
    get '/sounds.json'
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to eq([])
  end
end
