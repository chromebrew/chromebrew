require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version '12.0-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-12.0.tar.gz'
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/perl_unicode_eastasianwidth-12.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/perl_unicode_eastasianwidth-12.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/perl_unicode_eastasianwidth-12.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/perl_unicode_eastasianwidth-12.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fe5c4b5bb96413f8e3841d1542961a79d288d57ea7ba49fda5704e9010e4625c',
     armv7l: 'fe5c4b5bb96413f8e3841d1542961a79d288d57ea7ba49fda5704e9010e4625c',
       i686: '5e79c41dec4627a50378058acbc0e815970571127a0dad29128a905eafc889a5',
     x86_64: '55c5256381f12302211179f0a5aedecdd200b8e09fd28564630cc9bbd5294403'
  })

  depends_on 'perl'

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
