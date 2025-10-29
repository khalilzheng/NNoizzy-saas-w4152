require 'rails_helper'

RSpec.describe Sound, type: :model do
  it "is valid with name and file_url and can be returned by curated scope" do
    s = Sound.create!(name: "Rain", file_url: "/rain.mp3", is_curated: true)
    expect(s).to be_valid
    expect(Sound.curated).to include(s)
  end
end
