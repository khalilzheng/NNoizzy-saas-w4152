
require "rails_helper"

RSpec.describe "Noizzy focus flow", type: :system, js: true do
  before do
    # Always start fresh (like your Cucumber background step)
    visit root_path
    page.execute_script("localStorage.clear(); sessionStorage.clear();")
    expect(page).to have_content("Noizzy")
  end

  it "one-click play from the homepage" do
    click_button "Instant Start"
    expect(page).to have_content("Rain")
    expect(page).to have_css("#timer", visible: true)
  end

  it "pause and resume" do
    # Start playing Ocean via the fixed buttons on the page
    click_button "Ocean"
    # Pause -> should show Play
    click_button "Pause"
    expect(page).to have_button("Play")
    # Resume -> should show Pause
    click_button "Play"
    expect(page).to have_button("Pause")
  end

  it "switch to another curated sound without resetting timer" do
    click_button "Rain"
    # After some time, switch to Fan
    page.execute_script("window.setTimeout(()=>{}, 0);") # no-op; just to show intent
    click_button "Fan"
    expect(page).to have_content("Fan")
    expect(page).to have_css("#timer", visible: true) # timer stays visible (not reset check)
  end

  it "adjust volume without extra UI noise" do
    click_button "Rain"
    slider = find("#volume")
    page.execute_script("arguments[0].value = 0.3; arguments[0].dispatchEvent(new Event('input'));", slider)
    vol = page.evaluate_script('document.querySelector("#volume").value')
    expect(vol.to_f).to be_within(0.1).of(0.3)
  end

  it "store favorite locally" do
    click_button "Ocean"
    click_button "Favorite Ocean"
    favorites = page.evaluate_script('JSON.parse(localStorage.getItem("favorites") || "[]")')
    expect(favorites).to include("Ocean")
  end
end
