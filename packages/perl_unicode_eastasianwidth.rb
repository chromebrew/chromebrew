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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-perl5.36_armv7l/perl_unicode_eastasianwidth-12.0-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-perl5.36_armv7l/perl_unicode_eastasianwidth-12.0-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-perl5.36_i686/perl_unicode_eastasianwidth-12.0-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-perl5.36_x86_64/perl_unicode_eastasianwidth-12.0-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fffb5ae93e047955c1d23884d57096d2ddc89421a3618b6e01eec821a8932aa4',
     armv7l: 'fffb5ae93e047955c1d23884d57096d2ddc89421a3618b6e01eec821a8932aa4',
       i686: 'de7609f68c9554ae6f24089862d5adc56d7024608888170431a98d3d8724876d',
     x86_64: 'e2e72c7e9624ba4f97190fbfa038dd3c7dbb1636ab2c31e56ed8af0c86d78746'
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
