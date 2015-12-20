require 'bundler/gem_tasks'

require 'rake/extensiontask'
Rake::ExtensionTask.new('crc32') do |ext|
  ext.ext_dir = 'ext/digest/crc32'
  ext.lib_dir = 'lib/digest'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(spec: :compile)

task default: :spec
