require 'buildsystems/perl'

class Perl_extutils_pkgconfig < PERL
  description 'Simplistic interface to pkg-config'
  homepage 'https://metacpan.org/pod/ExtUtils::PkgConfig'
  version "1.16-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-PkgConfig-1.16.tar.gz'
  source_sha256 'bbeaced995d7d8d10cfc51a3a5a66da41ceb2bc04fedcab50e10e6300e801c6e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4423b454498b01fc2219a5b77fd19768e7f181ee84703f966e7457deaa400db3',
     armv7l: '4423b454498b01fc2219a5b77fd19768e7f181ee84703f966e7457deaa400db3',
       i686: '400caa0e3d0f0c6fea973c43bf3371823ffae8bc1e289cf1adbafc526e4ebd17',
     x86_64: '7d5ca28ec027b70b9aa33b57a2f1d9a6c8a2e4fcf1b18273b35ab8ab986cf151'
  })

  depends_on 'perl' => :logical
end
