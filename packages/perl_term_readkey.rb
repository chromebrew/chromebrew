require 'package'

class Perl_term_readkey < Package
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version '2.38'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/J/JS/JSTOWE/TermReadKey-2.38.tar.gz'
  source_sha256 '5a645878dc570ac33661581fbb090ff24ebce17d43ea53fd22e105a856a47290'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_readkey-2.38-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_readkey-2.38-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_readkey-2.38-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_term_readkey-2.38-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94188d0e163fe8dd2ddd02eb2c7737821810b073d999189d3c8d4441f8a17d01',
     armv7l: '94188d0e163fe8dd2ddd02eb2c7737821810b073d999189d3c8d4441f8a17d01',
       i686: '339cd76509bee2cd027fe49e930e5defee969964df1929e969954d1b0b22507f',
     x86_64: 'dcdb8f19f52e221a4b5629a8f7b22e0aab910c714feaf25e6c740614f217a5d9',
  })

  depends_on 'perl'

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

  def self.check
  end
end
