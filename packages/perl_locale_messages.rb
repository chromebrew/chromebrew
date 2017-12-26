require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval.'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.27'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.27.tar.gz'
  source_sha256 '46de373e84e8a178353990b87eeacf9ef4f5c72650248eb20ed9772a65817c6a'

  binary_url ({
  })
  binary_sha256 ({
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
