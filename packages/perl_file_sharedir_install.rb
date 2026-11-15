require 'buildsystems/perl'

class Perl_file_sharedir_install < PERL
  description 'Install shared files'
  homepage 'https://metacpan.org/pod/File::ShareDir::Install'
  version "0.14-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-ShareDir-Install-#{version.split('-')[0]}.tar.gz"
  source_sha256 '2290d61bf5c39882fc3311da9ce1c7f42dbdf825ae169e552c59fe4598b36f4a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64d27a1756daf4887e052c38277e7d765f7b843cdc8d3d584834e31225052884',
     armv7l: '64d27a1756daf4887e052c38277e7d765f7b843cdc8d3d584834e31225052884',
       i686: '36b6373040ce32fc2114a8198f1e45472d1a0e9d8a5a79e6b6e5dd9c107d1478',
     x86_64: '3ba8a037c700891a016f20a5f70f95c972c5e5cb8815d75517ab9028bb549d6d'
  })

  depends_on 'perl' => :logical
end
