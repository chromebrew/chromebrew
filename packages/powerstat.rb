require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.19'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.19.tar.gz'
  source_sha256 '852b1685fee6dfecdafb94df24e26322b001e2ead000d25d7ecdbdd2aba0067a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '82b03fcaaf4d9514d5d2b0b79ca8b0a30f77b7200f04d8b65f31a9424aaa76e3',
     armv7l: '82b03fcaaf4d9514d5d2b0b79ca8b0a30f77b7200f04d8b65f31a9424aaa76e3',
       i686: '1d9dd6d3eea415239ed9b63aaa9d99d165043a27be658045d429c1f151575e0b',
     x86_64: '529abe4996de70c92ecefea592a1d2008a56f36cdc49f672358e8e14640e36cb',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
