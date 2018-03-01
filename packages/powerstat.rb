require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.14'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.14.tar.gz'
  source_sha256 '79b059d12dc776f7f47d3bef0b1c60185a0ba49765d1c89e920fa2f24a081711'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4ea5f8f48a1180b348dc90b150f7a97c9cb0e0289ac4b093b01ef8f087853dd0',
     armv7l: '4ea5f8f48a1180b348dc90b150f7a97c9cb0e0289ac4b093b01ef8f087853dd0',
       i686: '5c3cfbba81c9adf2010b2f9e69dd5adcaa96cdf15446eabfcc1a80e0ce2160be',
     x86_64: '81b9ad7bfdf9bcc6c95148a4d8216f0105a0a54ed31419bb637eeb374901afd5',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
