require 'package'

class Perl_parse_yapp < Package
  description 'Parse::Yapp - Perl extension for generating and using LALR parsers.'
  homepage 'https://metacpan.org/pod/Parse::Yapp'
  version "1.21-#{CREW_PERL_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/W/WB/WBRASWELL/Parse-Yapp-1.21.tar.gz'
  source_sha256 '3810e998308fba2e0f4f26043035032b027ce51ce5c8a52a8b8e340ca65f13e5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5818d7ca01c925e0a3a1b9b1e9a68cddd1c4e4e3c7bd1452b66910151bedf2ba',
     armv7l: '5818d7ca01c925e0a3a1b9b1e9a68cddd1c4e4e3c7bd1452b66910151bedf2ba',
       i686: '1c1178e0cf8a48ce5d82c4f64f0e637b942e785ca0ec140de73ec2936c71dc1f',
     x86_64: '26b260d04207147e0434439333cb6e533d8b31aa99478e38ec90fbaafcbf65ac'
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
