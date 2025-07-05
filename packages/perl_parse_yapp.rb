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
    aarch64: 'c057f82c148b2e345dc90b67746023519d5856e203b84f21ee2b26758e66c7e4',
     armv7l: 'c057f82c148b2e345dc90b67746023519d5856e203b84f21ee2b26758e66c7e4',
       i686: '573f89994d4fe1dbaa22ad9fa0af457bad88cb34ebb5e7f7da7472b662c025af',
     x86_64: '05350c4cafcb8f79199a0df6f4b9a38cd10a3c92a533b38a2c795071d31fa043'
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
