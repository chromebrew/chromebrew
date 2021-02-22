require 'package'

class Perl_yaml_tiny < Package
  description 'YAML::Tiny - Read/Write YAML files with as little code as possible'
  homepage 'https://metacpan.org/pod/YAML::Tiny'
  version '1.73'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.73.tar.gz'
  source_sha256 'bc315fa12e8f1e3ee5e2f430d90b708a5dc7e47c867dba8dce3a6b8fbe257744'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_yaml_tiny-1.73-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_yaml_tiny-1.73-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_yaml_tiny-1.73-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_yaml_tiny-1.73-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b8d1b77879017165e920e68843bcf2e20c0e3f9a90c7dea79e46e61ae1599b3d',
     armv7l: 'b8d1b77879017165e920e68843bcf2e20c0e3f9a90c7dea79e46e61ae1599b3d',
       i686: '7f89638189e8940a5b96f1a105612f88649143b40ebcfca83d3c03382827f81e',
     x86_64: 'cf49cfc2fb0ad7605e6590a5ea0470420d212f64d494f9277cfd49e12b136714',
  })

  depends_on 'perl'

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
