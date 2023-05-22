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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-perl5.36_armv7l/perl_parse_yapp-1.21-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-perl5.36_armv7l/perl_parse_yapp-1.21-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-perl5.36_i686/perl_parse_yapp-1.21-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-perl5.36_x86_64/perl_parse_yapp-1.21-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '145404b46b6233574722501bd2d62607747a298acea349775e3c124f8ce21afc',
     armv7l: '145404b46b6233574722501bd2d62607747a298acea349775e3c124f8ce21afc',
       i686: 'c83eafaeac3154d10ca98c5292cdfff47fd0008dbff719cb9aac0bfa7fc5f21f',
     x86_64: 'db2870b693b23de95e031ea6f5b8c636e50d05ae86b4793d7b2a06935c0e7978'
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
