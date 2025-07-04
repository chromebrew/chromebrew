require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  version '5.42.0'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://www.cpan.org/src/5.0/perl-#{version}.tar.xz"
  source_sha256 '73cf6cc1ea2b2b1c110a18c14bbbc73a362073003893ffcedc26d22ebdbdd0c3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d92a28300b6bbf662ede94eef2fa3af8b9356335475d2de1711185ea087f2e6',
     armv7l: '0d92a28300b6bbf662ede94eef2fa3af8b9356335475d2de1711185ea087f2e6',
       i686: '9473686b2d94a013b3e2b6e0055ca2be670666b9fd80f3047b9e116c69a4f9fe',
     x86_64: '96feb4852d26fba0b9ff1cde5aad3562cff9efa0de09cc0199018ce9bd1ff7e8'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'libdb' # R
  depends_on 'libxcrypt' # R

  def self.build
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_LIB_PREFIX}/libnsl.so"
    # Use system zlib and bzip2
    # Create shared library
    # Install manual files into #{CREW_PREFIX}/share/man/man* even if groff is not installed.
    @perl_ver = version.split(/\.([^.]*)$/).first
    system "AR=gcc-ar RANLIB=gcc-ranlib NM=gcc-nm \
      BUILD_ZLIB=False BUILD_BZIP2=0 \
      ./Configure \
      -de \
      -Dprefix=#{CREW_PREFIX} \
      -Dvendorprefix=#{CREW_PREFIX} \
      -Dprivlib=#{CREW_PREFIX}/share/perl5/core_perl \
      -Darchlib=#{CREW_LIB_PREFIX}/perl5/#{@perl_ver}/core_perl \
      -Dsitelib=#{CREW_PREFIX}/share/perl5/site_perl \
      -Dsitearch=#{CREW_LIB_PREFIX}/perl5/#{@perl_ver}/site_perl \
      -Dvendorlib=#{CREW_PREFIX}/share/perl5/vendor_perl \
      -Dvendorarch=#{CREW_LIB_PREFIX}/perl5/#{@perl_ver}/vendor_perl \
      -Dcc=#{CREW_TARGET}-gcc \
      -Doptimize='#{CREW_COMMON_FLAGS}' \
      -Dlldlflags='-shared #{CREW_LINKER_FLAGS}' -Dldflags='#{CREW_LINKER_FLAGS}' \
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
    # FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libnsl.so.1", "#{CREW_DEST_LIB_PREFIX}/libnsl.so"
    # Avoid File conflict with tcl, ocaml
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3", "#{CREW_DEST_MAN_PREFIX}/man3/Thread.3perl"
  end

  def self.check
    system "make test -j #{CREW_NPROC} || true"
  end
end
