require 'buildsystems/perl'

class Perl_net_http < PERL
  description 'Low-level HTTP connection (client)'
  homepage 'https://metacpan.org/pod/Net::HTTP'
  version '6.23-perl5.40'
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.23.tar.gz'
  source_sha256 '0d65c09dd6c8589b2ae1118174d3c1a61703b6ecfc14a3442a8c74af65e0c94e'
  binary_compression 'tar.zst'

  no_compile_needed
end
