
require 'package'

class Perl_sgmls < Package
  description 'a set of Perl5 routines for processing the output from the onsgmls SGML parsers.'
  homepage 'http://search.cpan.org/dist/SGMLSpm/'
  compatibility 'all'
  version '1.1'
  source_url 'http://search.cpan.org/CPAN/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'   # can not install it if using https://
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_sgmls-1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ca57ff49308f61c1c48a8ea4592dc1a3283522cc86ac638eadfc05948e4c96f',
     armv7l: '5ca57ff49308f61c1c48a8ea4592dc1a3283522cc86ac638eadfc05948e4c96f',
       i686: '3788e14aada718fca83522f402afd2c8ac49524cc797dbd7ab155ca84d9bb3e7',
     x86_64: '3d2b15ddb42f1ae17d1adc7062859355a7e5de56af48dacabe7fead5ee2159de',
  })

  depends_on 'perl'
  depends_on 'perl_module_build'

  def self.build
  end

  def self.install
    # install files to build directory
     system 'cpanm', '-l', "build", '.'      # remove '--self-contained' here, since it will build module_build again.

    # install lib
    libdir = `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    system "mkdir -p #{CREW_DEST_DIR}#{libdir}"
    system "(cd build/lib/perl5; tar cf - .) | (cd #{CREW_DEST_DIR}#{libdir}; tar xfp -)"

    # install man
    mandir = "#{CREW_PREFIX}/share/man"
    system "mkdir -p #{CREW_DEST_DIR}#{mandir}"
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_DIR}#{mandir}; tar xfp -)"
  end

  def self.check
  end
end
