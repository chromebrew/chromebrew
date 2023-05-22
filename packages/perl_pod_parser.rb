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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-2_armv7l/perl_pod_parser-1.63-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-2_armv7l/perl_pod_parser-1.63-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-2_i686/perl_pod_parser-1.63-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-2_x86_64/perl_pod_parser-1.63-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '97cd18fd9d32ee8b9d524e06d9735c21cf8c4a49ba312f035615f6d921649c98',
     armv7l: '97cd18fd9d32ee8b9d524e06d9735c21cf8c4a49ba312f035615f6d921649c98',
       i686: '887a43228afe65ff3fadfd6187d82dacd325e2bcd18647ccde28cf93c345ee47',
     x86_64: '50447fab41d9e1c1d18e6ff73fe111c5b340ef49ac5414940d2ad2c998bef6bd'
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
