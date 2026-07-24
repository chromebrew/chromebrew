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
    aarch64: '83ae111e50c8d264e150acbd34ab7e0cbb3e2818f098f1681e5a279b355a4ed0',
     armv7l: '83ae111e50c8d264e150acbd34ab7e0cbb3e2818f098f1681e5a279b355a4ed0',
       i686: '30688d36ae2423be8f2ef80c3a4f8756cc02664ec09d32b22222afdad5b23dcf',
     x86_64: 'ff90265877939d81eaea44cc99ee5e4e0960dacc8448ed51a06a8c1e29efad9a'
  })

  depends_on 'perl' => :logical
end
