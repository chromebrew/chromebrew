require 'buildsystems/perl'

class Perl_try_tiny < PERL
  description 'Minimal try/catch with proper preservation of $@'
  homepage 'https://metacpan.org/pod/Try::Tiny'
  version "0.31-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.31.tar.gz'
  source_sha256 '3300d31d8a4075b26d8f46ce864a1d913e0e8467ceeba6655d5d2b2e206c11be'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a29dc1da7faa393104c7292811ab0035e2fbccc269707a60c9a1e125fb1ba900',
     armv7l: 'a29dc1da7faa393104c7292811ab0035e2fbccc269707a60c9a1e125fb1ba900',
       i686: '1268b021f833913a8d43734ab584f1ed9b893d3d406f53650896e978e4072901',
     x86_64: '765b8aa77cb8f2e2fa54377cd5d818daba9ce722598f24977eaf60fffade115d'
  })
end
