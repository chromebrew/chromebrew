require 'package'

class Sysfsutils < Package
  description 'Libsysfs provides a stable programming interface to sysfs and eases querying system devices and their attributes.'
  homepage 'https://github.com/Distrotech/sysfsutils'
  version '2.1.0'
  source_url 'http://http.debian.net/debian/pool/main/s/sysfsutils/sysfsutils_2.1.0+repack.orig.tar.gz'
  source_sha256 'e865de2c1f559fff0d3fc936e660c0efaf7afe662064f2fb97ccad1ec28d208a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
