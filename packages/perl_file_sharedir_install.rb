require 'buildsystems/perl'

class Perl_file_sharedir_install < PERL
  description 'Install shared files'
  homepage 'https://metacpan.org/pod/File::ShareDir::Install'
  version "0.14-#{CREW_PERL_VER}"
  license 'perl_5'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-ShareDir-Install-#{version.split('-')[0]}.tar.gz"
  source_sha256 'b6af5f4a5e92f1c3d7c9e2a5b9a83c0e2a6f8b9e5d1c3a7b9d2f4e6a8c1d3f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d4ba48d15b57cb39517bd1ed08905c3c622a9ddc0fe09fadf38ed8860901cd3',
     armv7l: '4d4ba48d15b57cb39517bd1ed08905c3c622a9ddc0fe09fadf38ed8860901cd3',
       i686: '74936c8549f2b681706d0127dcd83b00a53c0f3af7db89dbea4eb57dc2f8e016',
     x86_64: 'ab6cef5ce4becd413b5d78acf0842b35da3eda88e1eedf4f039b4c8b1163dac8'
  })

  depends_on 'glibc' # R
  depends_on 'perl' => :logical
end
