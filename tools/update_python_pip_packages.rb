#!/usr/bin/env ruby
# update_python_pip_packages version 1.1 (for Chromebrew)
# This updates the versions in python pip packages.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in packages dir: ../tools/update_python_pip_packages.rb
require 'parallel'

py_ver = `python3 -c "print('.'.join(__import__('platform').python_version_tuple()[:2]))"`.chomp
py3_files = Dir['py3_*.rb']
pip_files = `grep -l "^require 'buildsystems/pip'" *.rb`.chomp.split
relevant_pip_files = (py3_files + pip_files).uniq!

pip_config = `pip config list`.chomp
system 'pip config --user set global.index-url https://gitlab.com/api/v4/projects/26210301/packages/pypi/simple', %i[err out] => File::NULL unless pip_config.include?("global.index-url='https://gitlab.com/api/v4/projects/26210301/packages/pypi/simple'")
system 'pip config --user set global.extra-index-url https://pypi.org/simple', %i[err out] => File::NULL unless pip_config.include?("global.extra-index-url='https://pypi.org/simple'")
system 'pip config --user set global.trusted-host gitlab.com', %i[err out] => File::NULL unless pip_config.include?("global.trusted-host='gitlab.com'")

Parallel.map(relevant_pip_files) do |package|
  pip_name = package.gsub('.rb', '').sub('py3_', '').gsub('_', '-')
  prerelease = ''
  if system("grep -q '^\ \ prerelease' #{package}")
    puts "#{pip_name.capitalize} is configured to look for a pre-release version."
    prerelease = '--pre'
  end
  pip_version = `python -m pip index versions #{prerelease} #{pip_name} 2>/dev/null | head -n 1 | awk '{print $2}'`.chomp.delete('()')
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
