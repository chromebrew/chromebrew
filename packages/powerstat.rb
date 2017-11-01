require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.14'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.14.tar.gz'
  source_sha256 '79b059d12dc776f7f47d3bef0b1c60185a0ba49765d1c89e920fa2f24a081711'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
