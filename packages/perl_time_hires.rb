require 'package'
require_relative 'perl'

class Perl_time_hires < Package
  description 'High resolution alarm, sleep, gettimeofday, interval timers Time::HiRes'
  homepage 'https://metacpan.org/pod/Time::HiRes'
  version Perl.version
  license 'GPL-1+ or Artistic'
  compatibility 'all'

  # included in main perl package
  is_fake
end
