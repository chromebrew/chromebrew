require 'buildsystems/perl'

class Perl_extutils_pkgconfig < PERL
  description 'Simplistic interface to pkg-config'
  homepage 'https://metacpan.org/pod/ExtUtils::PkgConfig'
  version '1.16-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-PkgConfig-1.16.tar.gz'
  source_sha256 'bbeaced995d7d8d10cfc51a3a5a66da41ceb2bc04fedcab50e10e6300e801c6e'
  binary_compression 'tar.zst'

  no_compile_needed
end
