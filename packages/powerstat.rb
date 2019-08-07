require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.19'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.19.tar.gz'
  source_sha256 '852b1685fee6dfecdafb94df24e26322b001e2ead000d25d7ecdbdd2aba0067a'

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
