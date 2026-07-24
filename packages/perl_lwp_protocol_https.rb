require 'buildsystems/perl'

class Perl_lwp_protocol_https < PERL
  description 'Provide https support for LWP::UserAgent'
  homepage 'https://metacpan.org/pod/LWP::Protocol::https'
  version "6.17-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-#{version.split('-')[0]}.tar.gz"
  source_sha256 '361c7c1eee8cf66812958f975f26ef2e2272a0c6221d2043477cb9c22b8d1c23'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c167b816a9f7007b003ddc9b31a844be5416781f29a5a413040fce6491705dba',
     armv7l: 'c167b816a9f7007b003ddc9b31a844be5416781f29a5a413040fce6491705dba',
       i686: 'c1a314232ac4112abd0a6ce8710a36fa2dd50498f25b5f2706d80e9479b30793',
     x86_64: '7e2be74cf8693f47d66135480273ce74999b5064e495427c954c628cfb69b82e'
  })

  depends_on 'perl' => :logical
end
