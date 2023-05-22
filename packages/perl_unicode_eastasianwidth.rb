require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version '12.0-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-12.0.tar.gz'
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-3_armv7l/perl_unicode_eastasianwidth-12.0-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-3_armv7l/perl_unicode_eastasianwidth-12.0-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-3_i686/perl_unicode_eastasianwidth-12.0-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-3_x86_64/perl_unicode_eastasianwidth-12.0-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3b835e5f74b86606da08cf160c10a39746b259ef16cddcd7841406d0c65f3e40',
     armv7l: '3b835e5f74b86606da08cf160c10a39746b259ef16cddcd7841406d0c65f3e40',
       i686: 'e20824f9b8574b51cc6765297686d426ac0cc294db24d587cdb55ab1fbf95dff',
     x86_64: 'd53287ba65526e878280aeec684193f34dc30738d1c99f80ff503f6d4c01b151'
  })

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
