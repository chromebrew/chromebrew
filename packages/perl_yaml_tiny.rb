require 'package'

class Perl_yaml_tiny < Package
  description 'YAML::Tiny - Read/Write YAML files with as little code as possible'
  homepage 'https://metacpan.org/pod/YAML::Tiny'
  version '1.73-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.73.tar.gz'
  source_sha256 'bc315fa12e8f1e3ee5e2f430d90b708a5dc7e47c867dba8dce3a6b8fbe257744'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.73-2_armv7l/perl_yaml_tiny-1.73-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.73-2_armv7l/perl_yaml_tiny-1.73-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.73-2_i686/perl_yaml_tiny-1.73-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_yaml_tiny/1.73-2_x86_64/perl_yaml_tiny-1.73-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e81f1c52c71e2c0557a8b5f935c4d55b4820b35d8564624b3008dbe124ea6bb1',
     armv7l: 'e81f1c52c71e2c0557a8b5f935c4d55b4820b35d8564624b3008dbe124ea6bb1',
       i686: 'd7f605c0c4c9cae7851f6647ec6513e0e0f400113cbd4236c3801b083d27eef6',
     x86_64: 'a530bb292e61f1bd709b94fec1414d44f0b70656493fcb061ae1efac00444428'
  })

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

  def self.check; end
end
