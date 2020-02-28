require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.22'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.22.tar.gz'
  source_sha256 'ef74e023353a24a0a52068a0e474041b9556bcef5b4fe41db44261afd32a6564'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
