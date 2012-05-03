# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  # with Minitest::Spec
  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r|^lib/(.*)\.rb|)            { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r|^app/(.*)\.rb|)            { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r|^app/(.*)\.rb|)            { |m| "spec/#{m[1]}_functional_spec.rb" }
  watch(%r|^spec/spec_helper.*\.rb|)  { "spec" }
end

guard 'bundler' do
  watch('Gemfile')
end

guard 'shell' do
  def refresh_tags
    `ctags-exuberant -e -R lib app spec public config`
  end

  watch(%r{^(lib|app|spec|public|config)/.*\.rb$}) {|m| refresh_tags }
end

guard 'migrate', :reset => true do
  watch(%r{^db/migrate/(\d+).+\.rb})
end

guard 'cucumber' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
