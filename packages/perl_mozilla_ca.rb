require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version "20221114-#{CREW_PERL_VER}"
  license 'GPL2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/H/HA/HAARG/Mozilla-CA-20221114.tar.gz'
  source_sha256 '701bea67be670add5a102f9f8c879402b4983096b1cb0e20dd47d52d7a10666b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76ceb2503c66965c2b4ebb131158dfab2d4fa2afac522dc1ddf81097a225e544',
     armv7l: '76ceb2503c66965c2b4ebb131158dfab2d4fa2afac522dc1ddf81097a225e544',
       i686: 'ba143242177d1286641449d34be5a03683358b70917a5289a9bdaf30f7050115',
     x86_64: '1476dfa1ce768253cc5abf0d4d0b4a2d513e5b21a162000ea162615db4c5bc22'
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
