require 'package'

class Perl_parse_yapp < Package
  description 'Parse::Yapp - Perl extension for generating and using LALR parsers.'
  homepage 'https://metacpan.org/pod/Parse::Yapp'
  version '1.21-perl5.36'
  license 'GPL'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/W/WB/WBRASWELL/Parse-Yapp-1.21.tar.gz'
  source_sha256 '3810e998308fba2e0f4f26043035032b027ce51ce5c8a52a8b8e340ca65f13e5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-1_armv7l/perl_parse_yapp-1.21-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-1_armv7l/perl_parse_yapp-1.21-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-1_i686/perl_parse_yapp-1.21-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-1_x86_64/perl_parse_yapp-1.21-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5dda591925731219ea3047d0f323a26838ba93db258044dffded63895670ef6a',
     armv7l: '5dda591925731219ea3047d0f323a26838ba93db258044dffded63895670ef6a',
       i686: '236dd0236351c72cbf0ff69d87769d8aa7c9e34c371408b073724e31541bd94c',
     x86_64: '80e5532ac054c4617f2c5d036d5751ac26d2c8ef3213d55d3a2cbe119495b6af'
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
