require 'simplecov'

# Keep SimpleCov minimal & stable on Windows/Ruby 3.4 (no branch coverage to avoid adapter issues)
SimpleCov.start do
  # Only track controllers for this iteration so coverage isn't dragged down by other layers
  track_files 'app/controllers/**/*.rb'

  # Exclude stuff we don't care about for this assignment
  add_filter %r{^/app/views/}
  add_filter %r{^/app/assets/}
  add_filter %r{^/app/helpers/}
  add_filter %r{^/app/javascript/}
  add_filter %r{^/app/jobs/}
  add_filter %r{^/app/mailers/}
  add_filter %r{^/app/channels/}
  add_filter %r{^/config/}
  add_filter %r{^/db/}
  add_filter %r{^/lib/}
  add_filter %r{^/spec/}
end

RSpec.configure do |config|
  # rspec-expectations config
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # rspec-mocks config
  config.mock_with :rspec do |m|
    m.verify_partial_doubles = true
  end

  # Run focused examples when present
  config.filter_run_when_matching :focus

  # Persist example statuses (for --only-failures / --next-failure)
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Disable monkey patching to keep the DSL explicit
  config.disable_monkey_patching!

  # Use doc formatter when running a single file
  config.default_formatter = 'doc' if config.files_to_run.one?

  # Randomize order to surface order dependencies
  config.order = :random
  Kernel.srand config.seed
end
