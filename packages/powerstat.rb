require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.18'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.18.tar.gz'
  source_sha256 'a5be7df819c1d60edbaabde13ef09c72b1bc1375ae3cad3444f0c084abf399be'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '580801b4248153f49301319333f2a0273b551dcb550d5843521f431b66bae01b',
     armv7l: '580801b4248153f49301319333f2a0273b551dcb550d5843521f431b66bae01b',
       i686: '301234009c5d1f34bf0b615aa8a182a7864db55287465b5a09dd4de17ae0a736',
     x86_64: '6a575745233d3b6bbaa09f6c1bac28f1c3ec303b243131e77248b8f5a171628c',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
