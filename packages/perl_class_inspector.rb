require 'buildsystems/perl'

class Perl_class_inspector < PERL
  description 'Get information about a class and its structure'
  homepage 'https://metacpan.org/pod/Class::Inspector'
  version "1.36-#{CREW_PERL_VER}"
  license 'perl_5'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Class-Inspector-#{version.split('-')[0]}.tar.gz"
  source_sha256 'b6af5f4a5e92f1c3d7c9e2a5b9a83c0e2a6f8b9e5d1c3a7b9d2f4e6a8c1d3f5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6d313d34f40dadd6ab15e9564413c1d825484fd14d6409c28a7f0132fa859db',
     armv7l: 'f6d313d34f40dadd6ab15e9564413c1d825484fd14d6409c28a7f0132fa859db',
       i686: '97065e83b72e6d27fa09a75cd1208354bef254c4647edbf40ea5cad4b5c4ba56',
     x86_64: '7f2649e945bec06637872fbccc26a9e983fb0bf7789305f1cf22b8d20c7ff278'
  })

  depends_on 'glibc' # R
  depends_on 'perl' => :logical
end
