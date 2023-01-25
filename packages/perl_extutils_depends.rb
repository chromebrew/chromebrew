require 'package'

class Perl_extutils_depends < Package
  description 'Easily build XS extensions that depend on XS extensions'
  homepage 'https://metacpan.org/pod/ExtUtils::Depends'
  version '0.8001'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-Depends-0.8001.tar.gz'
  source_sha256 '673c4387e7896c1a216099c1fbb3faaa7763d7f5f95a1a56a60a2a2906c131c5'

  depends_on 'perl_data_dumper'
  depends_on 'perl_extutils_makemaker'
  depends_on 'perl_file_spec'
  depends_on 'perl_io_file'

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
