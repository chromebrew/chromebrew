require 'package'

class Perl_io_file < Package
  description 'Supply object methods for filehandles'
  homepage 'https://metacpan.org/pod/IO::File'
  version '1.51-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/IO-1.51.tar.gz'
  source_sha256 '5493ea55998728cd2b7ecb8234c58fb5d5df27098d0f07addca22444d7616ce0'

  depends_on 'perl_file_temp' => :build

  no_compile_needed

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
