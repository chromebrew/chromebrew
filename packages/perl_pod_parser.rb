require 'package'

class Perl_pod_parser < Package
  description 'Perl Pod::Parser - base class for creating POD filters and translators'
  homepage 'https://metacpan.org/pod/Pod::Parser'
  version '1.66-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MA/MAREKR/Pod-Parser-1.66.tar.gz'
  source_sha256 '22928a7bffe61b452c05bbbb8f5216d4b9cf9fe2a849b776c25500d24d20df7c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.38_armv7l/perl_pod_parser-1.66-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.38_armv7l/perl_pod_parser-1.66-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.38_i686/perl_pod_parser-1.66-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.38_x86_64/perl_pod_parser-1.66-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a2d19bbbe90f2e1fc2351ea802b54280f2bddc056e82ab4053a480358fd6d94f',
     armv7l: 'a2d19bbbe90f2e1fc2351ea802b54280f2bddc056e82ab4053a480358fd6d94f',
       i686: '192b40849f3605f6eec343f5844b63a7e1e1d80f3f43168f9a85e07dc75a44a7',
     x86_64: 'bb811d28f6789592e2116900f86fc23b2cda4c223e66c1b6915b4facf9a13845'
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
