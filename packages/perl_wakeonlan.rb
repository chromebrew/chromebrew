require 'buildsystems/perl'

class Perl_wakeonlan < PERL
  description 'Perl script for waking up computers via Wake-On-LAN magic packets'
  homepage 'https://github.com/jpoliv/wakeonlan'
  version "0.42-#{CREW_PERL_VER}"
  license 'Artistic License 2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jpoliv/wakeonlan.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e41249d19d251fff7f4ebf7a7341abd8a815aca941403b80d7c2f90285edceee',
     armv7l: 'e41249d19d251fff7f4ebf7a7341abd8a815aca941403b80d7c2f90285edceee',
     x86_64: '0898b5d1d48bbe6db336f217a0dbab7b2044ecf7fbc38a1d2df78ff06623d899'
  })

  depends_on 'perl' => :logical
end
