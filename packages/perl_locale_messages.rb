require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval.'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.29'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.29.tar.gz'
  source_sha256 '78935f10db6d6a080c3160b4ae02c3f6ed07ef6bf624623295a87545e0cbfbb1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_messages-1.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f882f4e99637315fa64b43b5e801714f32cc451efbdde2adbe4544cba9599b72',
     armv7l: 'f882f4e99637315fa64b43b5e801714f32cc451efbdde2adbe4544cba9599b72',
       i686: 'd09491828102b107c0b3e944414a54b3bc22d643de39f5e7d5bd572c806a8785',
     x86_64: 'd4e294eaee1da9208dbe5d7fd844a455e106d20eff826e7e6339e2e11c6ed5c3',
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
