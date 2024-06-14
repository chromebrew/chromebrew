require 'buildsystems/perl'

class Perl_uri < PERL
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version '5.19-perl5.40'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/URI-5.19.tar.gz'
  source_sha256 '8fed5f819905c8a8e18f4447034322d042c3536b43c13ac1f09ba92e1a50a394'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '4ce90ee55cefda0811b939b46bbf93ab397ae74388ae9042f91d749a9b605115',
    aarch64: '27db52f862cb79a9d36f21dedcb1e326b1e60d094beb33d91355126e3fac70a4',
     armv7l: '27db52f862cb79a9d36f21dedcb1e326b1e60d094beb33d91355126e3fac70a4',
     x86_64: '7e86ddc84a6ae56deb345a03fb1b162a6333c531bdff539306ea264a7717dae2'
  })
end
