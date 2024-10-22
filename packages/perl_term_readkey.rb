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
    aarch64: '2f69efe49a70880549248c73bd9b7979d4c172fcc241b8517ed921e57976096e',
     armv7l: '2f69efe49a70880549248c73bd9b7979d4c172fcc241b8517ed921e57976096e',
       i686: 'f81e73e25f83290af7448627745b2069db325bef7fa1e22bfb904c36d8d8207c',
     x86_64: '1b379f1ca9fec9db393d689b0b4d88bb504892da77b90a2fa66ae3809c476dd5'
  })

  depends_on 'glibc' # R
end
