require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.12'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.12.tar.gz'
  source_sha256 'dc802ae739120bb7c99f248f2631f14e8903767c187f2d16a093391e741e9a9a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3f98c844ffa30b00c632382a764306995acfc4973d23ed781aea6a0b90aa57a4',
     armv7l: '3f98c844ffa30b00c632382a764306995acfc4973d23ed781aea6a0b90aa57a4',
       i686: '709a23dc76aa214fb13dfe9043d6e1482e276f042b7f1c43c1d3a4690576ce4f',
     x86_64: 'c7c93f71d2d14d43431ecbd069996587e6a2650e5e96bd18abf60dcbcaa40db4',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
