# The default action tests commands and libraries.
task default: %w[command_test lib_test]

# Command tests
task :command_test do
  ruby 'tests/commands/const.rb'
  ruby 'tests/commands/help.rb'
  ruby 'tests/commands/list.rb'
  ruby 'tests/commands/prop.rb'
  ruby 'tests/commands/remove.rb'
  ruby 'tests/commands/whatprovides.rb'
end

# Library tests
task :lib_test do
  ruby 'tests/lib/docopt.rb'
  ruby 'tests/lib/package_utils.rb'
end

# Package tests
task :package_test do
  ruby 'tests/prop_test'
  ruby 'tests/buildsystem_test'
end
