require 'package'

class Perl_module_build < Package
  description 'Module::Build - Build and install Perl modules'
  homepage 'https://metacpan.org/pod/Module::Build'
  version '0.4231-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4231.tar.gz'
  source_sha256 '7e0f4c692c1740c1ac84ea14d7ea3d8bc798b2fb26c09877229e04f430b2b717'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-1_armv7l/perl_module_build-0.4231-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-1_armv7l/perl_module_build-0.4231-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-1_i686/perl_module_build-0.4231-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_module_build/0.4231-1_x86_64/perl_module_build-0.4231-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '20d2dc51249d27c1f77b8a07b9b5a0f184e15581df486192f8b62bdda579669b',
     armv7l: '20d2dc51249d27c1f77b8a07b9b5a0f184e15581df486192f8b62bdda579669b',
       i686: '5dc94b6562c86fefa1501fc1ae895c3159a3b0449fbce685a892286d7715e11e',
     x86_64: 'e3178127a60be8154cd3f2bf57611959651e8d050ddb8b8682320e045db82cfa'
  })

  def self.build; end

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

  def self.check; end
end
