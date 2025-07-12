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
    aarch64: '2a1b3563db7c4bb9a470a161ab9decdbdb5413c0f9e8ef86195b0ca8c4976c45',
     armv7l: '2a1b3563db7c4bb9a470a161ab9decdbdb5413c0f9e8ef86195b0ca8c4976c45',
       i686: 'ed7249c6cfa4c1b4127f29926b78720e37dd40f4b24ab474f47358cd98e1b103',
     x86_64: 'a3171927fdb4d37f0aa74329333d3f35d28472697790417e0d9e6548369b0808'
  })
end
