require 'buildsystems/perl'

class Perl_io_socket_ssl < PERL
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version "2.085-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-#{version.split('-')[0]}.tar.gz"
  source_sha256 '95b2f7c0628a7e246a159665fbf0620d0d7835e3a940f22d3fdd47c3aa799c2e'

  depends_on 'perl_net_ssleay' => :build
  depends_on 'perl_mozilla_ca' => :build

  no_compile_needed
end
