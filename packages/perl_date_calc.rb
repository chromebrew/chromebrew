require 'package'

class Perl_date_calc < Package
  description 'Gregorian calendar date calculations'
  homepage 'https://metacpan.org/pod/Date::Calc'
  version '6.4'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/ST/STBEY/Date-Calc-6.4.tar.gz'
  source_sha256 '7ce137b2e797b7c0901f3adf1a05a19343356cd1f04676aa1c56a9f624f859ad'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_calc-6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_calc-6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_calc-6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_date_calc-6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '90ad46018f2e5c87be03c6af856c5dcb0b7a48374be980be47c6e1a79c5c36d8',
     armv7l: '90ad46018f2e5c87be03c6af856c5dcb0b7a48374be980be47c6e1a79c5c36d8',
       i686: '0d4b3245024b920cc13334882bdd005c40acc291d4c7cd9791497aed63b404df',
     x86_64: '9ef0460ae307268e3855b9060bb424a158afc59f15ed6c88c2b6d9fdaa908e99',
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
