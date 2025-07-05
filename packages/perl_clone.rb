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
    aarch64: '6ca76c50746f7cc1a1ff005604cb62aece1dff2853bcbd42fe92e57906a00ab6',
     armv7l: '6ca76c50746f7cc1a1ff005604cb62aece1dff2853bcbd42fe92e57906a00ab6',
       i686: 'b104b0c9fe046ef4268b605d92e7de1bbcd3d67c5e37960a81edbd879e73005f',
     x86_64: 'f03afc1badbf204d6b9718874c9bb9e69d6b1ce9b910510e7be764bfc3c26ff0'
  })

  depends_on 'glibc' # R
end
