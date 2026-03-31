require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  version '5.42.2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://www.cpan.org/src/5.0/perl-#{version}.tar.xz"
  source_sha256 '0a585eeb9e363c0f80482ddb3571625250c2c86aeb408853e8ea50805cfb14bb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c53427ee0d6078b54b29b6a1766207aae1a3894ced42d2f3ab5e90febe8a59a',
     armv7l: '6c53427ee0d6078b54b29b6a1766207aae1a3894ced42d2f3ab5e90febe8a59a',
       i686: '6d60f1b474ed9455a7323bc0e9e0f72e0b48eac7806036d8de3987aa730380c6',
     x86_64: '872c4c9525102ffdcd6fda7c36136bfd43987f1aaac106882288888d44cd8bcf'
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
