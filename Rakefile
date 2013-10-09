require 'rspec/core/rake_task'
require 'rake/clean'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

CLOBBER.include('*.gem')

namespace :gem do
  desc "Rebuild Gem"
  task :build do
    `gem build frosty.gemspec`
  end

  desc "Install gem"
  task :install do
    `gem install *.gem`
  end
end
