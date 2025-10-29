require 'rails_helper'

RSpec.describe "Play / Pause", type: :system, js: true do
  before do
    Sound.create!(name: "Ocean", file_url: "/ocean.mp3", is_curated: true)
    visit root_path
    click_button "Instant Start"
    click_button "Ocean" rescue nil
  end

  it "pauses and resumes" do
    click_button "Pause"
    expect(page).to have_button("Play")
    click_button "Play"
    expect(page).to have_button("Pause")
  end
end
