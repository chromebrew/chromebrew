require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version "12.0-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-12.0.tar.gz'
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60582b18b193590e141897772829949643d6fd8241a6dd70bd432b53b291ac08',
     armv7l: '60582b18b193590e141897772829949643d6fd8241a6dd70bd432b53b291ac08',
       i686: 'e300133191696be85aa28eec37fc6bf6f3863956938b40d4631eef7d334547b6',
     x86_64: 'b13c54cf66ec7b325749d7998260ec7d861e3dad2515d73580507d0c52dea71f'
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
