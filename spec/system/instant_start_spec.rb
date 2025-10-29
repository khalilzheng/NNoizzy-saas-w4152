
require 'rails_helper'

RSpec.describe "Instant start", type: :system, js: true do
  before do
    Sound.create!(name: "Rain", file_url: "/rain.mp3", is_curated: true)
    visit root_path
  end

  it "starts playing in one click and shows timer" do
    click_button "Instant Start"
    expect(page).to have_content("Current: Rain")
    expect(page).to have_content("Timer:")
  end
end
