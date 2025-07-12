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
    aarch64: '99c815b1b98cfb9f3623e7696ec8c9fc3e57766c525964bffadd957ea97bc4a4',
     armv7l: '99c815b1b98cfb9f3623e7696ec8c9fc3e57766c525964bffadd957ea97bc4a4',
       i686: '378daa8caabc8642ccda712ec9c0172aff5add412e2d4e5d570d0bd93cf1c043',
     x86_64: 'b66ad11eaa5a7672d690b80b5cec36d32039e67dbcbdd67c71b9dd3db7d3b023'
  })
end
