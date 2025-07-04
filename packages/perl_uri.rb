require 'buildsystems/perl'

class Perl_uri < PERL
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version "5.19-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/URI-5.19.tar.gz'
  source_sha256 '8fed5f819905c8a8e18f4447034322d042c3536b43c13ac1f09ba92e1a50a394'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f00ee92b852fba2ebb7648e5a83eed031b1318f5e0fe6a98dcc0d5878c5a8e9',
     armv7l: '3f00ee92b852fba2ebb7648e5a83eed031b1318f5e0fe6a98dcc0d5878c5a8e9',
       i686: '69b573275ceb40c7f84e0d793b6dcc5caffe5dbdfc1b8c27f6b4800fb39cf4e4',
     x86_64: 'eba395cfc6f82ecb278d74ac18b4a162e43e07c5331f80ef8bd7a821ca8acf3e'
  })
end
