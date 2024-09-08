#!/usr/bin/env ruby
# update_python_pip_packages version 1.0 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in packages dir: ../tools/update_python_pip_packages.rb
system 'pip install update_checker'
py_ver = `python3 -c "print('.'.join(__import__('platform').python_version_tuple()[:2]))"`.chomp
Dir['py3_*.rb'].each do |package|
  pip_name = package.gsub('.rb', '').gsub('py3_', '').gsub('_', '-')
  pip_version = `python3 -c "print(__import__('update_checker').UpdateChecker().check('#{pip_name}', '0.0.0.0.0').available_version)"`.chomp
  puts "#{pip_name} version is #{pip_version}"
  if pip_version.empty?
    puts "Checking #{pip_name} version failed..."
    next
  end
  puts "Updating #{pip_name} package file #{package} to #{pip_version}"
  if pip_name == 'pyicu'
    icu_ver = `uconv -V`.chomp.split[3]
    system "sed -i \"s,^\ \ version\ .*,\ \ version '#{pip_version}-icu#{icu_ver}-py#{py_ver}',\" #{package}"
  else
    system "sed -i \"s,^\ \ version\ .*,\ \ version '#{pip_version}-py#{py_ver}',\" #{package}"
  end
end
