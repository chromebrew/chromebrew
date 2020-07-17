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
    aarch64: '8bb3990ae8ae820b943beb44e4b180176177b3af132cfae85218b24b3cbb1629',
     armv7l: '8bb3990ae8ae820b943beb44e4b180176177b3af132cfae85218b24b3cbb1629',
       i686: '42ffbe1fe5a9f32d769e546ead28e079a0e4fad8adb2390c3fd0c1bf495bda3c',
     x86_64: '8b8d2e4baef4aad3238cdd476a851a6e3c6eb33fd585dbc59788247f89d8b130',
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
