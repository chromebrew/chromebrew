require 'package'

class Perl_pod_parser < Package
  description 'Perl Pod::Parser - base class for creating POD filters and translators'
  homepage 'https://metacpan.org/pod/Pod::Parser'
  version '1.63'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MA/MAREKR/Pod-Parser-1.63.tar.gz'
  source_sha256 'dbe0b56129975b2f83a02841e8e0ed47be80f060686c66ea37e529d97aa70ccd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_pod_parser-1.63-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_pod_parser-1.63-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_pod_parser-1.63-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_pod_parser-1.63-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3b7eabb2c15a0a3dfc325d564ebb50bbb7c03fbc31ab6b6b094f3402c99e7bbf',
     armv7l: '3b7eabb2c15a0a3dfc325d564ebb50bbb7c03fbc31ab6b6b094f3402c99e7bbf',
       i686: '5fe0a77aeef18cbac0075f703a89eda4b729f5270b636c59af194a6ae55d8c6c',
     x86_64: '62d5b260b5da61a1a21adaa5a8fc8a31e0f3e5a312534e506de331c80275c00b',
  })

  depends_on 'perl'

  def self.build
  end

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
