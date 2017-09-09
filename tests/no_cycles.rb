require 'find'
require_relative '../lib/color'

@all_pkgs = {}

# Loads all packages
Find.find("#{CUR_DIR}/../packages") do |filename|
  if File.extname(filename) == '.rb'
    name = File.basename(filename, '.rb')
    require_relative("../packages/#{name}")
    pkg = Object.const_get(name.capitalize)
    pkg.name = name
    @all_pkgs[name] = pkg
  end
end

# Looking for cycles. @path will keep the current dependency path.
# @state will store :on_path for vertices on the current dependency path
# and :visited for vertices that have already been checked not to lead to
# cycles.
@state = {}
@path = []
def dfs(pkg)
  @path.push(pkg.name)
  if @state[pkg] == :on_path
    puts "Found dependency cycle!".lightred
    while @path.first != @path.last
      @path.shift
    end
    puts @path.to_s
    exit 1
  elsif @state[pkg] == nil
    @state[pkg] = :on_path
    if pkg.dependencies
      pkg.dependencies.each do |name, v|
        if name != pkg.name
          dfs(@all_pkgs[name])
        end
      end
    end
    @state[pkg] = :visited
  end
  @path.pop
end

# Calls dfs for every path
@all_pkgs.each do |name, pkg|
  dfs(pkg)
end

puts "No dependency cycles found.".lightgreen
