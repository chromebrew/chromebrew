require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  version '5.38.0'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://www.cpan.org/src/5.0/perl-#{version}.tar.xz"
  source_sha256 'eca551caec3bc549a4e590c0015003790bdd1a604ffe19cc78ee631d51f7072e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.0_armv7l/perl-5.38.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.0_armv7l/perl-5.38.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.0_i686/perl-5.38.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.0_x86_64/perl-5.38.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4424726fdd358841c0772a04a33ba072ed5915598b718c11d7634fcf8ea713f9',
     armv7l: '4424726fdd358841c0772a04a33ba072ed5915598b718c11d7634fcf8ea713f9',
       i686: 'b0eabb7d4e61125f17395725a97392349b3ddd70c1068187a2fdc4138b52e81c',
     x86_64: '659731d2d7c3475ab531908736e1888d9dc4f50ca03a51c549346b6b01ab9d25'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'libdb' # R

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
      -Darchlib=#{CREW_LIB_PREFIX}/perl5/#{version}/core_perl \
      -Dsitelib=#{CREW_PREFIX}/share/perl5/site_perl \
      -Dsitearch=#{CREW_LIB_PREFIX}/perl5/#{version}/site_perl \
      -Dvendorlib=#{CREW_PREFIX}/share/perl5/vendor_perl \
      -Dvendorarch=#{CREW_LIB_PREFIX}/perl5/#{version}/vendor_perl \
      -Dcc=#{CREW_TGT}-gcc \
      -Doptimize='#{CREW_COMMON_FLAGS}' \
      -Dlldlflags='-shared #{CREW_LDFLAGS}' -Dldflags='#{CREW_LDFLAGS}' \
      -Dusethreads \
      -Dinstallusrbinperl=n \
      -Duseshrplib -Dman1dir=#{CREW_MAN_PREFIX}/man1 -Dman3dir=#{CREW_MAN_PREFIX}/man3"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Make libperl symlinks into standard locations
    libperl_so = "#{CREW_LIB_PREFIX}/perl5/#{version.split('-')[0]}/core_perl/CORE/libperl.so"
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so.#{version}" # e.g., libperl.so.5.34.1
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so.#{version.sub(/\.\d$/, '')}" # e.g., libperl.so.5.34
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so#{version.sub(/\.\d\.\d$/, '')}" # e.g., libperl.so.5
    FileUtils.ln_sf libperl_so, "#{CREW_DEST_LIB_PREFIX}/libperl.so" # e.g., libperl.so
    # Consider adding this symlink to the glibc package
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_DEST_LIB_PREFIX}/libnsl.so"
    # Avoid File conflict with tcl, ocaml
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3", "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3perl"
  end

  def self.check
    system "make test -j #{CREW_NPROC} || true"
  end
end
