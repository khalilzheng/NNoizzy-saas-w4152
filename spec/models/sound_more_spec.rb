require "rails_helper"

RSpec.describe Sound, type: :model do
  it "curated scope only returns curated sounds" do
    curated = Sound.create!(name: "Rain", file_url: "/rain.mp3", is_curated: true)
    Sound.create!(name: "White", file_url: "/white.mp3", is_curated: false)
    expect(Sound.curated).to contain_exactly(curated)
  end

  it "is invalid without name and file_url" do
    s = Sound.new(is_curated: true)
    expect(s.valid?).to be false
    expect(s.errors[:name]).to be_present
    expect(s.errors[:file_url]).to be_present
  end
end
