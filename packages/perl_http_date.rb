require 'buildsystems/perl'

class Perl_http_date < PERL
  description 'Date conversion routines'
  homepage 'https://metacpan.org/pod/HTTP::Date'
  version "6.06-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Date-6.06.tar.gz'
  source_sha256 '7b685191c6acc3e773d1fc02c95ee1f9fae94f77783175f5e78c181cc92d2b52'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86e153dfc0567fa28b18062c080ef7ca36e90bb3b6150ebaf9e2c42eb21d8f40',
     armv7l: '86e153dfc0567fa28b18062c080ef7ca36e90bb3b6150ebaf9e2c42eb21d8f40',
       i686: '16a1ac9dacc5fe8a61345f50fa54755c88975b982fff1bed342121f530939dbc',
     x86_64: '173a5af056917a35a535fbdd29c780bc461f419d74021b0f74fa617699802f23'
  })

  depends_on 'perl' => :logical
end
