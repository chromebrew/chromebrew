require 'buildsystems/perl'

class Perl_try_tiny < PERL
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version "0.32-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-#{version.split('-')[0]}.tar.gz"
  source_sha256 'ef2d6cab0bad18e3ab1c4e6125cc5f695c7e459899f512451c8fa3ef83fa7fc0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb2f1ad7b3f9a7d3323bbfa3d6a19cb7b296013aaee3a2b33cd8e57c1d0f8820',
     armv7l: 'cb2f1ad7b3f9a7d3323bbfa3d6a19cb7b296013aaee3a2b33cd8e57c1d0f8820',
       i686: '12d6c00315bf3be03d935ace7e699ea1a26542628ce7f14a3009555415a2e0db',
     x86_64: 'bdb650e2bc04fc34836e6a7d17289bfe3c102223fae865ee954cf11692e4df2b'
  })

  depends_on 'perl' => :logical
end
