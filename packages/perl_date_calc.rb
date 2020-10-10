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
    aarch64: '3814f76c7a5a978752feaeda8e8b69b2cd6464e862749c28c9db9984a573f9c9',
     armv7l: '3814f76c7a5a978752feaeda8e8b69b2cd6464e862749c28c9db9984a573f9c9',
       i686: 'e32643c29b7a584b795d798b04f43fa1dce5709e0b5aa640ea0d1377115b3e29',
     x86_64: '41473868421126d03723e7abb31183e1bd7dfa4178cbd6c6065f4cbe2712dee4',
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
