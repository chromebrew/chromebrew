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
    aarch64: '95d61e95d266ee4a7621682212007781338dd278c66045eec8331ac27a45351e',
     armv7l: '95d61e95d266ee4a7621682212007781338dd278c66045eec8331ac27a45351e',
       i686: 'f3d487bdb6c17ebec99d063a555375ff0284d3e0e9e6b6df76314ca8581a5fba',
     x86_64: 'cf33d0a321224085917a965ad74ed2671d8fe30148e4db7fcc333ed1a6dcea35'
  })

  depends_on 'perl' => :logical
end
