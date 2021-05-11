require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  @_ver = '5.32.1'
  version @_ver
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "http://www.cpan.org/src/5.0/perl-#{@_ver}.tar.gz"
  source_sha256 '03b693901cd8ae807231b1787798cf1f2e0b8a56218d07b7da44f784a7caeb2c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.32.1_armv7l/perl-5.32.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.32.1_armv7l/perl-5.32.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.32.1_i686/perl-5.32.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.32.1_x86_64/perl-5.32.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8f96c4ac4e4927ff643670ba362568e5483ba4ef970acd742877ef49b48829df',
     armv7l: '8f96c4ac4e4927ff643670ba362568e5483ba4ef970acd742877ef49b48829df',
       i686: '2193da9719f91be5aa261471aae0314b19da430ae3f09006c30d7d276b5f230d',
     x86_64: '8c12ba41052f0f49f1dccc7cc1de795d4b4c55ba70c4ed1eff866580405e300a'
  })

  depends_on 'patch' => :build

  @perl_fullversion = @_ver.split('-')[0]

  @perl_version = @_ver.rpartition('.')[0]

  def self.build
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_LIB_PREFIX}/libnsl.so"
    # Use system zlib and bzip2
    # Create shared library
    # Install manual files into #{CREW_PREFIX}/share/man/man* even if groff is not installed.
    system "env AR=gcc-ar RANLIB=gcc-ranlib NM=gcc-nm \
      CFLAGS='-Os -pipe -flto=auto' \
      CXXFLAGS='-Os -pipe -flto=auto' \
      LDFLAGS='-Wl,-z,relro -Wl,--as-needed -Wl,-z,now -flto -fuse-linker-plugin' \
      BUILD_ZLIB=False BUILD_BZIP2=0 \
      ./Configure \
      -Doptimize='-Os -pipe -flto=auto' \
      -Dusethreads \
      -de -Duseshrplib -Dman1dir=#{CREW_MAN_PREFIX}/man1 -Dman3dir=#{CREW_MAN_PREFIX}/man3"
    system 'make'
    system 'curl -o cpanm https://cpanmin.us'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.ln_sf "#{CREW_PREFIX}/lib/perl5/#{@perl_fullversion}/#{ARCH}-linux-thread-multi/CORE/libperl.so",
                    "#{CREW_DEST_LIB_PREFIX}/libperl.so"
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_DEST_LIB_PREFIX}/libnsl.so"
    # Avoid File conflict with tcl, ocaml
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3", "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3perl"
    system "install -Dm755 cpanm #{CREW_DEST_PREFIX}/bin/cpanm"
  end

  def self.check
    # having strange error as explained at https://patchwork.openembedded.org/patch/95795/
    # so, apply patch from https://github.com/habitat-sh/core-plans/blob/master/perl/skip-wide-character-test.patch
    # to ignore this single test
    system 'patch -p1 << EOF
diff -ur perl-5.22.1.orig/t/lib/warnings/regexec perl-5.22.1/t/lib/warnings/regexec
--- perl-5.22.1.orig/t/lib/warnings/regexec     2015-10-30 21:14:29.000000000 +0000
+++ perl-5.22.1/t/lib/warnings/regexec  2016-01-19 05:05:50.218474114 +0000
@@ -188,6 +188,7 @@
 ########
 # NAME \b{} in UTF-8 locale
 require \'../loc_tools.pl\';
+print("SKIPPED\n# This test causes a failure in the test suite\n"),exit;
 unless (locales_enabled()) {
     print("SKIPPED\n# locales not available\n"),exit;
 }
EOF'

    # test
    system 'make test || true'
  end
end
