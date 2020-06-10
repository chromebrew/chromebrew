require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version '1.30'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-1.30.tar.gz'
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9fff94d0d53791b6bb6715667bd64969f92391eec6f39bd3117a358de01843c',
     armv7l: 'e9fff94d0d53791b6bb6715667bd64969f92391eec6f39bd3117a358de01843c',
       i686: 'b1bef306347759d19448beb7cfaddafe5d5222f6ba3b8305796a6f01bd5c31fa',
     x86_64: 'bfcee9cb5a3315a021cea9f6bfb5a225d0b20690c66af7ffa6bfedefc7883749',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', "build", '--self-contained', '.'

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
