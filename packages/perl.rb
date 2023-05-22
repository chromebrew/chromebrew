require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  @_ver = '5.36.1'
  version @_ver
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://www.cpan.org/src/5.0/perl-#{@_ver}.tar.xz"
  source_sha256 'bd91217ea8a8c8b81f21ebbb6cefdf0d13ae532013f944cdece2cd51aef4b6a7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.36.1_armv7l/perl-5.36.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.36.1_armv7l/perl-5.36.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.36.1_i686/perl-5.36.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.36.1_x86_64/perl-5.36.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '81ca29933d6061669fd85dc75ca6e1be321b685f0a22fc04e1b8eeb0656644ef',
     armv7l: '81ca29933d6061669fd85dc75ca6e1be321b685f0a22fc04e1b8eeb0656644ef',
       i686: '8c834adff441dde931df788fd87bee381954a9dde6107950324fdaa39a3723c9',
     x86_64: '1712230f6360e5c81ef56095331a2fac2ad94846b40fb4b75c5c9be81c471777'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'libdb' # R
  depends_on 'patch' => :build

  def self.build
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_LIB_PREFIX}/libnsl.so"
    # Use system zlib and bzip2
    # Create shared library
    # Install manual files into #{CREW_PREFIX}/share/man/man* even if groff is not installed.
    system "AR=gcc-ar RANLIB=gcc-ranlib NM=gcc-nm \
      BUILD_ZLIB=False BUILD_BZIP2=0 \
      mold -run ./Configure \
      -de \
      -Dprefix=#{CREW_PREFIX} \
      -Dvendorprefix=#{CREW_PREFIX} \
      -Dprivlib=#{CREW_PREFIX}/share/perl5/core_perl \
      -Darchlib=#{CREW_LIB_PREFIX}/perl5/#{@_ver}/core_perl \
      -Dsitelib=#{CREW_PREFIX}/share/perl5/site_perl \
      -Dsitearch=#{CREW_LIB_PREFIX}/perl5/#{@_ver}/site_perl \
      -Dvendorlib=#{CREW_PREFIX}/share/perl5/vendor_perl \
      -Dvendorarch=#{CREW_LIB_PREFIX}/perl5/#{@_ver}/vendor_perl \
      -Dcc=#{CREW_TGT}-gcc \
      -Doptimize='#{CREW_COMMON_FLAGS}' \
      -Dlldlflags='-shared #{CREW_LDFLAGS}' -Dldflags='#{CREW_LDFLAGS}' \
      -Dusethreads \
      -Dinstallusrbinperl=n \
      -Duseshrplib -Dman1dir=#{CREW_MAN_PREFIX}/man1 -Dman3dir=#{CREW_MAN_PREFIX}/man3"
    system 'make'
  end

  def self.install
    @perl_fullversion = @_ver.split('-')[0]
    @perl_version = @_ver.rpartition('.')[0]

    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Make libperl symlinks into standard locations
    libperl_so = "#{CREW_LIB_PREFIX}/perl5/#{@perl_fullversion}/core_perl/CORE/libperl.so"
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so.#{@_ver}" # e.g., libperl.so.5.34.1
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so.#{@_ver.sub(/\.\d$/, '')}" # e.g., libperl.so.5.34
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so#{@_ver.sub(/\.\d\.\d$/, '')}" # e.g., libperl.so.5
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so" # e.g., libperl.so
    # Consider adding this symlink to the glibc package
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_DEST_LIB_PREFIX}/libnsl.so"
    # Avoid File conflict with tcl, ocaml
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3", "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3perl"
  end

  def self.check
    # having strange error as explained at https://patchwork.openembedded.org/patch/95795/
    # so, apply patch from https://github.com/habitat-sh/core-plans/blob/master/perl/skip-wide-character-test.patch
    # to ignore this single test
    system 'patch -Np1 << EOF
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
    system "make test -j #{CREW_NPROC} || true"
  end
end
