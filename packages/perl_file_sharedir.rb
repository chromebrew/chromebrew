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
    aarch64: 'cc5fb93dc5843c6ece12e1ab8685f444588949b8582c89ed4e400d8da84339ad',
     armv7l: 'cc5fb93dc5843c6ece12e1ab8685f444588949b8582c89ed4e400d8da84339ad',
       i686: 'f8a2e6fc1f4092b108d6f99c14636e92db511bf417625549dcb84525a55cec20',
     x86_64: '7b203b997b221cc748e7315bd450c24d75065292ea9f500b99525a8f5c4b7bc7'
  })

  depends_on 'glibc' # R
  depends_on 'perl' => :logical
end
