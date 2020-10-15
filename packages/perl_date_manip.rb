require 'package'

class Perl_date_manip < Package
  description 'Date manipulation routines'
  homepage 'https://metacpan.org/pod/Date::Manip'
  version '6.82'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBECK/Date-Manip-6.82.tar.gz'
  source_sha256 'fa96bcf94c6b4b7d3333f073f5d0faad59f546e5aec13ac01718f2e6ef14672a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_manip-6.82-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_manip-6.82-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_manip-6.82-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_manip-6.82-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '114afa63adb7758a46d04deba5917617872662dd440ab6dc3f5e89dfb547fced',
     armv7l: '114afa63adb7758a46d04deba5917617872662dd440ab6dc3f5e89dfb547fced',
       i686: '1d1d2202e2cca01e13660c8b9c3f430749d5c3619916de0e04a0c2072209da29',
     x86_64: 'ab630a996ee8119a67846d16f51a0749e38a0ab6b46f9c6495304e09a03c4c03',
  })

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
