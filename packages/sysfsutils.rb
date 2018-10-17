require 'package'

class Sysfsutils < Package
  description 'These are a set of utilites built upon sysfs, a new virtual filesystem in Linux kernel versions 2.5+ that exposes a system\'s device tree. The current version of sysfsutils includes libsysfs and systool.'
  homepage 'http://linux-diag.sourceforge.net/Sysfsutils.html'
  version '2.1.0'
  source_url 'https://sourceforge.net/projects/linux-diag/files/sysfsutils/2.1.0/sysfsutils-2.1.0.tar.gz'
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
