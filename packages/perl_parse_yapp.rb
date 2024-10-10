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
    aarch64: '05f8fdc6ce72778f62b32b65b19e8b8d5c3fccaa63776505e1698c8c60ea3ef1',
     armv7l: '05f8fdc6ce72778f62b32b65b19e8b8d5c3fccaa63776505e1698c8c60ea3ef1',
       i686: '253b0d89b5ecd773533744574f859baa0addb38fcad2462f2d9c1749fd10a720',
     x86_64: '89b2f9d1a1e8d06b5993829bbb9e698f1eda81957ff4f110baa0bf8351233443'
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
