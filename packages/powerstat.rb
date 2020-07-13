require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'https://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.24'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.24.tar.gz'
  source_sha256 '12781cb108be1fc3be5ec893e6d025bfb40ada060bdc5f7715b65397620f2c7b'

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
