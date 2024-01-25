require 'buildsystems/perl'

class Perl_clone < PERL
  description 'Recursively copy Perl datatypes'
  homepage 'https://metacpan.org/pod/Clone'
  version '0.46-perl5.38.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GA/GARU/Clone-0.46.tar.gz'
  source_sha256 'aadeed5e4c8bd6bbdf68c0dd0066cb513e16ab9e5b4382dc4a0aafd55890697b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.2_armv7l/perl_clone-0.46-perl5.38.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.2_armv7l/perl_clone-0.46-perl5.38.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.2_i686/perl_clone-0.46-perl5.38.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_clone/0.46-perl5.38.2_x86_64/perl_clone-0.46-perl5.38.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e87ce66b56d1ac365fccd5e65771b904ee7ef0ed7d924774e0cf83578779a6b7',
     armv7l: 'e87ce66b56d1ac365fccd5e65771b904ee7ef0ed7d924774e0cf83578779a6b7',
       i686: '051184780554ee52bed4e30788c2f5456f0e92eaebcb10e535008f925f2237f4',
     x86_64: 'edd7ae3a5cd0004512318bd213ff37eda913d5870710d52aea2f83c0e94fe8a4'
  })

  depends_on 'glibc' # R
end
