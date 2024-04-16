require_relative 'color'
require_relative 'const'

def crewlog(str)
  caller_locations(1, 1).first.tap {|loc| puts "#{loc.path}:#{loc.lineno}:#{caller_locations(3).first.label}:#{str}".lightpurple if CREW_VERBOSE}
end
