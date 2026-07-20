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
    aarch64: '1a683cd6c3cf5ed7f59ea93f57a8d3da4e6af23db9b3925c75fc2fb8048d2e00',
     armv7l: '1a683cd6c3cf5ed7f59ea93f57a8d3da4e6af23db9b3925c75fc2fb8048d2e00',
       i686: '12900eae6da005182200f59fa2a41c5fe93ced5471fdc17cc010c64b9baccf8a',
     x86_64: '2a8d6c52d4bfae3b6bee51f4aab5f2661c68d2a3405a89db5394adca55f58ee3'
  })

  depends_on 'perl' => :logical
end
