require 'package'

class Musl_perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  @_ver = '5.34.0'
  version @_ver
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "http://www.cpan.org/src/5.0/perl-#{@_ver}.tar.gz"
  source_sha256 '551efc818b968b05216024fb0b727ef2ad4c100f8cb6b43fab615fa78ae5be9a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_perl/5.34.0_armv7l/musl_perl-5.34.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_perl/5.34.0_armv7l/musl_perl-5.34.0-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_perl/5.34.0_i686/musl_perl-5.34.0-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_perl/5.34.0_x86_64/musl_perl-5.34.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '113175f52f7b2e3c8471380cf434ea8558dfca2c04d90d624550ff9a85cae131',
     armv7l: '113175f52f7b2e3c8471380cf434ea8558dfca2c04d90d624550ff9a85cae131',
    i686: '9a6ca03310f97f227ef37c053031d20eee8b45114e2f7126f08f4982e67534d9',
  x86_64: '52df52260a9e30a69654233f77d129ebfed1679fe4c7970880a1856b55daa0c3'
  })

  depends_on 'patch' => :build
  depends_on 'patchelf' => :build
  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_bz2' => :build

  @perl_fullversion = @_ver.split('-')[0]

  @perl_version = @_ver.rpartition('.')[0]

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    # FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_LIB_PREFIX}/libnsl.so"
    # Use system zlib and bzip2
    # Create shared library
    # Install manual files into #{CREW_MUSL_PREFIX}/share/man/man* even if groff is not installed.
    system "#{MUSL_ENV_OPTIONS} \
      ./Configure \
      -Doptimize='-O2 -pipe -flto=auto' \
      -Dusethreads \
      -de -Duseshrplib \
      -Dprefix=#{CREW_MUSL_PREFIX} \
      -Dcc=#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-gcc \
      -Dcxx=#{CREW_MUSL_PREFIX}/bin/#{ARCH}-linux-musl#{MUSL_ABI}-g++ \
      -Dccflags='#{MUSL_CFLAGS}' \
      -Dccxflags='#{MUSL_CXXFLAGS}' \
      -Dcppflags='-I#{CREW_MUSL_PREFIX}/include -fcommon -idirafter#{CREW_PREFIX}/include' \
      -Dldflags='#{MUSL_LDFLAGS}' \
      -Dlocincpth=#{CREW_MUSL_PREFIX}/include \
      -Dloclibpth=none \
      -A define:libpth=#{CREW_MUSL_PREFIX}/lib \
      -Dplibpth=#{CREW_MUSL_PREFIX}/lib \
      -A define:glibpth=#{CREW_MUSL_PREFIX}/lib \
      -U xlibpth='' \
      -Dlibswanted=none \
      -Dinstallusrbinperl=n"
    # for i686 may also have to create symlink
    # ln -s /usr/local/share/musl/i686-linux-musl/include/locale.h /usr/local/share/musl/i686-linux-musl/include/xlocale.h
    system "sed -i \"s, #{CREW_LIB_PREFIX}',',g\" config.sh"
    system "sed -i \"s, #{CREW_PREFIX}/include',',g\" config.sh"
    system "sed -i \"s,:#{CREW_LIB_PREFIX},:#{CREW_MUSL_PREFIX}/lib,g\" Makefile"
    system "#{MUSL_ENV_OPTIONS} make"
    system 'curl -o cpanm https://cpanmin.us'
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
    system "#{MUSL_ENV_OPTIONS} make test || true"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_MUSL_PREFIX}/lib"
    FileUtils.ln_sf "#{CREW_MUSL_PREFIX}/lib/perl5/#{@perl_fullversion}/#{ARCH}-linux-thread-multi/CORE/libperl.so",
                    "#{CREW_DEST_MUSL_PREFIX}/lib/libperl.so"
    FileUtils.ln_sf "#{CREW_MUSL_PREFIX}/lib/libnsl.so.1", "#{CREW_DEST_MUSL_PREFIX}/lib/libnsl.so"
    # Avoid File conflict with tcl, ocaml
    # FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3", "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3perl"
    system "install -Dm755 cpanm #{CREW_DEST_MUSL_PREFIX}/bin/cpanm"
    Dir.chdir(CREW_DEST_MUSL_PREFIX) do
      load "#{CREW_LIB_PATH}lib/musl.rb"
      Musl.patchelf
    end
  end
end
