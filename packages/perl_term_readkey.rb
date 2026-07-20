require 'buildsystems/perl'

class Perl_term_readkey < PERL
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version "2.38-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz'
  source_sha256 '5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7e6c9f12bce3bbae916995d7b08f90264dcd27759bc87480e7d53dd0d4e8c61',
     armv7l: 'f7e6c9f12bce3bbae916995d7b08f90264dcd27759bc87480e7d53dd0d4e8c61',
       i686: '9e457cd33d87b3c58762f5039552427051a11e2dc05215dcd5b76893655091a4',
     x86_64: '16b4b169e71fdb5630bdf8cae8469a9561e2ce5a75e2064007f4e5e9a27edd4a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
