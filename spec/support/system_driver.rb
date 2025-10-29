require "capybara/rspec"

RSpec.configure do |config|
  # Use Selenium + headless Chrome for system specs with JS
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1280, 900]
  end
end

Capybara.default_max_wait_time = 3
