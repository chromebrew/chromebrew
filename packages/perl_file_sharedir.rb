require 'buildsystems/perl'

class Perl_file_sharedir < PERL
  description 'Locate per-dist and per-module shared files'
  homepage 'https://metacpan.org/pod/File::ShareDir'
  version "1.118-#{CREW_PERL_VER}"
  license 'perl_5'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/File-ShareDir-#{version.split('-')[0]}.tar.gz"
  source_sha256 'b6af5f4a5e92f1c3d7c9e2a5b9a83c0e2a6f8b9e5d1c3a7b9d2f4e6a8c1d3f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '941c48253ab405feb3647901c669582decac025bba88e9a54eac8789a1642930',
     armv7l: '941c48253ab405feb3647901c669582decac025bba88e9a54eac8789a1642930',
       i686: '2cc1aabec1a7c6a662a6bad240f2379e3e353b9fd0329f1d120733a91cddce69',
     x86_64: '7b203b997b221cc748e7315bd450c24d75065292ea9f500b99525a8f5c4b7bc7'
  })

  depends_on 'glibc' # R
  depends_on 'perl' => :logical
end
