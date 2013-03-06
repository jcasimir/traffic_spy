guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

guard 'livereload' do
  watch(%r{lib/traffic_spy/views/.+\.(erb|haml|slim)$})
  watch(%r{public/.+\.(css|js|html)})
end
