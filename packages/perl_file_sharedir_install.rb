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
    aarch64: 'e598e9f3c1fb13d0d27415cc7a65d2e1941627e8e638416dbf2d76edde9ab843',
     armv7l: 'e598e9f3c1fb13d0d27415cc7a65d2e1941627e8e638416dbf2d76edde9ab843',
       i686: '1d575b917356553d42d6085a2898e38c7333863836080255a04cd0f085f4c1f4',
     x86_64: '3ba8a037c700891a016f20a5f70f95c972c5e5cb8815d75517ab9028bb549d6d'
  })

  depends_on 'perl' => :logical
end
