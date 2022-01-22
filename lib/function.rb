# function.rb: define functions that called by bin/crew and different libraries

def valid? (object)
  return object.to_s.empty?
end

def warn (*msg)
  puts *msg.map(&:yellow)
end

def verbose_puts (*msg)
  puts *msg if Verbose
end
