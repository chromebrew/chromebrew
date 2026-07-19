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
    aarch64: '536f68ed7af45a689a9f04f9ce37b7b4352e07f6e92ccf6e46452bfd5db5c020',
     armv7l: '536f68ed7af45a689a9f04f9ce37b7b4352e07f6e92ccf6e46452bfd5db5c020',
       i686: '68bbf9bb8bbbf1e3d7d026bcc36f1b128dfa5b2c4164eb84fb6f181085a01e0b',
     x86_64: '831f122b72f53e73273f174942a07dcadd0b23bc000dfb386ff564c1829e55ea'
  })

  depends_on 'perl' => :logical
end
