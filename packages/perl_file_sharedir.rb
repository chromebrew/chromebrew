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
    aarch64: '6b9072a60b18b0a963d218e1772e2215b0e811baf61ab61aae075c403b6f7d00',
     armv7l: '6b9072a60b18b0a963d218e1772e2215b0e811baf61ab61aae075c403b6f7d00',
       i686: '72b010811049bcb1007ea820feee1dcf9bb0d69c6f1a2ab004e1b2c5114f7430',
     x86_64: '3a8ccaedb1763ec9860762a7258deef693b85e8b9bf2d0ee1c1cdde95c758328'
  })

  depends_on 'glibc' # R
  depends_on 'perl' => :logical
end
