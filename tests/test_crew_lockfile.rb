#!/usr/bin/env ruby
require_relative '../lib/crew_lockfile'
puts 'Before lock:'
system 'ls test.lock'
lockfile = CrewLockfile.new 'test.lock'
lockfile.debug = true
begin
  lockfile.lock
  puts 'During lock:'
  system 'ls test.lock'
  p 42
ensure
  lockfile.unlock
end
puts 'After lock:'
system 'ls test.lock'
