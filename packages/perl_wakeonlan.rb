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
    aarch64: 'f552698bee6cf2bf0ee6543a155bc3366ff8baf2ceab0b717da77cc9e0131889',
     armv7l: 'f552698bee6cf2bf0ee6543a155bc3366ff8baf2ceab0b717da77cc9e0131889',
     x86_64: 'b44f0914f06fd909d3db14c122c57ae603207b5739bb77a536f7f88a18fec0d0'
  })
end
