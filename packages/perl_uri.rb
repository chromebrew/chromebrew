require 'buildsystems/perl'

class Perl_uri < PERL
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version "5.37-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/URI-#{version.split('-')[0]}.tar.gz"
  source_sha256 '5a8750ddd8ee743d7cc89bebdd542a9b78a34023164ebe19dea0c248e121c21e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bea9ff3f7486cd583311eda8ce0b65d2d6de92af5021181fbaa17a59cacb0a8b',
     armv7l: 'bea9ff3f7486cd583311eda8ce0b65d2d6de92af5021181fbaa17a59cacb0a8b',
       i686: '6ffd7b931540f6beac9c2c911806888df15a535fd511991e7bdd9ff9e0ba83b7',
     x86_64: 'be11ed556c70ad8e6e849d0bfa78f5f7d8af0288b0d3e9cbf92989ae37645fa3'
  })

  depends_on 'perl' => :logical
end
