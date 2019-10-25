require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.20'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.20.tar.gz'
  source_sha256 '679305b3a6d2cc9820d19247e9acc1fb2fa48e96a65bc253b358ba5b0a985de3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '40781457dd33d5bbf4372dec0b0f23544e04c8545b54a6734e135ca3502c0e65',
     armv7l: '40781457dd33d5bbf4372dec0b0f23544e04c8545b54a6734e135ca3502c0e65',
       i686: 'a64eb0f7eef06b749f0ca89905e731102763e6bd1f7373a708664da5978df748',
     x86_64: 'b345616591b185396594420bb43f193b56c450a964c847302ef5e72538ec7d5e',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
