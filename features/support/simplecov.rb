 
return unless ENV['COVERAGE']
require "simplecov"

 
SimpleCov.configure do
  enable_coverage :line
end

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

SimpleCov.start do
 
  track_files "app/{controllers,models}/**/*.rb"

 
  add_filter %r{^/spec/}
  add_filter %r{^/features/}
  add_filter %r{^/config/}
  add_filter %r{^/bin/}
  add_filter %r{^/db/}
  add_filter %r{^/vendor/}
  add_filter %r{^/app/assets/}
  add_filter %r{^/app/helpers/}
  add_filter %r{^/app/jobs/}
  add_filter %r{^/app/mailers/}
  add_filter %r{^/app/channels/}
  add_filter %r{^/app/views/}
end
