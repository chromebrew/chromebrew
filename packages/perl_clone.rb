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
    aarch64: '67a60150158e7bd4c531e21cc30e2020a830918eb4a4f1a1fa3c6aabf4a47ca8',
     armv7l: '67a60150158e7bd4c531e21cc30e2020a830918eb4a4f1a1fa3c6aabf4a47ca8',
       i686: 'b00732779d9edf94afd260cb4df3e12b1655bbf2dea3e55c92d6524b99196381',
     x86_64: '44a31f52254b691e2129a75a13dcdb90663940da9c73fdc29103cd2988406bad'
  })

  depends_on 'glibc' # R
end
