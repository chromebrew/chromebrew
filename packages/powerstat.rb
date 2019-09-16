require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.20'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.20.tar.gz'
  source_sha256 '679305b3a6d2cc9820d19247e9acc1fb2fa48e96a65bc253b358ba5b0a985de3'

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
