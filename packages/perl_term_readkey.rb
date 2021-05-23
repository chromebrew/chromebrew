require 'package'

class Perl_term_readkey < Package
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version '2.38-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz'
  source_sha256 '5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-1_armv7l/perl_term_readkey-2.38-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-1_armv7l/perl_term_readkey-2.38-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-1_i686/perl_term_readkey-2.38-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_term_readkey/2.38-1_x86_64/perl_term_readkey-2.38-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9cf3b95873bdfc2ba4e05c01afb25fec814f38d8601e766cbee82c86a7c46618',
     armv7l: '9cf3b95873bdfc2ba4e05c01afb25fec814f38d8601e766cbee82c86a7c46618',
       i686: '8e312e6fa55096ff34a84852c6056860ce377e8d5ddb2bbad68db29e08a4cc30',
     x86_64: '85630e55516ebd09fb3b7f7c5a089062952a7352a7136579ef7e30ba8b4c373a'
  })

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '--force', '.'

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
