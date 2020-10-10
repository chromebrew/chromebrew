require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version '0.4231'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4231.tar.gz'
  source_sha256 '7e0f4c692c1740c1ac84ea14d7ea3d8bc798b2fb26c09877229e04f430b2b717'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4231-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4231-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4231-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_module_build-0.4231-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b8407fa11a374de2c9a07ecae133cee6872b433872b6b3bef2a51218bf0d3c4c',
     armv7l: 'b8407fa11a374de2c9a07ecae133cee6872b433872b6b3bef2a51218bf0d3c4c',
       i686: '5c0b7f602df7ff123b58d4e6cdea0fcc019a482f06de809219f9d4fbb23e9992',
     x86_64: '71b31393762a1eaa299d3e519aa1b72f152eb405378e2d37001d62a809791a92',
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
