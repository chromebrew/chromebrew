require 'buildsystems/perl'

class Perl_term_readkey < PERL
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version '2.38-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz'
  source_sha256 '5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.2_armv7l/perl_term_readkey-2.38-perl5.38.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.2_armv7l/perl_term_readkey-2.38-perl5.38.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.2_i686/perl_term_readkey-2.38-perl5.38.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.2_x86_64/perl_term_readkey-2.38-perl5.38.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '28012fd0e4f95d2eeb7debda4f183aa688fd092958c3e7160ac6e0235f03fb86',
     armv7l: '28012fd0e4f95d2eeb7debda4f183aa688fd092958c3e7160ac6e0235f03fb86',
       i686: '4ab79ff75422e43092e2b9a0cdc06c2604ca2fca726b2749a6dc1e7cbcfa706e',
     x86_64: '91138c0fac8d7ae96c18f37cda72330fc54fdb40551cfd39584e4e1f72f6eab5'
  })

  depends_on 'glibc' # R
end
