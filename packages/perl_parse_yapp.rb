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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-perl5.36_i686/perl_parse_yapp-1.21-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_parse_yapp/1.21-perl5.36_x86_64/perl_parse_yapp-1.21-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '21020fe4999a11b1e03226fe0e9db1c0710a2b5ee60306809562283f7deb8a88',
  x86_64: '3412889bde50e4d41162580b9cfa8b630a0bf13904c3f18a1f42c6fc5f6ec7da'
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
