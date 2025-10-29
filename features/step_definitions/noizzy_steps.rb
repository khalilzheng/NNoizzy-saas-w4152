Given('the curated sounds exist: {string}, {string}, {string}') do |a, b, c|
  [a, b, c].each do |name|
    rec = Sound.find_or_initialize_by(name: name)
    if rec.respond_to?(:has_attribute?) && rec.has_attribute?(:is_curated)
      rec.is_curated = true
    elsif rec.respond_to?(:has_attribute?) && rec.has_attribute?(:curated)
      rec.curated = true
    end
    if rec.respond_to?(:has_attribute?) && rec.has_attribute?(:file_url) && rec.file_url.blank?
      rec.file_url = "/test/#{name.downcase}.mp3"
    end
    if rec.respond_to?(:has_attribute?) && rec.has_attribute?(:audio_url) && rec.audio_url.blank?
      rec.audio_url = "/test/#{name.downcase}.mp3"
    end
    if rec.respond_to?(:has_attribute?) && rec.has_attribute?(:url) && rec.url.blank?
      rec.url = "/test/#{name.downcase}.mp3"
    end
    if rec.respond_to?(:has_attribute?) && rec.has_attribute?(:duration_ms) && rec.duration_ms.nil?
      rec.duration_ms = 0
    end
    if rec.respond_to?(:has_attribute?) && rec.has_attribute?(:loop_ms) && rec.loop_ms.nil?
      rec.loop_ms = 0
    end
    rec.save!
  end
end

Given('I am a first-time visitor') do
  visit root_path
  page.execute_script('localStorage.clear()')
  page.execute_script('sessionStorage.clear()')
end

Given('I visit the homepage') do
  visit root_path
  expect(page).to have_content('Noizzy')
end

When('I click the {string} button') do |label|
  click_button(label)
end

Then('I should see {string} as the current playing sound') do |sound|
  expect(page).to have_content(sound)
end

Then('I should see the timer counting up') do
  expect(page).to have_css('#timer', visible: true)
end

Given('I start playing {string}') do |sound|
  visit root_path
  click_button(sound)
end

When('I press the {string} control') do |control|
  click_button(control)
end

Then('playback should be paused') do
  expect(page).to have_button('Play')
end

Then('playback should resume') do
  expect(page).to have_button('Pause')
end

When('I choose the {string} sound') do |sound|
  click_button(sound)
end

Then('the timer should not reset') do
  expect(page).to have_css('#timer', visible: true)
end

When('I move the volume slider to {int} percent') do |percent|
  slider = find('#volume')
  value = percent.to_f / 100.0
  page.execute_script("arguments[0].value = #{value}; arguments[0].dispatchEvent(new Event('input'));", slider)
end

Then('the current volume should be near {string}') do |target|
  vol = page.evaluate_script('document.querySelector("#volume").value.toString()')
  expect(vol.to_f).to be_within(0.1).of(target.to_f)
end

When('I favorite {string}') do |sound|
  click_button("Favorite #{sound}")
end

Then('{string} should be in my favorites locally') do |sound|
  favorites = page.evaluate_script('JSON.parse(localStorage.getItem("favorites") || "[]")')
  expect(favorites).to include(sound)
end
