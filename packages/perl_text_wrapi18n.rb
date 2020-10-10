require 'package'

class Perl_text_wrapi18n < Package
  description 'Text::WrapI18N - Line wrapping module with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words.'
  homepage 'https://metacpan.org/pod/Text::WrapI18N'
  version '0.06-1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz'
  source_sha256 '4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '87bebe91adc2d9b6b288691dace869f93e51a828086174d8c9380665dc7267a5',
     armv7l: '87bebe91adc2d9b6b288691dace869f93e51a828086174d8c9380665dc7267a5',
       i686: '3e5e0d3bdea86b958a2fdfe990f51055e9e35ea761ab525c6063dbeed4a1b7bb',
     x86_64: 'bef63d98fe23d6963d97c60051874e586ef7765b1284b62e8847832a73f5ff5d',
  })

  depends_on 'perl_text_charwidth'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '.' #  remove --self-contained

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
