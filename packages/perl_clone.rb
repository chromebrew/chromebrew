require 'buildsystems/perl'

class Perl_clone < PERL
  description 'Recursively copy Perl datatypes'
  homepage 'https://metacpan.org/pod/Clone'
  version "0.46-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GA/GARU/Clone-0.46.tar.gz'
  source_sha256 'aadeed5e4c8bd6bbdf68c0dd0066cb513e16ab9e5b4382dc4a0aafd55890697b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '593bf4cbdce1450f55acc8f5dc427072525fef2eec11ef1cb4ef3fe5f5aed89b',
     armv7l: '593bf4cbdce1450f55acc8f5dc427072525fef2eec11ef1cb4ef3fe5f5aed89b',
       i686: '60a27fb2091843378c6a16c502c50410bce12b2e08c697c05e3de2194c2b4eb9',
     x86_64: 'f0ccd2b9be7065a515fdc0770fbe8c3f0d37e06f1888e8a876d9abbd94edb2c6'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
