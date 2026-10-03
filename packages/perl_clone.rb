require 'buildsystems/perl'

class Perl_clone < PERL
  description 'Recursively copy Perl datatypes'
  homepage 'https://metacpan.org/pod/Clone'
  version "0.51-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/Clone-#{version.split('-')[0]}.tar.gz"
  source_sha256 'f17f66fec97dacca67ac9585701d2d079cfc80539fe6e8160c201c4e55f67507'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b00f825127b4ece744ee4c96be9defd1e746f621b982452476937001d4fbba6',
     armv7l: '8b00f825127b4ece744ee4c96be9defd1e746f621b982452476937001d4fbba6',
       i686: '92aab63008241f268703c7385079bda1cf0f087cfad77f6941622283f077759e',
     x86_64: '06a6e4b7afe5548e4c497f4c8b6e0b618edb08500cdf4d4ea505f675e3e4c94a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
