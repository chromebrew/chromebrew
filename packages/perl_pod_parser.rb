require 'package'

class Perl_pod_parser < Package
  description 'Perl Pod::Parser - base class for creating POD filters and translators'
  homepage 'https://metacpan.org/pod/Pod::Parser'
  version '1.66-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MA/MAREKR/Pod-Parser-1.66.tar.gz'
  source_sha256 '22928a7bffe61b452c05bbbb8f5216d4b9cf9fe2a849b776c25500d24d20df7c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.36_armv7l/perl_pod_parser-1.66-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.36_armv7l/perl_pod_parser-1.66-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.36_i686/perl_pod_parser-1.66-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.66-perl5.36_x86_64/perl_pod_parser-1.66-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3536772cd99d5a8aa6d92131d3d1905259ddf8b63e26f5a65c74029c2cc26328',
     armv7l: '3536772cd99d5a8aa6d92131d3d1905259ddf8b63e26f5a65c74029c2cc26328',
       i686: 'b4daf273402c5f29ba5727625e8a4659e1042f55e5b07c782f8a873df6e70ddb',
     x86_64: '2a649edda3da6ded476499a548db57120576ca51123d417f22f2ff95ec8845d1'
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
