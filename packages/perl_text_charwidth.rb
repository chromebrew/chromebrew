require 'package'

class Perl_text_charwidth < Package
  description 'Text::CharWidth - Get number of occupied columns of a string on terminals'
  homepage 'https://metacpan.org/pod/Text::CharWidth'
  version '0.04-1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-CharWidth-0.04.tar.gz'
  source_sha256 'abded5f4fdd9338e89fd2f1d8271c44989dae5bf50aece41b6179d8e230704f8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f3d97714e0b0a6004c74c2c0e3ce3b716bbd15faebf67f11b8c3b44744417e22',
     armv7l: 'f3d97714e0b0a6004c74c2c0e3ce3b716bbd15faebf67f11b8c3b44744417e22',
       i686: '876b30f1223dd35171bee51adcc898c2a5a0b2e77837fbcb08aa2d2570790c62',
     x86_64: 'a8b8882ce818811dc8eeb67c42cea8ef9ef3ca53e7c791e031bcf127b69db277',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '.'

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
