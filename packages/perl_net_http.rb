require 'buildsystems/perl'

class Perl_net_http < PERL
  description 'Low-level HTTP connection (client)'
  homepage 'https://metacpan.org/pod/Net::HTTP'
  version "6.24-#{CREW_PERL_VER}"
  license 'BSD'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-#{version.split('-')[0]}.tar.gz"
  source_sha256 '290ed9a97b05c7935b048e6d2a356035871fca98ad72c01c5961726adf85c83c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c41f66e2e7f04c27170454fe4f96a1575ddf74f0173fd27d428b0ba4930eb66',
     armv7l: '1c41f66e2e7f04c27170454fe4f96a1575ddf74f0173fd27d428b0ba4930eb66',
       i686: '1352ab3b76e34a975264e55d4ddd8ab256de76155dcb6ecb9b9cb2632a0028e2',
     x86_64: 'f92f12ba6ae68d7fc1ee5884f605826eb4377d4a6b6499ed71a60e3d856590f5'
  })

  depends_on 'perl' => :logical
end
