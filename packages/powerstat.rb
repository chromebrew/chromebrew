require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.11'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.11.tar.gz'
  source_sha256 'a274a7762c44695129434bab2ff10a23575ecb0c1199eb6e424e1324c61a2d46'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f8f376c8d5af62036e7295b67ebe1a7b9fa85fb760572746c3488cdb747489b8',
     armv7l: 'f8f376c8d5af62036e7295b67ebe1a7b9fa85fb760572746c3488cdb747489b8',
       i686: 'ea7960849f28a7bee8308eb3626e489aeffebdcac4687bc5ca27e0a155c56557',
     x86_64: '99018fc23068465e40ab3c4ab8753fc7004d7abef120b328af1521b6b5856eb2',
  })

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
