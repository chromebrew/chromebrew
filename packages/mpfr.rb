require 'package'

class Mpfr < Package
  description 'The MPFR library is a C library for multiple-precision floating-point computations with correct rounding.'
  homepage 'http://www.mpfr.org/'
  version '4.1.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'http://www.mpfr.org/mpfr-current/mpfr-4.1.0.tar.xz'
  source_sha256 '0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '02fc4dce2dfade4e7cb7ca539ddcf8142c1cb8839c9a1f83e5362e8f00f7a1e8',
     armv7l: '02fc4dce2dfade4e7cb7ca539ddcf8142c1cb8839c9a1f83e5362e8f00f7a1e8',
       i686: '2950b94cbcbcb11b0bb34a6e31d7e6e9982eb74d37edd73a17a3700c2b6abe41',
     x86_64: 'a7e0a584a6d54b852d4869ef3ba8f9fdb076f48d6d3f2cb1f46842bc8975583a'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'hashpipe' => :build
  depends_on 'glibc' # R
  depends_on 'gmp' # R

  def self.patch
    puts 'Applying current rolling patchset. See https://www.mpfr.org/mpfr-current/#bugs'
    puts 'for more information.'
    system 'curl -Ls "https://gforge.inria.fr/scm/viewvc.php/mpfr/misc/www/mpfr-4.1.0/allpatches?revision=14491&view=co" | \
      hashpipe sha256 dfa7d8a14ec7cb3b344cb81cfd7bd7e22aba62379941cc9110759f11172ac013 | patch -NZp1 --binary'
  end

  def self.build
    system 'filefix'
    system 'autoreconf -fiv'
    system "./configure \
      #{CREW_OPTIONS} \
      --enable-shared"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libmpfr.so.6 #{CREW_DEST_LIB_PREFIX}/libmpfr.so.4"
  end

  def self.check
    # Check only works after an install on x86_64
    system "LD_LIBRARY_PATH=\$(pwd)/src/.libs:\$LD_LIBRARY_PATH make check"
  end
end
