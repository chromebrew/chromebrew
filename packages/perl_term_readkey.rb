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
    aarch64: '41d94360e2441fdeb0211b04ff15605675a061ac1b3a6c5da7001b1299bafcbf',
     armv7l: '41d94360e2441fdeb0211b04ff15605675a061ac1b3a6c5da7001b1299bafcbf',
       i686: '69f6ceacb2ac536eaec1ae28bfae806b1ef3fcc5437409b67b30f6f439f4e155',
     x86_64: '5ba6f645f563f2b437c5ecac013019328831d57c81c6e535f13256f242fade15'
  })

  depends_on 'glibc' # R
end
