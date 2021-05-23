require 'package'

class Perl_time_hires < Package
  description 'High resolution alarm, sleep, gettimeofday, interval timers Time::HiRes'
  homepage 'https://metacpan.org/release/Time-HiRes'
  version '1.9758-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JH/JHI/Time-HiRes-1.9758.tar.gz'
  source_sha256 '5bfa145bc11e70a8e337543b1084a293743a690691b568493455dedf58f34b1e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_time_hires/1.9758-2_armv7l/perl_time_hires-1.9758-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_time_hires/1.9758-2_armv7l/perl_time_hires-1.9758-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_time_hires/1.9758-2_i686/perl_time_hires-1.9758-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_time_hires/1.9758-2_x86_64/perl_time_hires-1.9758-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ffb188bb4deb933432df4a898c61139feb37a80e109fba522abc6b4ccb0e8e97',
     armv7l: 'ffb188bb4deb933432df4a898c61139feb37a80e109fba522abc6b4ccb0e8e97',
       i686: 'bf2394f78d35cdd3037ea4fd6436cffdb6ecac2376395f76a3bf5ae9a8644deb',
     x86_64: 'b745056ffef107653bcd19139a58bf8f24c8e254656089195c0334bb80069923'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
