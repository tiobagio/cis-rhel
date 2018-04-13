# -*- encoding: utf-8 -*-

# Style & Link Tests
begin
  require 'cookstyle'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.options << '--display-cop-names'
  end
rescue LoadError
  puts 'The chefstyle gem is not available.'
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts 'Unable to load Test-Kitchen Rake tasks.'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:chefspec)

task default: %w(rubocop chefspec)
