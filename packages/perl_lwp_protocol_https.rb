require 'buildsystems/perl'

class Perl_lwp_protocol_https < PERL
  description 'Provide https support for LWP::UserAgent'
  homepage 'https://metacpan.org/pod/LWP::Protocol::https'
  version "6.14-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.14.tar.gz'
  source_sha256 '59cdeabf26950d4f1bef70f096b0d77c5b1c5a7b5ad1b66d71b681ba279cbb2a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fea84427d5b49f31c6044a35251dea302fac2c3681bdf4d43ffacc7b66d94c4d',
     armv7l: 'fea84427d5b49f31c6044a35251dea302fac2c3681bdf4d43ffacc7b66d94c4d',
       i686: '17820b8d4c880cec57064cc7443ac2586c9717c4aefe7f3851d1211abad82b54',
     x86_64: 'e565d3a9c818f2821c0c57f29fdd3eef6f328d0906fbf7d6d4f4903d8e6cacdb'
  })
end
