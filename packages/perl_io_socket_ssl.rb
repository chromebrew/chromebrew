require 'buildsystems/perl'

class Perl_io_socket_ssl < PERL
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version "2.099-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-#{version.split('-')[0]}.tar.gz"
  source_sha256 'a0be800ff4852b1567ee5500e772417ad7a360abff80c01b5b875c15d44be832'

  depends_on 'perl_net_ssleay' => :build
  depends_on 'perl_mozilla_ca' => :build

  no_compile_needed
end
