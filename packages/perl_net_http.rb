require 'buildsystems/perl'

class Perl_net_http < PERL
  description 'Low-level HTTP connection (client)'
  homepage 'https://metacpan.org/pod/Net::HTTP'
  version "6.23-#{CREW_PERL_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.23.tar.gz'
  source_sha256 '0d65c09dd6c8589b2ae1118174d3c1a61703b6ecfc14a3442a8c74af65e0c94e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dfb0454522878959b691f90c995c1e0b25286dff1a32e665ce9a57a03be089d9',
     armv7l: 'dfb0454522878959b691f90c995c1e0b25286dff1a32e665ce9a57a03be089d9',
       i686: '3724d765666073a1d0a84c0934a3797b46ecee912de89a5460cac3a920e17656',
     x86_64: '9d90b4cb557c303608176af3136c4a2c411972785763a82f2fc8c179b18488f9'
  })
end
