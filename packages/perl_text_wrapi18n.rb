require 'package'

class Perl_text_wrapi18n < Package
  description 'Text::WrapI18N - Line wrapping module with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words.'
  homepage 'https://metacpan.org/pod/Text::WrapI18N'
  version '0.06'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-WrapI18N-0.06.tar.gz'
  source_sha256 '4bd29a17f0c2c792d12c1005b3c276f2ab0fae39c00859ae1741d7941846a488'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_wrapi18n-0.06-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3978d40b0eb71c01e5a26d5e4f9069f41a7a8a477db3f1e20060274f503a814a',
     armv7l: '3978d40b0eb71c01e5a26d5e4f9069f41a7a8a477db3f1e20060274f503a814a',
       i686: 'c258b217a57569491a4200c92e07688fc7333b57207025ec760199218ac6a242',
     x86_64: '5725c4a81381834d1c3701e05413d766d6882f98e7a0daf793cadb93e9a20962',
  })

  depends_on 'perl'
  depends_on 'perl_text_charwidth'  # add dependency

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', "build", '.'            #  remove --self-contained

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
