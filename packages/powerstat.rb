require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.11'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.11.tar.gz'
  source_sha1 '729c5f8f4509ab13134278c8afe04cf2244d928c'

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
