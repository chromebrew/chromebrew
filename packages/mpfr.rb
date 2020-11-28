require 'package'

class Mpfr < Package
  description 'The MPFR library is a C library for multiple-precision floating-point computations with correct rounding.'
  homepage 'https://www.mpfr.org/'
  version '4.1.0'
  compatibility 'all'
  source_url 'https://www.mpfr.org/mpfr-current/mpfr-4.1.0.tar.xz'
  source_sha256 '0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f'

  def self.build
    system "./configure", # don't use CREW_OPTIONS as --libdir will cause error
           "--prefix=#{CREW_PREFIX}",
           "--build=`uname -m`-cros-linux-gnu", 
           "--host=`uname -m`-cros-linux-gnu",
           "--target=`uname -m`-cros-linux-gnu/lib/libmpfr.so.6.1.0",
           "--disable-static",
           "--enable-shared"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libmpfr.so.6 #{CREW_DEST_LIB_PREFIX}/libmpfr.so.4"
  end

  def self.check
    system "make", "check"
  end
end
