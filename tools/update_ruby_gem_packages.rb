#!/usr/bin/env ruby
# update_ruby_gem_packages version 1.0 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in packages dir: ../tools/update_ruby_gem_packages.rb
Dir['ruby_*.rb'].each do |package|
  gem_name = package.gsub('.rb', '').gsub('ruby_', '').gsub('_', '-')
  gem_version = Gem.latest_spec_for(gem_name).version.to_s
  puts "Updating #{gem_name} package file #{package} to #{gem_version}"
  system "sed -i \"s,^\ \ version\ .*,\ \ version '#{gem_version}-ruby-#{RUBY_VERSION.slice(/(?:.*(?=\.))/)}',\" #{package}"
end
