require 'package'

class Perl_extutils_pkgconfig < Package
  description 'Simplistic interface to pkg-config'
  homepage 'https://metacpan.org/pod/ExtUtils::PkgConfig'
  version '1.16-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-PkgConfig-1.16.tar.gz'
  source_sha256 'bbeaced995d7d8d10cfc51a3a5a66da41ceb2bc04fedcab50e10e6300e801c6e'

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
