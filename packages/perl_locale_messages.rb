require 'package'

class Perl_locale_messages < Package
  description 'Perl Locale::Messages - Gettext Like Message Retrieval.'
  homepage 'https://metacpan.org/pod/Locale::Messages'
  version '1.27'
  source_url 'https://cpan.metacpan.org/authors/id/G/GU/GUIDO/libintl-perl-1.27.tar.gz'
  source_sha256 '46de373e84e8a178353990b87eeacf9ef4f5c72650248eb20ed9772a65817c6a'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/perl_locale_messages-1.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/perl_locale_messages-1.27-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/perl_locale_messages-1.27-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/perl_locale_messages-1.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ba76a389c59fff402dd111a0bb919379a11180ff019e10f7f23b7a380477dd20',
     armv7l: 'ba76a389c59fff402dd111a0bb919379a11180ff019e10f7f23b7a380477dd20',
       i686: '9070c6e3b5f8c7e3f9fa7896372f619cfd5493880d2f3f8a04858c9428389e43',
     x86_64: '37b149b5620e590f52deee28d65854ddb26d3a43cd4872dd6a4f1fd9fd7d72b2',
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
