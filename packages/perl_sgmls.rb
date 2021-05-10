require 'package'

class Perl_sgmls < Package
  description 'a set of Perl5 routines for processing the output from the onsgmls SGML parsers.'
  homepage 'http://search.cpan.org/dist/SGMLSpm/'
  version '1.1-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-2_armv7l/perl_sgmls-1.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-2_armv7l/perl_sgmls-1.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-2_i686/perl_sgmls-1.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-2_x86_64/perl_sgmls-1.1-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bd2e6e4160a9ba8357f88c438641eb2d9147c0346467a046a0434a41ee391d7b',
     armv7l: 'bd2e6e4160a9ba8357f88c438641eb2d9147c0346467a046a0434a41ee391d7b',
       i686: 'c5d9783e0d0394548a6fbf6ee2f34e14dd3c5c4cd696f6b9ae36e1af268077d7',
     x86_64: 'a11acbe5d5f8ccb9da8eb99144e199253b71d8798f886bb8c1652a2a359b64ad'
  })

  depends_on 'perl_module_build'

  def self.build; end

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

  def self.check; end
end
