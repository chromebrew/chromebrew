require 'buildsystems/perl'

class Perl_wakeonlan < PERL
  description 'Perl script for waking up computers via Wake-On-LAN magic packets'
  homepage 'https://github.com/jpoliv/wakeonlan'
  version "0.42-#{CREW_PERL_VER}"
  license 'Artistic License 2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/jpoliv/wakeonlan.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05bd7ac933c2f0b3210152456284bfc212bc03bbf352b3c5dfefcf397e356219',
     armv7l: '05bd7ac933c2f0b3210152456284bfc212bc03bbf352b3c5dfefcf397e356219',
     x86_64: 'bcb13535f88f4985f3424ed9fa0cad07c97e2bec23d53e48e1b8fbdd5f9367fb'
  })
end
