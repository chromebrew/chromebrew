require 'buildsystems/perl'

class Perl_lwp_useragent < PERL
  description 'Web user agent class'
  homepage 'https://metacpan.org/pod/LWP::UserAgent'
  version "6.70-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/libwww-perl-6.70.tar.gz'
  source_sha256 '34f00d2344757b9c0b55ad35808d53e93d7d92f7a464ec837fe6a73c51fb5969'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '609d0b96bb4c10a255a79c82b88c758ec771cf46610a2ffd09ccbac34dd6574a',
     armv7l: '609d0b96bb4c10a255a79c82b88c758ec771cf46610a2ffd09ccbac34dd6574a',
       i686: 'b12dd243561884e0bbfb5b4f0499b2da55580144b80f7fba73242c2b9a90d289',
     x86_64: '825faa26fe9b29ead15c1968613ce1da483011a5ffc800d8b67e52a56201f6b8'
  })

  depends_on 'perl' => :logical
end
