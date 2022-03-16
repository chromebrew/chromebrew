require 'package'

class Perl_time_hires < Package
  description 'High resolution alarm, sleep, gettimeofday, interval timers Time::HiRes'
  homepage 'https://metacpan.org/pod/Time::HiRes'
  version '1.9764'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JH/JHI/Time-HiRes-1.9764.tar.gz'
  source_sha256 'f33c27745f2bd87344be790465ef984a972fd539dc83bd4f61d4242c607ef1ee'

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
