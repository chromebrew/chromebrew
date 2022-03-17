require 'package'

class Perl_time_hires < Package
  description 'High resolution alarm, sleep, gettimeofday, interval timers Time::HiRes'
  homepage 'https://metacpan.org/pod/Time::HiRes'
  version '1.9764'
  license 'GPL-1+ or Artistic'
  compatibility 'all'

  # included in main perl package
  is_fake
end
