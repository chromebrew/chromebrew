require 'buildsystems/perl'

class Perl_http_request < PERL
  description 'HTTP style request message'
  homepage 'https://metacpan.org/pod/HTTP::Request'
  version "6.46-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.46.tar.gz'
  source_sha256 'e27443434150d2d1259bb1e5c964429f61559b0ae34b5713090481994936e2a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0586f35dc60804921201d76639a33312b67d61e500254352fa8fc42d6b2a0da1',
     armv7l: '0586f35dc60804921201d76639a33312b67d61e500254352fa8fc42d6b2a0da1',
       i686: '251184391943dd3fb28cb364f66ff2d58264e0d08f3df99cd7e06fc513d9b897',
     x86_64: '21f055b784e8515c4922098c3fa4f13e6ad5cb3c5a5d46b79109dc1ed3c86c3c'
  })
end
