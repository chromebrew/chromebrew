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

  binary_sha256({
       i686: '376fdd0a49a574a39887454f0755da0e914d7210ef9fa6a00bface7752645c94',
    aarch64: '60354febd64e3544451accd949326e468fd4c095f71333e9a0e378b6fef9ee77',
     armv7l: '60354febd64e3544451accd949326e468fd4c095f71333e9a0e378b6fef9ee77',
     x86_64: '4a3aaa0fb624733b8d7a95ff32d3fbfc89db3505aca06add445d502949c9a6ef'
  })
end
