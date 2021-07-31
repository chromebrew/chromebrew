#!/usr/bin/env ruby
require_relative '../lib/color.rb'

# for package.rb
$LOAD_PATH.unshift "#{Dir.pwd}/lib"

readme = File.readlines('README.md', chomp: true)

# get changed file using git
`git diff-tree -r --no-commit-id --diff-filter=AM --name-status #{ARGV[0]} 2> /dev/null`.chomp.each_line do |line|
  mode, pkgName = line.scan(/([A-Z])[[:blank:]]*packages\/(.*)\.rb/).flatten

  # mode: M for modified, A for added
  puts "Package: #{pkgName}".cyan,
       "Mode: #{mode}".cyan
  
  begin
    require_relative "../packages/#{pkgName}.rb"
  rescue SyntaxError => e
    STDERR.puts "#{e.class}: #{e.message}".red
  end

  pkg = Object.const_get(pkgName.capitalize)
  pkgLine = "| #{pkgName} | #{pkg.description} | #{Time.now.strftime("%Y-%m-%d")} | #{pkg.version} | <!--#{mode}_PKG-->"
  table_first_index = readme.index {|i| i =~ /<!--#{mode}_PKG-->/ }

  readme.delete_at(table_first_index + 9)
  readme.insert(table_first_index, pkgLine)
end

# write everything back to readme
File.write('README.md', readme.join("\n"))
