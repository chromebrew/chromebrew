require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version '0.4224'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4224.tar.gz'
  source_sha256 'a6ca15d78244a7b50fdbf27f85c85f4035aa799ce7dd018a0d98b358ef7bc782'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4224-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4224-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4224-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4224-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '33263a4ab0f415024332bb60252fc51c9d6c3682003072cbb4456836acb19ac4',
     armv7l: '33263a4ab0f415024332bb60252fc51c9d6c3682003072cbb4456836acb19ac4',
       i686: '316393abe23f888aaef40be326a37481b63594000d0557d7f19ddf50b555ba89',
     x86_64: '4e32b1519375b8b3b2b7262e864f2ba1d4d777dda64e96bdfb2c79d82cd9914b',
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
