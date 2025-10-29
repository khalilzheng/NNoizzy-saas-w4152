# spec/models/system/focus_flow_spec.rb
require 'rails_helper'

RSpec.describe 'Focus flow', type: :system, js: true do
  before do
    driven_by(:selenium_chrome_headless)
    %w[Rain Ocean Fan].each { |n| Sound.create!(name: n, is_curated: true, file_url: "/#{n.downcase}.mp3") }
  end

  it 'starts instantly and shows timer' do
    visit '/'
    click_button 'Instant Start'
    expect(page).to have_content('Current:')
    expect(page).to have_content('Rain')
    expect(page).to have_selector('#timer')
  end

  it 'can choose a curated sound' do
    visit '/'
    click_button 'Instant Start'
    click_button 'Fan'
    expect(page).to have_content('Fan')
  end
end
