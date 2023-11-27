require 'package'

class Perl < Package
  description 'Perl 5 is a highly capable, feature-rich programming language with over 29 years of development.'
  homepage 'https://www.perl.org/'
  version '5.38.1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://www.cpan.org/src/5.0/perl-#{version}.tar.xz"
  source_sha256 '6a82c7930563086e78cb84d9c265e6b212ee65d509d19eedcd23ab8c1ba3f046'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.1_armv7l/perl-5.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.1_armv7l/perl-5.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.1_i686/perl-5.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl/5.38.1_x86_64/perl-5.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a0cb26ba85d6508457af956a5f5ffc941374737253b673cf9dc25a7d43f5595a',
     armv7l: 'a0cb26ba85d6508457af956a5f5ffc941374737253b673cf9dc25a7d43f5595a',
       i686: '9f309db6a023bc0aa9ce9f822c11154d306aa823ab7b952d6318515b47ee67e8',
     x86_64: '806722babdf990ce24239dee426996adfa7129c8120785d5499328ccee699529'
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
