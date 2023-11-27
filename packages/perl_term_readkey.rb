require 'buildsystems/perl'

class Perl_term_readkey < PErl
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version '2.38-perl5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz'
  source_sha256 '5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.1_armv7l/perl_term_readkey-2.38-perl5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.1_armv7l/perl_term_readkey-2.38-perl5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.1_i686/perl_term_readkey-2.38-perl5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-perl5.38.1_x86_64/perl_term_readkey-2.38-perl5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9dd55311b2cabaf92e61ae8f3bc6a9afe7f3ff964b10d6a9c497b84cd88ed33c',
     armv7l: '9dd55311b2cabaf92e61ae8f3bc6a9afe7f3ff964b10d6a9c497b84cd88ed33c',
       i686: '6407c7d96011d43f75232d768599383106ffbc894daf26d632d3db180d9df3ce',
     x86_64: '955c73be5cd41705eb7b7fa6169abe4c3830e999b06c796c0b0ce206bb219e96'
  })

  depends_on 'glibc' # R
end
