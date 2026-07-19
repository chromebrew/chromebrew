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
    aarch64: '3f688c805954e8d5bd169f8e740f56f8c3eb70e54dba21f544249bcb779bad6d',
     armv7l: '3f688c805954e8d5bd169f8e740f56f8c3eb70e54dba21f544249bcb779bad6d',
       i686: '7da6d33ccd9e11e85e7c5e3418bee0e9f343607dbfce2029d9f441010a846412',
     x86_64: '173a5af056917a35a535fbdd29c780bc461f419d74021b0f74fa617699802f23'
  })

  depends_on 'perl' => :logical
end
