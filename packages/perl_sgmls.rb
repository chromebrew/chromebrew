
require 'package'

class Perl_sgmls < Package
  description 'a set of Perl5 routines for processing the output from the onsgmls SGML parsers.'
  homepage 'http://search.cpan.org/dist/SGMLSpm/'
  compatibility 'all'
  version '1.1-1'
  source_url 'https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ab37b70516fc82b41caf4f2fb4d41840cdb25d05ff370f3ac6f61b70352d0d9',
     armv7l: '6ab37b70516fc82b41caf4f2fb4d41840cdb25d05ff370f3ac6f61b70352d0d9',
       i686: 'e2affa6d9cb0e2b5ce47e782c04d18fd1cbd0cb7236ed081c0e2bc75ac5238dc',
     x86_64: 'c04a99f872685d663b89e99ea435e1e62971b234889cc78880d1cb811202e5bd',
  })

  depends_on 'perl_module_build'

  def self.build
  end

  def self.install
    # install files to build directory
     system 'cpanm', '-l', 'build', '.' # remove '--self-contained' here, since it will build module_build again.

    # install lib
    libdir = CREW_DEST_DIR + `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    FileUtils.mkdir_p libdir
    system "(cd build/lib/perl5; tar cf - .) | (cd #{libdir}; tar xfp -)"

    # install man
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_MAN_PREFIX}; tar xfp -)"
  end

  def self.check
  end
end
