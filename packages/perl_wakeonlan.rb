require 'buildsystems/perl'

class Perl_wakeonlan < PERL
  description 'Perl script for waking up computers via Wake-On-LAN magic packets'
  homepage 'https://github.com/jpoliv/wakeonlan'
  version "4.0.0-#{CREW_PERL_VER}"
  license 'Artistic License 2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jpoliv/wakeonlan.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3049f1a6433c2880ad79e185a6d682283c26842060253418d72efbda8f31ba7',
     armv7l: 'd3049f1a6433c2880ad79e185a6d682283c26842060253418d72efbda8f31ba7',
     x86_64: '0898b5d1d48bbe6db336f217a0dbab7b2044ecf7fbc38a1d2df78ff06623d899'
  })

  depends_on 'perl' => :logical
end
